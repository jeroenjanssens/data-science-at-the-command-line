#!/usr/bin/env python3

from pandocfilters import *

from pygments import highlight
from pygments.lexers import get_lexer_by_name
from pygments.formatters import HtmlFormatter

from sys import stderr
import re

from pprint import pformat

def pygments(key, value, format, _):

    # if key not in ["Space", "Str", "RawInline", "Para", "Quoted", "Plain"]:
        # stderr.write(f"- {key}: {value[:100]}\n")

    if (key == "Str") and "fig:" in value:
        stderr.write(f"{key}\t{value}\t{format}\n")

    if format == "asciidoc":
        if (key == "Str") and value.startswith("@ref"):
            stderr.write(f"{key}\t{value}\n")
            _, ref_type, ref_id, _ = re.split("\(|:|\)", value)
            return Str(f"<<{ref_type}:{ref_id}>>")

        if key == "Div":
            [[ident, classes, keyvals], code] = value
            div_type = classes[0]

            if div_type.startswith("rmd"):
                text = code[0]["c"]
                text = [Str("[NOTE]\n====\n")] + text + [Str("\n====\n\n")]
                return Plain(text)

            if div_type == "figure":
                id = code[2]["c"][0]["c"].split(")")[0][2:]
                html = code[0]["c"][0]["c"][1]
                _, src, _, alt, _ = html.split("\"")
                text = f"[[{id}]]\n.{alt}\nimage::{src}[{alt}]"
                # stderr.write("\n" + text + "\n")
                return Plain([Str(text)])

    if format == "html4":

        if (key == "Str") and value.startswith("@ref"):
            _, ref_type, ref_id, _ = re.split("\(|:|\)", value)
            if ref_type == "fig":
                return Str(f"Figure {value}")
            if ref_type == "exm":
                return Str(f"Example {value}")

        if key == "CodeBlock":
            [[ident, classes, keyvals], code] = value
            language = classes[0]
            stderr.write(f"\n\nformat: {format}\n\n```" + language + "\n" + code + "\n```\n\n\n")
            result = highlight(code, get_lexer_by_name(language), HtmlFormatter())
            return RawBlock("html", result)

if __name__ == "__main__":
    toJSONFilter(pygments)
