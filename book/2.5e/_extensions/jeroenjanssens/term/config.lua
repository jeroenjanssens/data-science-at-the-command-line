local M = {}

local function resolve_init_path(path)
  if path:sub(1, 1) == "/" then
    local f = io.open(path, "r")
    if f then f:close(); return path end
    return nil
  end
  local local_file = io.open(path, "r")
  if local_file then
    local_file:close()
    return path
  end
  local search_dirs = {
    "/opt/homebrew/share",
    "/usr/local/share",
    "/usr/share",
    "/home/linuxbrew/.linuxbrew/share",
  }
  for _, dir in ipairs(search_dirs) do
    local candidate = dir .. "/" .. path .. "/" .. path .. ".zsh"
    local f = io.open(candidate, "r")
    if f then
      f:close()
      return candidate
    end
  end
  return nil
end

local SHELL_PRESETS = {
  zsh = { shell = "zsh", shell_args = {"--no-rcs"}, prompt = "$", ps2 = ">" },
  bash = { shell = "bash", shell_args = {"--norc", "--noprofile"}, prompt = "$", ps2 = ">" },
  python = { shell = "python3", shell_args = {"-q"}, prompt = ">>>", ps2 = "..." },
  node = { shell = "node", shell_args = {}, prompt = ">", ps2 = "..." },
  r = { shell = "R", shell_args = {"--no-save", "--no-restore", "--quiet"}, prompt = ">", ps2 = "+" },
  ruby = { shell = "irb", shell_args = {"--noecho", "--nomultiline"}, prompt = "irb>", ps2 = "irb*" },
  sqlite = { shell = "sqlite3", shell_args = {}, prompt = "sqlite>", ps2 = "   ...>" },
  duckdb = { shell = "duckdb", shell_args = {}, prompt = "D", ps2 = ">" },
  fish = { shell = "fish", shell_args = {"--no-config"}, prompt = ">", ps2 = "" },
  nushell = { shell = "nu", shell_args = {"--no-config-file"}, prompt = ">", ps2 = ":::" },
  sh = { shell = "sh", shell_args = {}, prompt = "$", ps2 = ">" },
}

-- Resolve a volume spec (host:container[:options]) the way `docker run -v`
-- does: host paths starting with `.` are relative to cwd; absolute paths
-- (including Windows drive paths) and named volumes pass through unchanged
function M.resolve_volume(spec, cwd)
  local host, rest = spec:match("^(%a:[\\/][^:]*)(:.*)$")
  if not host then
    host, rest = spec:match("^([^:]+)(:.*)$")
  end
  if not host then
    return spec
  end
  if host == "." then
    host = cwd
  elseif host:match("^%.[\\/]") then
    host = cwd .. "/" .. host:sub(3)
  elseif host:sub(1, 1) == "." then
    host = cwd .. "/" .. host
  end
  return host .. rest
end

