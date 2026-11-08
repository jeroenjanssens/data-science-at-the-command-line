-- The Pandoc block for a cell's rendered output
local M = {}

--- Return the block for `content`, rendered by the binary for `raw_format`.
--
-- Quarto processes shortcodes (`{{< ... >}}`) in raw blocks, even ones that a
-- filter creates. An unclosed `{{<` makes Quarto drop the rest of the page.
-- HTML, LaTeX, and Typst output are escaped by the binary, but Markdown can't
-- escape `{{<` inside a code fence. So Markdown output that contains `{{<`
-- becomes a code block with `shortcodes="false"`, which Quarto leaves alone.
function M.block(raw_format, content)
  if raw_format == "markdown" and content:find("{{<", 1, true) then
    local doc = pandoc.read(content, "markdown")
    if #doc.blocks == 1 and doc.blocks[1].t == "CodeBlock" then
      local block = doc.blocks[1]
      block.attributes["shortcodes"] = "false"
      return block
    end
  end
  return pandoc.RawBlock(raw_format, content)
end

return M
