#!/usr/bin/env python3

from pandocfilters import toJSONFilter, RawBlock, Para

from pygments import highlight
from pygments.lexers import get_lexer_by_name
from pygments.formatters import HtmlFormatter

from sys import stderr

def pygments(key, value, format, _):
    if key == 'CodeBlock':
        [[ident, classes, keyvals], code] = value
        result = highlight(code, get_lexer_by_name(classes[0]), HtmlFormatter())
        return RawBlock('html', result)

if __name__ == "__main__":
    toJSONFilter(pygments)
