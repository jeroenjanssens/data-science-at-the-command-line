local M = {}

local filter_dir

function M.init(dir)
  filter_dir = dir
end

function M.read_file(theme_name)
  if not theme_name then return nil end
  local path = filter_dir .. "themes/" .. theme_name .. ".css"
  local f = io.open(path, "r")
  if not f then return nil end
  local content = f:read("*a")
  f:close()
  return content
end

function M.read_colors(theme_name)
  local content = M.read_file(theme_name)
  if not content then return nil, nil end
  local bg = content:match("%-%-term%-bg:%s*#(%x+)")
  local fg = content:match("%-%-term%-fg:%s*#(%x+)")
  return bg, fg
end

function M.rescope_css(css_content, selector)
  return css_content:gsub(":root%s*{", selector .. " {")
end

return M
