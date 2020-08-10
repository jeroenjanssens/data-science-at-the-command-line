#!/usr/bin/env python3

from pprint import pformat
from re import split
from sys import stderr

from pandocfilters import toJSONFilter, Plain, Str, RawBlock

from pygments import highlight
from pygments.lexers import get_lexer_by_name
from pygments.formatters import HtmlFormatter


REF_TYPE = {"fig": "Figure",
            "exm": "Example"}

ADM_TYPE = {"comment": "NOTE",
            "note": "NOTE",
            "tip": "TIP"}


def pygments(key, value, format, _):

    # if key not in ["Space", "Str", "RawInline", "Para", "Quoted", "Plain"]:
        # stderr.write(f"- {key}: {value[:100]}\n")

    # if (key == "Str") and "fig:" in value:
    #     stderr.write(f"{key}\t{value}\t{format}\n")


    if format == "asciidoc":

        # Fix references to figures
        if (key == "Str") and value.startswith("@ref"):
            # stderr.write(f"{key}\t{value}\n")
            _, ref_type, ref_id, _ = split("\(|:|\)", value)
            return Str(f"<<{ref_type}:{ref_id}>>")

        elif key == "Div":
            [[ident, classes, keyvals], code] = value
            div_type = classes[0]

            # Fix admonition
            if div_type.startswith("rmd"):
                adm_type = div_type[3:]
                return Plain([Str(f"[{ADM_TYPE[adm_type]}]\n====\n")] +
                             code[0]["c"] +
                             [Str("\n====\n\n")])

            # Fix figures
            elif div_type == "figure":
                fig_id = code[2]["c"][0]["c"].split(")")[0][2:]
                html = code[0]["c"][0]["c"][1]
                _, src, _, alt, _ = html.split("\"")
                return Plain([Str(f"[[{fig_id}]]\n.{alt}\nimage::{src}[{alt}]")])

    elif format == "html4":


        # Insert "Figure" or "Example" in front of internal references
        if (key == "Str") and value.startswith("@ref"):
            _, ref_type, ref_id, _ = split("\(|:|\)", value)
            return Str(f"{REF_TYPE[ref_type]} {value}")

        # Highlight code using pygments
        elif key == "CodeBlock":
            [[ident, classes, keyvals], code] = value
            language = classes[0]
            # stderr.write(f"\n\nformat: {format}\n\n```" + language + "\n" + code + "\n```\n\n\n")
            result = highlight(code, get_lexer_by_name(language), HtmlFormatter())
            return RawBlock("html", result)

if __name__ == "__main__":
    toJSONFilter(pygments)
