local FILTER_DIR = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])") or "./"
local VERSION = "0.5.0"

local cell_mod = dofile(FILTER_DIR .. "cell.lua")
local chrome = dofile(FILTER_DIR .. "chrome.lua")
local engine = dofile(FILTER_DIR .. "engine.lua")
local theme = dofile(FILTER_DIR .. "theme.lua")
theme.init(FILTER_DIR)

local ENGINE = engine.find(FILTER_DIR)



local cache = dofile(FILTER_DIR .. "cache.lua")
local config_mod = dofile(FILTER_DIR .. "config.lua")

local extract_config = config_mod.extract_config

local function is_term_block(block)
  if block.t ~= "CodeBlock" then
    return false
  end
  for _, cls in ipairs(block.classes) do
    if cls == "term" or cls == "{term}" then
      return true
    end
  end
  return false
end



local build_cell = cell_mod.build_cell

local function deep_merge_meta(base, override)
  for k, v in pairs(override) do
    base[k] = v
  end
  return base
end

local function load_project_term_meta()
  if not (quarto and quarto.project and quarto.project.directory) then
    return nil
  end
  local path = quarto.project.directory .. "/_quarto.yml"
  local f = io.open(path, "r")
  if not f then return nil end
  local content = f:read("*a")
  f:close()
  local ok, parsed = pcall(pandoc.read, "---\n" .. content .. "\n---\n", "markdown")
  if not ok or not parsed then return nil end
  return parsed.meta
    and parsed.meta["extensions"]
    and parsed.meta["extensions"]["term"]
end

