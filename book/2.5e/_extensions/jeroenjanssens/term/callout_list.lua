-- callout-list: give the numbered list after a term cell the same markers as
-- the callouts in the cell (HTML only).
--
-- term.lua puts a marker block after the output of each cell with
-- `callout-list: true`. wrap() then wraps the ordered list that directly
-- follows such a marker in a div whose class selects a CSS @counter-style
-- built from the cell's callout-values and callout-format.
local M = {}

M.DEFAULT_VALUES = "123456789"
M.DEFAULT_FORMAT = "<{}>"

local MARKER_PREFIX = "<!-- term-callout-list:"
local MARKER_SUFFIX = " -->"

--- The marker texts, in order: each value put into the format.
-- `values` is a string (one marker per character) or a list of strings.
function M.symbols(values, format)
  values = values or M.DEFAULT_VALUES
  format = format or M.DEFAULT_FORMAT
  local list = {}
  if type(values) == "string" then
    for _, code in utf8.codes(values) do
      table.insert(list, utf8.char(code))
    end
  else
    for _, v in ipairs(values) do
      table.insert(list, tostring(v))
    end
  end
  local out = {}
  for _, v in ipairs(list) do
    -- Plain replacement: `%` in the value or the format has no special meaning
    local s = format:gsub("{}", function() return v end)
    table.insert(out, s)
  end
  return out
end

--- A CSS string literal for `s`.
function M.css_string(s)
  return '"' .. s:gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('\n', '\\a ') .. '"'
end

--- The class (and @counter-style name) for a list of symbols.
function M.class_name(symbols)
  return "term-callouts-" .. pandoc.utils.sha1(table.concat(symbols, "\0")):sub(1, 8)
end

--- CSS that styles lists wrapped with `class_name(symbols)`.
function M.css(symbols)
  local name = M.class_name(symbols)
  local quoted = {}
  for _, s in ipairs(symbols) do
    table.insert(quoted, M.css_string(s))
  end
  return string.format(
    "@counter-style %s {\n  system: fixed;\n  symbols: %s;\n  suffix: \" \";\n}\n"
      .. ".term-callout-list.%s > ol {\n  list-style-type: %s;\n}\n",
    name, table.concat(quoted, " "), name, name)
end

--- The block that term.lua puts after a cell's output.
function M.marker(symbols)
  return pandoc.RawBlock("html", MARKER_PREFIX .. M.class_name(symbols) .. MARKER_SUFFIX)
end

local function marker_class(block)
  if block and block.t == "RawBlock" and block.format == "html" then
    local text = block.text
    if text:sub(1, #MARKER_PREFIX) == MARKER_PREFIX and text:sub(-#MARKER_SUFFIX) == MARKER_SUFFIX then
      return text:sub(#MARKER_PREFIX + 1, -#MARKER_SUFFIX - 1)
    end
  end
  return nil
end

--- Blocks filter: wrap the ordered list after each marker, and drop the markers.
function M.wrap(blocks)
  local out = pandoc.Blocks({})
  local changed = false
  local i = 1
  while i <= #blocks do
    local class = marker_class(blocks[i])
    if class then
      changed = true
      local next_block = blocks[i + 1]
      if next_block and next_block.t == "OrderedList" then
        out:insert(pandoc.Div({ next_block }, pandoc.Attr("", { "term-callout-list", class })))
        i = i + 2
      else
        i = i + 1
      end
    else
      out:insert(blocks[i])
      i = i + 1
    end
  end
  if changed then return out end
  return nil
end

return M