function M.extract_config(meta)
  local config = {
    shell = "zsh",
    shell_args = {},
    prompt = "$",
    cols = 80,
    rows = 24,
    ansi = true,
    timeout = 10.0,
    env = {},
    verbose = false,
    format = "html",
  }

  local term_meta = meta and meta["extensions"] and meta["extensions"]["term"]
  if not term_meta then
    return config
  end

  if term_meta["profile"] then
    local profile_name = type(term_meta["profile"]) == "string"
      and term_meta["profile"] or pandoc.utils.stringify(term_meta["profile"])
    local preset = SHELL_PRESETS[profile_name]
    if preset then
      config.shell = preset.shell
      config.shell_args = preset.shell_args
      config.prompt = preset.prompt
      if preset.ps2 then config._ps2_explicit = preset.ps2 end
    end
  end

  local function meta_str(val)
    if not val then return nil end
    if type(val) == "string" then return val end
    if type(val) == "number" then return tostring(val) end
    if type(val) == "table" then
      local inlines = val
      if val.t == "MetaInlines" then inlines = val end
      if #inlines == 1 and inlines[1].t == "Code" then
        return inlines[1].text
      end
      local parts = {}
      for _, el in ipairs(inlines) do
        if el.t == "Str" then
          local text = el.text:gsub("\xe2\x80\x94", "---"):gsub("\xe2\x80\x93", "--")
          table.insert(parts, text)
        elseif el.t == "Space" then
          table.insert(parts, " ")
        elseif el.t == "Code" then
          table.insert(parts, el.text)
        elseif el.t == "SoftBreak" then
          table.insert(parts, "\n")
        elseif el.t == "Quoted" then
          local q = el.quotetype == "SingleQuote" and "'" or '"'
          table.insert(parts, q .. pandoc.utils.stringify(el.content) .. q)
        else
          table.insert(parts, pandoc.utils.stringify(el))
        end
      end
      return table.concat(parts)
    end
    return pandoc.utils.stringify(val)
  end

  local function meta_bool(val)
    if val == nil then return nil end
    if type(val) == "boolean" then return val end
    local s = meta_str(val)
    if s == "true" then return true end
    if s == "false" then return false end
    return nil
  end

  local function meta_num(val)
    if not val then return nil end
    if type(val) == "number" then return val end
    return tonumber(meta_str(val))
  end

  if term_meta["shell"] then
    local shell_val = term_meta["shell"]
    if shell_val.t == "MetaList" then
      config.shell = meta_str(shell_val[1])
      config.shell_args = {}
      for i = 2, #shell_val do
        table.insert(config.shell_args, meta_str(shell_val[i]))
      end
    else
      config.shell = meta_str(shell_val)
    end
  end

  local shell_args_val = term_meta["shell-args"] or term_meta["shell_args"]
  if shell_args_val then
    config.shell_args = {}
    if type(shell_args_val) == "table" then
      for i = 1, #shell_args_val do
        table.insert(config.shell_args, meta_str(shell_args_val[i]))
      end
    end
  else
    local shell_base = config.shell:match("([^/]+)$") or config.shell
    if shell_base == "zsh" then
      config.shell_args = {"--no-rcs"}
    elseif shell_base == "bash" then
      config.shell_args = {"--norc", "--noprofile"}
    elseif shell_base == "fish" then
      config.shell_args = {"--no-config"}
    end
  end

  local prompt_val = term_meta["prompt"] or term_meta["ps1"]
  if prompt_val then
    config.prompt = meta_str(prompt_val)
  end

  local prompt_regex_val = term_meta["prompt-regex"] or term_meta["prompt_regex"]
    or term_meta["ps1-regex"] or term_meta["ps1_regex"]
  if prompt_regex_val then
    config.prompt_regex = meta_str(prompt_regex_val)
  end
  local ps2_val = term_meta["ps2"]
  if ps2_val then
    config._ps2_explicit = meta_str(ps2_val)
  end
  local ps2_regex_val = term_meta["ps2-regex"] or term_meta["ps2_regex"]
  if ps2_regex_val then
    config.ps2_regex = meta_str(ps2_regex_val)
  end
  if term_meta["timeout"] then config.timeout = meta_num(term_meta["timeout"]) or config.timeout end
  if term_meta["init"] ~= nil then
    local init_val = term_meta["init"]
    if init_val == false or (type(init_val) == "userdata" and tostring(init_val) == "false") then
      config.init = {}
    else
      local init_list = {}
      if type(init_val) == "table" and init_val.t == nil
          and #init_val > 0 and type(init_val[1]) ~= "userdata" then
        for i = 1, #init_val do
          table.insert(init_list, meta_str(init_val[i]))
        end
      else
        table.insert(init_list, meta_str(init_val))
      end
      config.init = {}
      for _, entry in ipairs(init_list) do
        local resolved = resolve_init_path(entry)
        if resolved then
          table.insert(config.init, "source " .. resolved)
        else
          for line in entry:gmatch("[^\n]+") do
            local trimmed = line:match("^%s*(.-)%s*$")
            if trimmed and trimmed ~= "" then
              table.insert(config.init, trimmed)
            end
          end
        end
      end
    end
  end
  if term_meta["cache"] ~= nil then config._cache = meta_bool(term_meta["cache"]) end
  if term_meta["verbose"] ~= nil then config.verbose = meta_bool(term_meta["verbose"]) end
  if term_meta["strip-auto-indent"] ~= nil then config.strip_auto_indent = meta_bool(term_meta["strip-auto-indent"]) end
  if term_meta["spacing"] ~= nil then config.spacing = meta_bool(term_meta["spacing"]) end
  if term_meta["delay"] ~= nil then config.delay = meta_num(term_meta["delay"]) end
  if term_meta["hold"] ~= nil then config.hold = meta_num(term_meta["hold"]) end
  if term_meta["echo"] ~= nil then
    local b = meta_bool(term_meta["echo"])
    if b ~= nil then config.echo = b
    else config.echo = meta_str(term_meta["echo"]) end
  end
  local klp_val = term_meta["keep-last-prompt"] or term_meta["keep_last_prompt"]
  if klp_val ~= nil then config.keep_last_prompt = meta_bool(klp_val) end
  if term_meta["highlight"] ~= nil then
    local b = meta_bool(term_meta["highlight"])
    if b ~= nil then config.highlight = b
    else config.highlight = meta_str(term_meta["highlight"]) end
  end

  if term_meta["marker"] then
    config.marker = meta_str(term_meta["marker"])
  end

  local FORMAT_KEYS = { html = true, pdf = true, revealjs = true, epub = true, markdown = true, latex = true, typst = true }

  local function extract_style(style_meta)
    if not style_meta or type(style_meta) ~= "table" then return {} end
    local s = {}
    if style_meta["colorscheme"] then s.colorscheme = meta_str(style_meta["colorscheme"]) end
    local csl = style_meta["colorscheme-light"] or style_meta["colorscheme_light"]
    if csl then s.colorscheme_light = meta_str(csl) end
    local csd = style_meta["colorscheme-dark"] or style_meta["colorscheme_dark"]
    if csd then s.colorscheme_dark = meta_str(csd) end
    local ff = style_meta["font-family"] or style_meta["font_family"]
    if ff then s.font_family = meta_str(ff) end
    local fs = style_meta["font-size"] or style_meta["font_size"]
    if fs then s.font_size = meta_str(fs) end
    local lh = style_meta["line-height"] or style_meta["line_height"]
    if lh then s.line_height = meta_str(lh) end
    local ts = style_meta["trailing-spaces"] or style_meta["trailing_spaces"]
    if ts ~= nil then s.trailing_spaces = meta_bool(ts) end
    if style_meta["ansi"] ~= nil then s.ansi = meta_bool(style_meta["ansi"]) end
    if style_meta["spacing"] ~= nil then s.spacing = meta_bool(style_meta["spacing"]) end
    if style_meta["cols"] then s.cols = meta_num(style_meta["cols"]) end
    if style_meta["rows"] then s.rows = meta_num(style_meta["rows"]) end
    if style_meta["chrome"] ~= nil then
      local cv = style_meta["chrome"]
      if type(cv) == "boolean" or (type(cv) == "userdata" and (tostring(cv) == "true" or tostring(cv) == "false")) then
        s.chrome = meta_bool(cv)
      elseif type(cv) == "table" and (cv["os"] ~= nil or cv["color"] ~= nil
          or cv["title"] ~= nil or cv["shadow"] ~= nil) then
        s.chrome = {
          os     = cv["os"] and meta_str(cv["os"]) or nil,
          color  = cv["color"] and meta_str(cv["color"]) or nil,
          title  = cv["title"] and meta_str(cv["title"]) or nil,
          shadow = cv["shadow"] ~= nil and meta_bool(cv["shadow"]) or nil,
        }
      else
        s.chrome = meta_str(cv)
      end
    end
    s._format_overrides = {}
    for k, v in pairs(style_meta) do
      if type(k) == "string" and FORMAT_KEYS[k] and type(v) == "table" then
        s._format_overrides[k] = v
      end
    end
    if next(s._format_overrides) == nil then s._format_overrides = nil end
    return s
  end

  if term_meta["style"] then
    local style = extract_style(term_meta["style"])
    if style.colorscheme then config._colorscheme = style.colorscheme end
    if style.colorscheme_light then config._colorscheme_light = style.colorscheme_light end
    if style.colorscheme_dark then config._colorscheme_dark = style.colorscheme_dark end
    if style.font_family then config.font_family = style.font_family end
    if style.font_size then config.font_size = style.font_size end
    if style.line_height then config.line_height = style.line_height end
    if style.trailing_spaces ~= nil then config.trailing_spaces = style.trailing_spaces end
    if style.ansi ~= nil then config.ansi = style.ansi end
    if style.spacing ~= nil then config.spacing = style.spacing end
    if style.cols then config.cols = style.cols end
    if style.rows then config.rows = style.rows end
    if style.chrome ~= nil then config._chrome = style.chrome end
    if style._format_overrides then
      config._style_overrides = {}
      for fmt, raw in pairs(style._format_overrides) do
        config._style_overrides[fmt] = extract_style(raw)
      end
    end
  end
  if term_meta["typing"] then
    local typing_val = term_meta["typing"]
    if meta_bool(typing_val) == false then
      config.typing = false
    elseif type(typing_val) == "table" and typing_val.t == nil then
      config.typing = {}
      if typing_val["speed"] then config.typing.speed = meta_num(typing_val["speed"]) end
      local error_rate_val = typing_val["error-rate"] or typing_val["error_rate"]
      if error_rate_val then config.typing.error_rate = meta_num(error_rate_val) end
    end
  end
  if term_meta["record"] then
    local record_val = term_meta["record"]
    if type(record_val) == "table" and record_val.t == nil then
      config.record = {}
      for i = 1, #record_val do
        table.insert(config.record, meta_str(record_val[i]))
      end
    else
      config.record = { meta_str(record_val) }
    end
  end

  if term_meta["env"] then
    local env_val = term_meta["env"]
    if type(env_val) == "table" then
      for k, v in pairs(env_val) do
        if type(k) == "string" then
          config.env[k] = meta_str(v)
        end
      end
    end
  end

  if not config.env["PS1"] then
    config.env["PS1"] = config.prompt .. " "
  end

  if config._ps2_explicit then
    config.ps2 = config._ps2_explicit
    if not config.env["PS2"] then
      config.env["PS2"] = config._ps2_explicit
    end
  else
    if not config.env["PS2"] then
      config.env["PS2"] = "> "
    end
    config.ps2 = config.env["PS2"]
  end
  config._ps2_explicit = nil

  for _, key in ipairs({"PS1", "PS2", "PROMPT"}) do
    local val = config.env[key]
    if val and not val:match("%s$") then
      config.env[key] = val .. " "
    end
  end

  if term_meta["docker"] then
    local docker_meta = term_meta["docker"]
    if type(docker_meta) == "table" then
      local docker = {}
      if docker_meta["image"] then docker.image = meta_str(docker_meta["image"]) end
      if docker_meta["pull"] then docker.pull = meta_str(docker_meta["pull"]) end
      if docker_meta["platform"] then docker.platform = meta_str(docker_meta["platform"]) end
      if docker_meta["workdir"] then docker.workdir = meta_str(docker_meta["workdir"]) end
      if docker_meta["user"] then docker.user = meta_str(docker_meta["user"]) end
      if docker_meta["network"] then docker.network = meta_str(docker_meta["network"]) end
      if docker_meta["memory"] then docker.memory = meta_str(docker_meta["memory"]) end
      if docker_meta["cpus"] then docker.cpus = meta_str(docker_meta["cpus"]) end
      if docker_meta["name"] then docker.name = meta_str(docker_meta["name"]) end
      if docker_meta["ports"] then
        docker.ports = {}
        local ports_val = docker_meta["ports"]
        if type(ports_val) == "table" then
          for i = 1, #ports_val do
            table.insert(docker.ports, meta_str(ports_val[i]))
          end
        end
      end
      if docker_meta["args"] then
        docker.args = {}
        local args_val = docker_meta["args"]
        if type(args_val) == "table" then
          for i = 1, #args_val do
            table.insert(docker.args, meta_str(args_val[i]))
          end
        end
      end
      if docker_meta["volumes"] then
        local cwd = pandoc.system.get_working_directory()
        docker.volumes = {}
        local vols_val = docker_meta["volumes"]
        if type(vols_val) == "table" then
          for i = 1, #vols_val do
            table.insert(docker.volumes, M.resolve_volume(meta_str(vols_val[i]), cwd))
          end
        end
      end
      if docker_meta["env"] then
        local env_val = docker_meta["env"]
        if type(env_val) == "table" then
          docker.env = {}
          for k, v in pairs(env_val) do
            if type(k) == "string" then
              docker.env[k] = meta_str(v)
            end
          end
        end
      end
      if docker.image then
        config.docker = docker
      end
    end
  end

  return config
end

return M
