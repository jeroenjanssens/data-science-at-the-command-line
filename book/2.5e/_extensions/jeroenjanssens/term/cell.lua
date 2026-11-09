local M = {}

local function escape_pattern(s)
  return s:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1")
end

local function coerce_value(s)
  s = s:match("^%s*(.-)%s*$")
  if s == "true" then return true end
  if s == "false" then return false end
  local n = tonumber(s)
  if n then return n end
  s = s:gsub('^"(.*)"$', "%1")
  s = s:gsub("^'(.*)'$", "%1")
  return s
end

local function as_list(val)
  if type(val) == "table" then return val end
  if type(val) == "number" then return {val} end
  if type(val) == "string" then
    local items = {}
    for item in val:gmatch("[^,]+") do
      table.insert(items, coerce_value(item))
    end
    return items
  end
  return {}
end

function M.parse_cell_options(text, line_marker)
  local cell_opts = {}
  local code_lines = {}
  local in_options = true

  local nest_stack = {}

  for line in text:gmatch("([^\n]*)\n?") do
    if in_options and line:match("^#|%s*") then
      local content = line:match("^#| (.*)$") or line:match("^#|(.*)$")
      local indent = #(content:match("^(%s*)") or "")
      local trimmed = content:match("^%s*(.-)%s*$")

      if #nest_stack > 0 and indent == 0 then
        nest_stack = {}
      end
      while #nest_stack > 0 and indent <= nest_stack[#nest_stack].indent do
        table.remove(nest_stack)
      end

      if trimmed == "" then goto continue end

      local k, v = trimmed:match("^(%S+):%s*(.+)$")
      if k then
        local parsed_value
        local list_match = v:match("^%[(.*)%]$")
        if list_match then
          parsed_value = {}
          local pos = 1
          while pos <= #list_match do
            local c = list_match:sub(pos, pos)
            if c:match("%s") then
              pos = pos + 1
            elseif c == '"' or c == "'" then
              local close = list_match:find(c, pos + 1, true)
              if close then
                table.insert(parsed_value, list_match:sub(pos + 1, close - 1))
                pos = close + 1
              else
                table.insert(parsed_value, coerce_value(list_match:sub(pos)))
                break
              end
            else
              local next_comma = list_match:find(",", pos, true)
              local token = next_comma and list_match:sub(pos, next_comma - 1) or list_match:sub(pos)
              table.insert(parsed_value, coerce_value(token))
              pos = next_comma and next_comma + 1 or #list_match + 1
            end
            if pos <= #list_match and list_match:sub(pos, pos) == "," then
              pos = pos + 1
            end
          end
        else
          parsed_value = coerce_value(v)
        end
        local tbl = cell_opts
        for _, frame in ipairs(nest_stack) do
          tbl = tbl[frame.key]
        end
        if k:find("%.") then
          local segments = {}
          for segment in k:gmatch("([^%.]+)") do
            table.insert(segments, segment)
          end
          for i = 1, #segments - 1 do
            tbl[segments[i]] = tbl[segments[i]] or {}
            tbl = tbl[segments[i]]
          end
          tbl[segments[#segments]] = parsed_value
        else
          tbl[k] = parsed_value
        end
      else
        local block_key = trimmed:match("^(%S+):%s*$")
        if block_key then
          local tbl = cell_opts
          for _, frame in ipairs(nest_stack) do
            tbl = tbl[frame.key]
          end
          tbl[block_key] = tbl[block_key] or {}
          table.insert(nest_stack, { key = block_key, indent = indent })
        end
      end
    else
      in_options = false
      table.insert(code_lines, line)
    end
    ::continue::
  end

  while #code_lines > 0 and code_lines[#code_lines] == "" do
    table.remove(code_lines)
  end

  local marker_pat = "%s+" .. escape_pattern(line_marker) .. "%s*(.+)$"
  local parsed_lines = {}
  local line_options = {}

  for idx, raw_line in ipairs(code_lines) do
    local code_part, opts_str = raw_line:match("^(.-)" .. marker_pat)
    if opts_str then
      local opts = { line_index = idx - 1 }
      for k, v in opts_str:gmatch("(%a[%a_%-]*):%s*([^,]+),?%s*") do
        local norm_k = k:gsub("%-", "_")
        opts[norm_k] = coerce_value(v)
      end
      table.insert(parsed_lines, code_part)
      table.insert(line_options, opts)
    else
      table.insert(parsed_lines, raw_line)
    end
  end

  return cell_opts, table.concat(parsed_lines, "\n"), line_options, code_lines
end

function M.build_cell(block, cell_id, config)
  local line_marker = "#!"
  if config.marker then
    line_marker = config.marker
  end

  local cell_opts, code, line_options, source_lines = M.parse_cell_options(block.text, line_marker)

  if cell_opts["marker"] then
    local chunk_marker = cell_opts["marker"]
    if chunk_marker ~= line_marker then
      cell_opts, code, line_options, source_lines = M.parse_cell_options(block.text, chunk_marker)
    end
  end

  if cell_opts["source"] then
    local src_path = cell_opts["source"]
    if not src_path:match("^/") then
      src_path = pandoc.system.get_working_directory() .. "/" .. src_path
    end
    local sf = io.open(src_path, "r")
    if sf then
      local file_content = sf:read("*a"):gsub("\n$", "")
      sf:close()
      local _, new_code, new_line_opts, new_source =
        M.parse_cell_options(file_content, line_marker)
      code = new_code
      line_options = new_line_opts
      source_lines = new_source
    else
      io.stderr:write("quarto-term: source file not found: " .. src_path .. "\n")
    end
  end

  local options = {
    output = true,
    fullscreen = false,
    callout = pandoc.List({}),
    remove = pandoc.List({}),
    truncate = pandoc.List({}),
  }

  local eval = cell_opts["eval"]
  local include = cell_opts["include"]
  if include == false then
    options.echo = "false"
    options.output = false
  end
  if cell_opts["echo"] ~= nil then options.echo = cell_opts["echo"] end
  if cell_opts["output"] ~= nil then options.output = cell_opts["output"] end
  if cell_opts["fullscreen"] ~= nil then options.fullscreen = cell_opts["fullscreen"] end
  if cell_opts["scroll"] ~= nil then options.scroll = cell_opts["scroll"] end

  local klp = cell_opts["keep-last-prompt"]
  if klp == nil then klp = cell_opts["keep_last_prompt"] end
  if klp ~= nil then options.keep_last_prompt = klp end

  if cell_opts["spacing"] ~= nil then options.spacing = cell_opts["spacing"] end
  if cell_opts["typing"] ~= nil then
    if cell_opts["typing"] == false then
      options.typing = false
    elseif cell_opts["typing"] == true then
      options.typing = {}
    end
  end
  if cell_opts["timeout"] ~= nil then options.timeout = cell_opts["timeout"] end
  if cell_opts["hold"] ~= nil then options.hold = cell_opts["hold"] end
  if cell_opts["callout"] ~= nil then options.callout = as_list(cell_opts["callout"]) end
  -- Cell > document > project; without any, the binary's defaults apply
  options.callout_values = config._callout_values
  options.callout_format = config._callout_format
  if cell_opts["callout-values"] ~= nil then options.callout_values = cell_opts["callout-values"] end
  if cell_opts["callout-format"] ~= nil then options.callout_format = cell_opts["callout-format"] end
  -- Lua only: style the numbered list after the cell like its callouts
  local callout_list = config._callout_list
  local cl_opt = cell_opts["callout-list"]
  if cl_opt == nil then cl_opt = cell_opts["callout_list"] end
  if cl_opt ~= nil then callout_list = cl_opt == true end
  if cell_opts["remove"] ~= nil then options.remove = as_list(cell_opts["remove"]) end
  if cell_opts["truncate"] ~= nil then options.truncate = as_list(cell_opts["truncate"]) end
  if cell_opts["highlight"] ~= nil then options.highlight = cell_opts["highlight"] end

  if cell_opts["literal"] ~= nil then options.literal = cell_opts["literal"] end
  if cell_opts["delay"] ~= nil then options.delay = cell_opts["delay"] end
  local enter_val = cell_opts["enter"]
  if enter_val ~= nil then options.enter = enter_val end
  local ep_val = cell_opts["expect-prompt"] or cell_opts["expect_prompt"]
  if ep_val ~= nil then options.expect_prompt = ep_val end
  if cell_opts["assert"] ~= nil then options.assert = cell_opts["assert"] end

  local label = cell_opts["label"]

  local cell_style = cell_opts["style"] or {}
  local cell_colorscheme = nil
  local cell_colorscheme_light = nil
  local cell_colorscheme_dark = nil
  local cell_chrome = nil
  if type(cell_style) == "table" then
    if cell_style["chrome"] ~= nil then cell_chrome = cell_style["chrome"] end
    if cell_style["colorscheme"] then cell_colorscheme = cell_style["colorscheme"] end
    local csl = cell_style["colorscheme-light"] or cell_style["colorscheme_light"]
    if csl then cell_colorscheme_light = csl end
    local csd = cell_style["colorscheme-dark"] or cell_style["colorscheme_dark"]
    if csd then cell_colorscheme_dark = csd end
    local ff = cell_style["font-family"] or cell_style["font_family"]
    if ff then options.font_family = ff end
    local fs = cell_style["font-size"] or cell_style["font_size"]
    if fs then options.font_size = fs end
    local lh = cell_style["line-height"] or cell_style["line_height"]
    if lh then options.line_height = lh end
    if cell_style["ansi"] ~= nil then options.ansi = cell_style["ansi"] end
    if cell_style["spacing"] ~= nil then options.spacing = cell_style["spacing"] end
    local ts = cell_style["trailing-spaces"] or cell_style["trailing_spaces"]
    if ts ~= nil then options.trailing_spaces = ts end
    local fmt_key = config._fmt_key
    if fmt_key and type(cell_style[fmt_key]) == "table" then
      local ov = cell_style[fmt_key]
      if ov["colorscheme"] then cell_colorscheme = ov["colorscheme"] end
      local ov_csl = ov["colorscheme-light"] or ov["colorscheme_light"]
      if ov_csl then cell_colorscheme_light = ov_csl end
      local ov_csd = ov["colorscheme-dark"] or ov["colorscheme_dark"]
      if ov_csd then cell_colorscheme_dark = ov_csd end
      local ov_ff = ov["font-family"] or ov["font_family"]
      if ov_ff then options.font_family = ov_ff end
      local ov_fs = ov["font-size"] or ov["font_size"]
      if ov_fs then options.font_size = ov_fs end
      local ov_lh = ov["line-height"] or ov["line_height"]
      if ov_lh then options.line_height = ov_lh end
      if ov["ansi"] ~= nil then options.ansi = ov["ansi"] end
      if ov["spacing"] ~= nil then options.spacing = ov["spacing"] end
      local ov_ts = ov["trailing-spaces"] or ov["trailing_spaces"]
      if ov_ts ~= nil then options.trailing_spaces = ov_ts end
      if ov["chrome"] ~= nil then cell_chrome = ov["chrome"] end
    end
  end

  return {
    id = cell_id,
    code = code,
    label = label,
    options = options,
    line_options = line_options,
    source_lines = source_lines,
    _eval = eval ~= false,
    _include = include ~= false,
    _colorscheme = cell_colorscheme,
    _colorscheme_light = cell_colorscheme_light,
    _colorscheme_dark = cell_colorscheme_dark,
    _chrome = cell_chrome,
    _callout_list = callout_list == true,
  }
end

M.coerce_value = coerce_value
M.as_list = as_list
M.escape_pattern = escape_pattern

return M
