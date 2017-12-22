#!/usr/bin/env bash
# sed -re '/^\[\[/y/_/-/' |
asciidoc -b docbook -o - - |
iconv -t utf8 |
pandoc -f docbook -t markdown --wrap=none --atx-headers |    # convert to markdown
iconv -f utf-8 |
sed -re 's/``` \{.console\}/```\{bash, eval=FALSE\}/' |  # change type of code chuck
# sed -re '/```\{bash\}/,/```/{/^(\$|>|(```))/!d}' |     # delete code output
sed -re 's/\\\[cite:([^\]+)\\\]/\[@\1\]/g' |       # fix citations
sed -re 's/\\\[citenp:([^\]+)\\\]/@\1/g' |         # fix citations
sed -re '/^#+/s/\{#(.*)\}$//' |                    # remove heading ids
sed -re '/\*\*Caution\*\*/,/^$/{s/^> \*\*.*$/```\{block2, type="rmdcaution"\}/;s/^$/```\n/;s/^> ?//}' | # notes, tips, cautions
sed -re '/\*\*Tip\*\*/,/^$/{s/^> \*\*.*$/```\{block2, type="rmdtip"\}/;s/^$/```\n/;s/^> ?//}' |
sed -re '/\*\*Note\*\*/,/^$/{s/^> \*\*.*$/```\{block2, type="rmdnote"\}/;s/^$/```\n/;s/^> ?//}' |
sed -re '/\*\*Important\*\*/,/^$/{s/^> \*\*.*$/```\{block2, type="rmdimportant"\}/;s/^$/```\n/;s/^> ?//}' |
sed -re '/^!\[/s/^!\[(.*)\]\((.*)\)/```\{r, echo=FALSE, fig.cap="\1", fig.align="center"\}\nknitr::include_graphics\("\2"\)\n```/' |  # figures
sed -re 's/\[figure\\\_title\]\(\#([^\)]*)\)/Figure\n\\@ref\(fig:\1\)\n/g' | # figure references
sed -re 's/\[example\\\_title\]\(\#([^\)]*)\)/Example\n\\@ref\(exm:\1\)\n/g' | # example references
sed -re '/^\\@ref/y/_/-/' | # replace underscores with dashes in references
sed -re '/\\\[render:/d' |
sed -re '/^-/{N;N;s/^\-(.*)\n\n\-(.*)$/\-\1\n\-\2/;}' | sed -re 'N;/^-/{N;N;s/^\-(.*)\n\n\-(.*)$/\-\1\n\-\2/;}' | # fix empty lines in lists (I'm sorry)
sed -re 's/``` \{\.(.*)\}/```\{example, name=""\}\n```\n```\{\1, eval=FALSE\}/' | # create examples
cat
