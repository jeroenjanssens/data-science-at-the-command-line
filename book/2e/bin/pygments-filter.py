#!/usr/bin/env python3

from pprint import pformat
import re
from sys import stderr

from pandocfilters import toJSONFilter, Plain, Str, RawBlock, RawInline

from pygments import highlight
from pygments.lexers import get_lexer_by_name
from pygments.formatters import HtmlFormatter

from ansi2html import Ansi2HTMLConverter

REF_TYPE = {"fig": "Figure",
            "exm": "Example"}

ADM_TYPE = {"comment": "NOTE",
            "note": "NOTE",
            "caution": "WARNING",
            "tip": "TIP"}

conv = Ansi2HTMLConverter(inline=True, scheme="solarized", linkify=False)

callout_code_re = re.compile(r'#? ?&lt;([0-9]{1,2})&gt;')
callout_text_re = re.compile(r'<([0-9]{1,2})>')
comment_adoc_re = re.compile(r'<!--A(.*)A-->', re.MULTILINE|re.DOTALL)
comment_html_re = re.compile(r'<!--H(.*)H-->', re.MULTILINE|re.DOTALL)

def pygments(key, value, format, _):

    if format == "asciidoc":

        # Only keep <!--A...A---> comments
        if key == "RawBlock":
            try:
                if (match := comment_adoc_re.fullmatch(value[1])):
                    return RawBlock("asciidoc", match.group(1))
            except:
                pass

        # Fix references to figures
        if (key == "Str") and value.startswith("@ref"):
            # stderr.write(f"{key}\t{value}\n")
            _, ref_type, ref_id, _ = re.split("\(|:|\)", value)
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
                stderr.write(f"{html}\n")
                _, src, _, alt, *_ = html.split("\"")
                return Plain([Str(f"[[{fig_id}]]\n.{alt}\nimage::{src}[{alt}]")])

    elif format == "html4":

        # Only keep <!--H...H---> comments
        if key == "RawBlock":
            try:
                if (match := comment_html_re.fullmatch(value[1])):
                    return RawBlock("html", match.group(1))
            except:
                pass

        # Turn text callout number into unicode char
        if (key == "Str") and (match := callout_text_re.fullmatch(value)):
            num = int(match.group(1))
            br = "<br>" if num > 1 else ""
            return RawInline("html", f"{br}<span class=\"callout\">&#{num + 10121};</span>")

        # Insert "Figure" or "Example" in front of internal references
        if (key == "Str") and value.startswith("@ref"):
            _, ref_type, ref_id, _ = re.split("\(|:|\)", value)
            return Str(f"{REF_TYPE[ref_type]} {value}")

        elif key == "CodeBlock":
            [[ident, classes, keyvals], code] = value
            if classes:
                language = classes[0]
                # stderr.write(f"{key}\t{value}\t{format}\n")
                result = "<pre>" + conv.convert(code, full=False) + "</pre>"

                # Turn code callout number into unicode char
                result = callout_code_re.sub(lambda x: f"<span class=\"callout\">&#{int(x.group(1))+10121};</span>", result)
            else:
                result = code
            return RawBlock("html", result)

if __name__ == "__main__":
    toJSONFilter(pygments)
