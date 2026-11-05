local M = {}

function M.normalize(val)
  if val == nil or val == false then return nil end
  if val == true then
    return { os = "macos", shadow = true }
  end
  if type(val) == "table" then
    return {
      os     = val.os or "macos",
      color  = val.color,
      title  = val.title,
      shadow = (val.shadow == nil) and true or val.shadow,
    }
  end
  return nil
end

function M.wrap(html, cfg)
  local os_style = cfg.os or "macos"
  local title = cfg.title
  local color = cfg.color
  local shadow = cfg.shadow

  local bar_style = color and (' style="background:' .. color .. '"') or ''
  local outer_style = (shadow == false) and ' style="box-shadow:none"' or ''

  local title_html = title
    and ('<span class="term-chrome-title">' .. title .. '</span>')
    or ''

  local bar_inner
  if os_style == "windows" then
    bar_inner = title_html
      .. '<span class="term-chrome-btn term-chrome-minimize">&#x2500;</span>'
      .. '<span class="term-chrome-btn term-chrome-maximize">&#x25A1;</span>'
      .. '<span class="term-chrome-btn term-chrome-close">&#x2715;</span>'
  else
    bar_inner = '<span class="term-chrome-dot term-chrome-close"></span>'
      .. '<span class="term-chrome-dot term-chrome-minimize"></span>'
      .. '<span class="term-chrome-dot term-chrome-maximize"></span>'
      .. title_html
  end

  local bar = '<div class="term-chrome-bar"' .. bar_style .. '>' .. bar_inner .. '</div>'
  return '<div class="term-chrome term-chrome-' .. os_style .. '"' .. outer_style .. '>\n'
    .. bar .. '\n' .. html .. '</div>\n'
end

return M