function Pandoc(doc)
  local doc_term = doc.meta
    and doc.meta["extensions"]
    and doc.meta["extensions"]["term"]
  if doc_term then
    local proj_term = load_project_term_meta()
    if proj_term then
      local merged = deep_merge_meta(proj_term, doc_term)
      doc.meta["extensions"]["term"] = merged
    end
  end

  local config = extract_config(doc.meta)

  if quarto and quarto.doc and quarto.doc.is_format then
    if quarto.doc.is_format("pdf") or quarto.doc.is_format("latex") then
      config.format = "latex"
    elseif quarto.doc.is_format("typst") then
      config.format = "typst"
    elseif quarto.doc.is_format("gfm") or quarto.doc.is_format("markdown") then
      config.format = "markdown"
    end
  end

  -- Determine format key for style overrides
  local fmt_key = config.format
  if fmt_key == "latex" then fmt_key = "pdf" end
  if quarto and quarto.doc and quarto.doc.is_format and quarto.doc.is_format("revealjs") then
    fmt_key = "revealjs"
  elseif quarto and quarto.doc and quarto.doc.is_format and quarto.doc.is_format("epub") then
    fmt_key = "epub"
  end
  config._fmt_key = fmt_key

  -- Resolve format-specific style overrides
  if config._style_overrides then
    local ov = config._style_overrides[fmt_key]
    if ov then
      if ov.colorscheme then config._colorscheme = ov.colorscheme end
      if ov.colorscheme_light then config._colorscheme_light = ov.colorscheme_light end
      if ov.colorscheme_dark then config._colorscheme_dark = ov.colorscheme_dark end
      if ov.font_family then config.font_family = ov.font_family end
      if ov.font_size then config.font_size = ov.font_size end
      if ov.line_height then config.line_height = ov.line_height end
      if ov.trailing_spaces ~= nil then config.trailing_spaces = ov.trailing_spaces end
      if ov.ansi ~= nil then config.ansi = ov.ansi end
      if ov.spacing ~= nil then config.spacing = ov.spacing end
      if ov.cols then config.cols = ov.cols end
      if ov.rows then config.rows = ov.rows end
    end
    config._style_overrides = nil
  end

  -- Resolve colorscheme colors for Rust
  local _colorscheme = config._colorscheme
  local _colorscheme_light = config._colorscheme_light
  local _colorscheme_dark = config._colorscheme_dark
  config._colorscheme = nil
  config._colorscheme_light = nil
  config._colorscheme_dark = nil

  if _colorscheme then
    local colorscheme_bg, colorscheme_fg = theme.read_colors(_colorscheme)
    if colorscheme_bg then config.colorscheme_bg = colorscheme_bg end
    if colorscheme_fg then config.colorscheme_fg = colorscheme_fg end
  elseif _colorscheme_light then
    local colorscheme_bg, colorscheme_fg = theme.read_colors(_colorscheme_light)
    if colorscheme_bg then config.colorscheme_bg = colorscheme_bg end
    if colorscheme_fg then config.colorscheme_fg = colorscheme_fg end
  end

  -- These fields are only used in Lua; remove before sending to Rust
  local _marker = config.marker
  local _chrome = config._chrome
  local _cache = config._cache
  config.marker = nil
  config._cache = nil
  config._chrome = nil

  local term_positions = {}
  local cells = {}

  for i, block in ipairs(doc.blocks) do
    if is_term_block(block) then
      -- Pass config with marker still set so build_cell can use it
      config.marker = _marker
      local cell = build_cell(block, 0, config)
      config.marker = nil
      local cell_eval = cell._eval
      local cell_include = cell._include
      local cell_colorscheme = cell._colorscheme
      local cell_colorscheme_light = cell._colorscheme_light
      local cell_colorscheme_dark = cell._colorscheme_dark
      local cell_chrome = cell._chrome
      if cell_chrome == nil then cell_chrome = _chrome end
      cell._eval = nil
      cell._include = nil
      cell._colorscheme = nil
      cell._colorscheme_light = nil
      cell._colorscheme_dark = nil
      cell._chrome = nil
      -- For non-HTML formats, resolve cell colorscheme to bg/fg colors
      if cell_colorscheme and config.format ~= "html" then
        local bg, fg = theme.read_colors(cell_colorscheme)
        if bg then cell.options.colorscheme_bg = bg end
        if fg then cell.options.colorscheme_fg = fg end
      end
      if cell_eval then
        local cell_id = #cells + 1
        cell.id = cell_id
        table.insert(cells, cell)
        table.insert(term_positions, {
          block_i = i, cell_i = cell_id, include = cell_include,
          colorscheme = cell_colorscheme,
          colorscheme_light = cell_colorscheme_light,
          colorscheme_dark = cell_colorscheme_dark,
          chrome = cell_chrome,
        })
      else
        -- Strip #| option lines from the code block
        block.text = cell.code
        block.classes = {"bash"}
        doc.blocks[i] = block
      end
    end
  end

  config._fmt_key = nil

  if #cells == 0 then
    return nil
  end

  -- Ensure arrays are encoded as JSON arrays, not objects
  if #config.shell_args == 0 then
    config.shell_args = pandoc.List({})
  end
  if not config.init or #config.init == 0 then
    config.init = pandoc.List({})
  end
  if not config.record or #config.record == 0 then
    config.record = pandoc.List({})
  end
  local env_record = os.getenv("QUARTO_TERM_RECORD")
  if env_record and env_record ~= "" and env_record ~= "1" then
    table.insert(config.record, env_record)
  end
  if config.docker then
    if not config.docker.ports or #config.docker.ports == 0 then
      config.docker.ports = pandoc.List({})
    end
    if not config.docker.volumes or #config.docker.volumes == 0 then
      config.docker.volumes = pandoc.List({})
    end
    if not config.docker.args or #config.docker.args == 0 then
      config.docker.args = pandoc.List({})
    end
  end
  for _, cell in ipairs(cells) do
    if #cell.line_options == 0 then
      cell.line_options = pandoc.List({})
    end
    if #cell.source_lines == 0 then
      cell.source_lines = pandoc.List({})
    end
    if #cell.options.callout == 0 then
      cell.options.callout = pandoc.List({})
    end
    if #cell.options.remove == 0 then
      cell.options.remove = pandoc.List({})
    end
    if #cell.options.truncate == 0 then
      cell.options.truncate = pandoc.List({})
    end
  end

  local request = {
    config = config,
    cells = cells,
  }

  local input_json = pandoc.json.encode(request)

  local results = cache.run(input_json, {
    cache = _cache,
    engine = ENGINE,
    verbose = config.verbose,
    version = VERSION,
  })
  if not results then return nil end

  local raw_format = "html"
  if config.format == "latex" then
    raw_format = "latex"
  elseif config.format == "typst" then
    raw_format = "typst"
  elseif config.format == "markdown" then
    raw_format = "markdown"
  end

  local cell_theme_css = {}

  for _, pos in ipairs(term_positions) do
    local result = results[pos.cell_i]
    if result then
      if result.error and result.error ~= pandoc.json.null and result.error ~= "" then
        io.stderr:write("quarto-term: cell " .. pos.cell_i .. " error: " .. tostring(result.error) .. "\n")
        if os.getenv("QUARTO_TERM_CHECK") then
          error("quarto-term check: assertion failed in cell " .. pos.cell_i)
        end
      end
      if pos.include == false then
        doc.blocks[pos.block_i] = pandoc.RawBlock(raw_format, "")
      else
        local content = result.markup
        if type(content) == "string" and content ~= "" then
          if pos.colorscheme and raw_format == "html" then
            local scope_class = "term-theme-" .. pos.colorscheme
            content = "<div class=\"" .. scope_class .. "\">\n" .. content .. "</div>\n"
            if not cell_theme_css[pos.colorscheme] then
              local css = theme.read_file(pos.colorscheme)
              if css then
                cell_theme_css[pos.colorscheme] = theme.rescope_css(css, "." .. scope_class)
              end
            end
          elseif pos.colorscheme_light and raw_format == "html" then
            local scope_class = "term-theme-cell-" .. pos.cell_i
            content = "<div class=\"" .. scope_class .. "\">\n" .. content .. "</div>\n"
            local key = (pos.colorscheme_light or "") .. "|" .. (pos.colorscheme_dark or "")
            if not cell_theme_css[key] then
              local scoped = ""
              local light_css = theme.read_file(pos.colorscheme_light)
              if light_css then
                scoped = scoped .. theme.rescope_css(light_css, "body.quarto-light ." .. scope_class)
              end
              if pos.colorscheme_dark then
                local dark_css = theme.read_file(pos.colorscheme_dark)
                if dark_css then
                  scoped = scoped .. "\n" .. theme.rescope_css(dark_css, "body.quarto-dark ." .. scope_class)
                end
              end
              if scoped ~= "" then
                cell_theme_css[key] = scoped
              end
            end
          end
          if pos.chrome and raw_format == "html" then
            local chrome_cfg = chrome.normalize(pos.chrome)
            if chrome_cfg then
              content = chrome.wrap(content, chrome_cfg)
            end
          end
          doc.blocks[pos.block_i] = pandoc.RawBlock(raw_format, content)
        else
          doc.blocks[pos.block_i] = pandoc.RawBlock(raw_format, "")
        end
      end
    end
  end

  if os.getenv("QUARTO_TERM_CHECK") then
    local assertions = {}
    for _, pos in ipairs(term_positions) do
      local result = results[pos.cell_i]
      if result and result.recorded_assertions then
        for _, ra in ipairs(result.recorded_assertions) do
          table.insert(assertions, {
            cell_id = pos.cell_i,
            line_index = ra.line_index,
            output = ra.output,
          })
        end
      end
    end
    if #assertions > 0 then
      local input_files = PANDOC_STATE and PANDOC_STATE.input_files
      local src = input_files and input_files[1] and pandoc.utils.stringify(input_files[1])
        or "document"
      local sidecar = src:gsub("%.[^.]+$", "") .. ".assertions.json"
      local sf = io.open(sidecar, "w")
      if sf then
        sf:write(pandoc.json.encode(assertions))
        sf:close()
        io.stderr:write("quarto-term: recorded assertions to " .. sidecar .. "\n")
      end
    end
  end

  if config.format == "latex" then
    if quarto and quarto.doc and quarto.doc.include_text then
      local preamble = "\\usepackage[HTML]{xcolor}\n\\usepackage{tcolorbox}\n\\usepackage{fvextra}\n"
      if config.font_family then
        preamble = preamble .. "\\usepackage{fontspec}\n"
      end
      if config.colorscheme_bg then
        preamble = preamble .. "\\definecolor{termbg}{HTML}{" .. config.colorscheme_bg .. "}\n"
      end
      if config.colorscheme_fg then
        preamble = preamble .. "\\definecolor{termfg}{HTML}{" .. config.colorscheme_fg .. "}\n"
      end
      quarto.doc.include_text("in-header", preamble)
    end
  elseif config.format == "typst" then
    -- No special header dependencies needed for typst
  elseif config.format == "markdown" then
    -- No special header dependencies needed for markdown/GFM
  else
    local is_epub = quarto and quarto.doc and quarto.doc.is_format and quarto.doc.is_format("epub")

    if is_epub then
      -- EPUB: inject CSS inline as a RawBlock since add_html_dependency doesn't work
      local css_parts = {}
      local filter_dir = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])") or "./"
      local f = io.open(filter_dir .. "term.css", "r")
      if f then
        table.insert(css_parts, f:read("*a"))
        f:close()
      end
      if _colorscheme then
        local theme_css = theme.read_file(_colorscheme)
        if theme_css then table.insert(css_parts, theme_css) end
      elseif _colorscheme_light then
        local light_css = theme.read_file(_colorscheme_light)
        if light_css then table.insert(css_parts, light_css) end
      end
      for _, css in pairs(cell_theme_css) do
        table.insert(css_parts, css)
      end
      if #css_parts > 0 then
        -- Insert style block before the first term block
        local style_block = pandoc.RawBlock("html", "<style>\n" .. table.concat(css_parts, "\n") .. "</style>")
        table.insert(doc.blocks, 1, style_block)
      end
    elseif quarto and quarto.doc and quarto.doc.add_html_dependency then
      quarto.doc.add_html_dependency({
        name = "quarto-term",
        version = VERSION,
        stylesheets = { "term.css" },
      })

      if _colorscheme_light and _colorscheme_dark then
        local light_css = theme.read_file(_colorscheme_light)
        local dark_css = theme.read_file(_colorscheme_dark)
        local scoped = ""
        if light_css then
          scoped = scoped .. theme.rescope_css(light_css, "body.quarto-light")
        end
        if dark_css then
          scoped = scoped .. "\n" .. theme.rescope_css(dark_css, "body.quarto-dark")
        end
        if scoped ~= "" then
          quarto.doc.include_text("in-header", "<style>\n" .. scoped .. "</style>")
        end
      elseif _colorscheme then
        quarto.doc.add_html_dependency({
          name = "quarto-term-theme",
          version = VERSION,
          stylesheets = { "themes/" .. _colorscheme .. ".css" },
        })
      end

      -- Inject per-cell theme CSS
      local cell_css_parts = {}
      for _, css in pairs(cell_theme_css) do
        table.insert(cell_css_parts, css)
      end
      if #cell_css_parts > 0 then
        quarto.doc.include_text("in-header", "<style>\n" .. table.concat(cell_css_parts, "\n") .. "</style>")
      end

      local js_file = io.open(FILTER_DIR .. "copy-button.js", "r")
      if js_file then
        local js = js_file:read("*a")
        js_file:close()
        quarto.doc.include_text("after-body", "<script>\n" .. js .. "</script>")
      end
    end
  end

  if config.record and #config.record > 0 and quarto and quarto.doc then
    local output_file = quarto.doc.output_file
    if output_file then
      local output_dir = output_file:match("(.*[/\\])") or "./"
      for _, path in ipairs(config.record) do
        local basename = path:match("([^/\\]+)$") or path
        local src_f = io.open(path, "rb")
        if src_f then
          local content = src_f:read("*a")
          src_f:close()
          local dst_f = io.open(output_dir .. basename, "wb")
          if dst_f then
            dst_f:write(content)
            dst_f:close()
          end
        end
      end
    end
  end

  return doc
end
