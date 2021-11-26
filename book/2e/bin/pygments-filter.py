#!/usr/bin/env python3

from pprint import pformat
import re
from sys import stderr

from pandocfilters import toJSONFilter, Plain, Str, RawBlock, RawInline

# from pygments import highlight
# from pygments.lexers import get_lexer_by_name
# from pygments.formatters import HtmlFormatter

from ansi2html import Ansi2HTMLConverter

REF_TYPE = {"fig": "Figure",
            "exm": "Example"}

ADM_TYPE = {"comment": "NOTE",
            "note": "NOTE",
            "caution": "WARNING",
            "tip": "TIP"}

# conv = Ansi2HTMLConverter(inline=True, scheme="github", linkify=False)
conv = Ansi2HTMLConverter(inline=True, scheme="solarized", linkify=False)

ref_re = re.compile(f'@ref\(([a-z]+):([a-z\-]+)\)(.*)')
callout_code_re = re.compile(r'#? ?&lt;([0-9]{1,2})&gt;')
callout_text_re = re.compile(r'<([0-9]{1,2})>')
comment_adoc_re = re.compile(r'<!--A(.*)A-->', re.MULTILINE|re.DOTALL)
comment_html_re = re.compile(r'<!--H(.*)H-->', re.MULTILINE|re.DOTALL)

FIG_COUNTER = 0
CHAPTER_NUM = None
CO_COUNTER = 0
CO_ID = ""

def pygments(key, value, format, _):

    global FIG_COUNTER
    global CHAPTER_NUM


    # Used for figure log
    if format == "muse":

        if key == "Header":
            level = value[0]
            if level == 1:
                try:
                    CHAPTER_NUM = int(value[1][0].split("-")[1])
                    FIG_COUNTER = 0
                except:
                    pass

        if key == "Div":
            [[ident, classes, keyvals], code] = value
            div_type = classes[0]

            if div_type == "figure":
                FIG_COUNTER += 1
                fig_id = code[2]["c"][0]["c"].split(")")[0][2:]
                html = code[0]["c"][0]["c"][1]
                _, src, _, alt, *_ = html.split("\"")
                src = src.split("/")[-1]
                redraw = "Redraw" if src.startswith("diagram_") else "Use as-is"
                stderr.write(f"{CHAPTER_NUM},{FIG_COUNTER},Yes,\"N/A\",{src},{redraw},\"{alt}\"\n")

        return None


    if format == "asciidoc":

        # Fix chapter cross ref
        # if key == "Link" and value[2][0].startswith("#chapter"):
        #     return RawInline("asciidoc", f"<<{value[2][0][1:]}>>")

        # if key == "Header":
        #     level = value[0]
        #     chapter_id = "_".join(value[1][0].split("-")[2:])
        #     if level == 1:
        #         stderr.write(f"HEADER: {value}\n\n")
        #         stderr.write(f"HEADER_ID: {chapter_id}\n\n")

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
            #_, ref_type, ref_id, *rest = re.split("\(|:|\)", value)

            match = ref_re.fullmatch(value)
            ref_type = match.group(1)
            ref_id = match.group(2)
            ref_rest = match.group(3)
            new_ref = f"<<{ref_type}:{ref_id}>>{ref_rest}"
            # stderr.write(new_ref + "\n")
            return Str(new_ref)

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
                # stderr.write(f"{html}\n")
                _, src, _, alt, *_ = html.split("\"")
                return Plain([Str(f"[[{fig_id}]]\n.{alt}\nimage::{src}[\"{alt}\"]")])

        elif key == "CodeBlock":
            [[ident, classes, keyvals], code] = value
            if classes:
                language = classes[0]
                # stderr.write(f"{key}\t{value}\t{format}\n")
                html_code = conv.convert(code, full=False)
                html_code = html_code.replace("+", "&#43;")

                result = "[source,subs=\"+macros\"]\n----\n"
                for line in html_code.split("\n"):
                    line += "<span></span>"
                    if match := callout_code_re.search(line):
                        line = callout_code_re.sub("", line)
                        line = f"+++{line}+++ <{match.group(1)}>"
                    else:
                        line = f"+++{line}+++"
                    result += line + "\n"
                result += "----\n\n"

                # html_code = "+++" + html_code.replace("\n", "<span></span>+++\n+++") + "<span></span>+++"
                html_code = html_code.replace("<span", "+++<span").replace("</span>", "</span>+++")
                #result = "[subs=callouts]\n++++\n<pre data-type=\"programlisting\" style=\"color: #4f4f4f\">" + html_code + "</pre>\n++++\n\n"
                # result = "[source,subs=\"+macros\"]\n----\n" + html_code + "\n----\n\n"

                # Turn code callout number into image
                # result = callout_code_re.sub(lambda x: f"<img src=\"callouts/{int(x.group(1))}.png\" alt=\"{int(x.group(1))}\">", result)
                # result = callout_code_re.sub(lambda x: f"<a class=\"co\"><img src=\"callouts/{int(x.group(1))}.png\" /></a>", result)
                # result = callout_code_re.sub(lambda x: f"<!--{int(x.group(1))}-->", result)
                # result = result.replace("+++<span></span>+++", "")
            else:
                result = code
            return RawBlock("asciidoc", result)

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
            # stderr.write(f"{key}\t{value}\n")
            _, ref_type, ref_id, *_ = re.split("\(|:|\)", value)
            # stderr.write(f"REF: {ref_type}\t{ref_id}\n")
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
