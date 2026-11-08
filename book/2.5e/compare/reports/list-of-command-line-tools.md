# list-of-command-line-tools.html

Image: `datasciencetoolbox/dsatcl2e@sha256:9cd9b96f9e1b3a286a103fef60b0c6129cae316735486f496571ddd1293ad4e1`

## Extra code block 44: `$ type ir`

- id: `list-of-command-line-tools.html:block-extra:2ee37dce`
- hash: `0f2062f0`
- status: **accept**
- cause: content
- note: Content pass: new entry for ir

```diff
--- 2e
+++ 2.5e
@@ -0,0 +1,15 @@
+$ type ir
+ir is /usr/local/bin/ir
+
+$ ir --help | trim
+Run self-describing R scripts
+
+Usage: ir [COMMAND]
+
+Commands:
+  run         Run a script or inline R expression
+  render      Render a Quarto document or script
+  preview     Preview a Quarto document or script
+  tool        Run package executables
+  quickstart  Show a concise usage guide for AI agents
+… with 13 more lines
```

## Code block 2: `$ type aws`

- id: `list-of-command-line-tools.html:block:2`
- hash: `01db8da8`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type aws
-aws is /usr/local/bin/aws
+aws is /usr/bin/aws
 
 $ aws --help
```

## Code block 6: `$ type body`

- id: `list-of-command-line-tools.html:block:6`
- hash: `f1341c3d`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -5,11 +5,11 @@
 values
 3
+10
+5
+1
 7
-10
-9
-5
 4
-6
 8
 2
-1
+9
+6
```

## Code block 12: `$ type cowsay`

- id: `list-of-command-line-tools.html:block:12`
- hash: `ce20a64f`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type cowsay
-cowsay is /usr/bin/cowsay
+cowsay is /usr/local/bin/cowsay
 
 $ man cowsay
```

## Code block 15: `$ type csvcut`

- id: `list-of-command-line-tools.html:block:15`
- hash: `243fd91e`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type csvcut
-csvcut is /usr/bin/csvcut
+csvcut is /opt/uv/bin/csvcut
 
 $ csvcut --help
```

## Code block 16: `$ type csvgrep`

- id: `list-of-command-line-tools.html:block:16`
- hash: `05e5b297`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type csvgrep
-csvgrep is /usr/bin/csvgrep
+csvgrep is /opt/uv/bin/csvgrep
 
 $ csvgrep --help
```

## Code block 17: `$ type csvjoin`

- id: `list-of-command-line-tools.html:block:17`
- hash: `4c2a213c`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type csvjoin
-csvjoin is /usr/bin/csvjoin
+csvjoin is /opt/uv/bin/csvjoin
 
 $ csvjoin --help
```

## Code block 20: `$ type csvsort`

- id: `list-of-command-line-tools.html:block:20`
- hash: `aae3c1fc`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type csvsort
-csvsort is /usr/bin/csvsort
+csvsort is /opt/uv/bin/csvsort
 
 $ csvsort --help
```

## Code block 21: `$ type csvsql`

- id: `list-of-command-line-tools.html:block:21`
- hash: `d9c1639c`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type csvsql
-csvsql is /usr/bin/csvsql
+csvsql is /opt/uv/bin/csvsql
 
 $ csvsql --help
```

## Code block 22: `$ type csvstack`

- id: `list-of-command-line-tools.html:block:22`
- hash: `9423a16a`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type csvstack
-csvstack is /usr/bin/csvstack
+csvstack is /opt/uv/bin/csvstack
 
 $ csvstack --help
```

## Code block 23: `$ type csvstat`

- id: `list-of-command-line-tools.html:block:23`
- hash: `226e4f65`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type csvstat
-csvstat is /usr/bin/csvstat
+csvstat is /opt/uv/bin/csvstat
 
 $ csvstat --help
```

## Code block 27: `$ type dseq`

- id: `list-of-command-line-tools.html:block:27`
- hash: `c544aaa1`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -3,5 +3,5 @@
 
 $ dseq 3
-2021-12-15
-2021-12-16
-2021-12-17
+2026-11-09
+2026-11-10
+2026-11-11
```

## Code block 32: `$ type find`

- id: `list-of-command-line-tools.html:block:32`
- hash: `720530b2`
- status: **accept**
- cause: uutils
- note: Timestamps and ls sort order (uutils sorts by byte value)

```diff
--- 2e
+++ 2.5e
@@ -5,9 +5,9 @@
 
 $ find /data -type f -name '*.csv' -size -3
-/data/ch03/tmnt-basic.csv
 /data/ch03/tmnt-missing-newline.csv
 /data/ch03/tmnt-with-header.csv
+/data/ch03/tmnt-basic.csv
+/data/ch07/datatypes.csv
+/data/ch05/names.csv
+/data/ch05/names-comma.csv
 /data/ch05/irismeta.csv
-/data/ch05/names-comma.csv
-/data/ch05/names.csv
-/data/ch07/datatypes.csv
```

## Code block 42: `$ type hostname`

- id: `list-of-command-line-tools.html:block:42`
- hash: `0a1321f2`
- status: **accept**
- cause: random
- note: Container hostname

```diff
--- 2e
+++ 2.5e
@@ -5,5 +5,5 @@
 
 $ hostname
-2c3edb64827b
+275d70357142
 
 $ hostname -i
```

## Code block 43: `$ type in2csv`

- id: `list-of-command-line-tools.html:block:43`
- hash: `aab9deab`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type in2csv
-in2csv is /usr/bin/in2csv
+in2csv is /opt/uv/bin/in2csv
 
 $ in2csv --help
```

## Code block 45: `$ type json2csv`

- id: `list-of-command-line-tools.html:block:45`
- hash: `24f5a238`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type json2csv
-json2csv is /usr/bin/json2csv
+json2csv is /usr/local/bin/json2csv
 
 $ json2csv --help
```

## Code block 46: `$ type l`

- id: `list-of-command-line-tools.html:block:46`
- hash: `782f7f72`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -10,8 +10,8 @@
 $ l
 total 924K
--rw-r--r-- 1 dst dst 627K Dec 14 12:03 logs.tar.gz
--rw-r--r-- 1 dst dst 189K Dec 14 12:03 r-datasets.db
--rw-r--r-- 1 dst dst  149 Dec 14 12:03 tmnt-basic.csv
--rw-r--r-- 1 dst dst  148 Dec 14 12:03 tmnt-missing-newline.csv
--rw-r--r-- 1 dst dst  181 Dec 14 12:03 tmnt-with-header.csv
--rw-r--r-- 1 dst dst  91K Dec 14 12:03 top2000.xlsx
+-rw-r--r-- 1 dst dst 627K Nov  8 21:49 logs.tar.gz
+-rw-r--r-- 1 dst dst 189K Nov  8 21:49 r-datasets.db
+-rw-r--r-- 1 dst dst  149 Nov  8 21:49 tmnt-basic.csv
+-rw-r--r-- 1 dst dst  148 Nov  8 21:49 tmnt-missing-newline.csv
+-rw-r--r-- 1 dst dst  181 Nov  8 21:49 tmnt-with-header.csv
+-rw-r--r-- 1 dst dst  91K Nov  8 21:49 top2000.xlsx
```

## Code block 48: `$ type ls`

- id: `list-of-command-line-tools.html:block:48`
- hash: `d40db31c`
- status: **accept**
- cause: image
- note: No csvconf directory in /data anymore

```diff
--- 2e
+++ 2.5e
@@ -5,3 +5,3 @@
 
 $ ls /data
-ch02  ch03  ch04  ch05  ch06  ch07  ch08  ch09  ch10  csvconf
+ch02  ch03  ch04  ch05  ch06  ch07  ch08  ch09  ch10
```

## Code block 54: `$ type nl`

- id: `list-of-command-line-tools.html:block:54`
- hash: `a6c6d789`
- status: **accept**
- cause: quarto-term
- note: quarto-term 0.7.3 leaves the invisible byte-order mark (U+FEFF) at the start of the text out of the terminal, because avt gave it a column (asciinema/avt#27); it shows nothing either way

```diff
--- 2e
+++ 2.5e
@@ -5,5 +5,5 @@
 
 $ nl /data/ch05/alice.txt | head
-     1  ﻿Project Gutenberg's Alice's Adventures in Wonderland, by Lewis Carroll
+     1  Project Gutenberg's Alice's Adventures in Wonderland, by Lewis Carroll
      2
      3  This eBook is for the use of anyone anywhere at no cost and with
```

## Code block 56: `$ type paste`

- id: `list-of-command-line-tools.html:block:56`
- hash: `65584270`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -5,9 +5,9 @@
 
 $ paste -d, <(seq 5) <(dseq 5)
-1,2021-12-15
-2,2021-12-16
-3,2021-12-17
-4,2021-12-18
-5,2021-12-19
+1,2026-11-09
+2,2026-11-10
+3,2026-11-11
+4,2026-11-12
+5,2026-11-13
 
 $ seq 5 | paste -sd+
```

## Code block 58: `$ type pip`

- id: `list-of-command-line-tools.html:block:58`
- hash: `69a4bcb9`
- status: **accept**
- cause: image
- note: pip is a uv shim; pip freeze shows the uv environment

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type pip
-pip is /usr/bin/pip
+pip is /usr/local/bin/pip
 
 $ man pip
@@ -7,4 +7,3 @@
 
 $ pip freeze | grep sci
-scikit-learn==0.24.2
-scipy==1.7.0
+Using Python 3.13.18 environment at: /opt/venv
```

## Code block 59: `$ type pup`

- id: `list-of-command-line-tools.html:block:59`
- hash: `05fd273e`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type pup
-pup is /usr/bin/pup
+pup is /usr/local/bin/pup
 
 $ pup --help
```

## Code block 65: `$ type rush`

- id: `list-of-command-line-tools.html:block:65`
- hash: `04a5e579`
- status: **accept**
- cause: image
- note: rush location; tibble 3 printing; starwars.csv 2021 snapshot capitalizes Lars

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type rush
-rush is /usr/local/lib/R/site-library/rush/exec/rush
+rush is /usr/local/bin/rush
 
 $ rush --help
@@ -8,5 +8,5 @@
 
 $ rush run --tidyverse 'filter(starwars, species == "Human") %>% select(name)'
-# A tibble: 35 x 1
+# A tibble: 35 × 1
    name
    <chr>
@@ -15,5 +15,5 @@
  3 Leia Organa
  4 Owen Lars
- 5 Beru Whitesun lars
+ 5 Beru Whitesun Lars
  6 Biggs Darklighter
  7 Obi-Wan Kenobi
@@ -21,3 +21,3 @@
  9 Wilhuff Tarkin
 10 Han Solo
-# … with 25 more rows
+# ℹ 25 more rows
```

## Code block 66: `$ type sample`

- id: `list-of-command-line-tools.html:block:66`
- hash: `24f40446`
- status: **accept**
- cause: random
- note: Random output (sample, shuf)

```diff
--- 2e
+++ 2.5e
@@ -1,12 +1,12 @@
 $ type sample
-sample is /usr/local/bin/sample
+sample is /opt/uv/bin/sample
 
 $ sample --help
 
 $ seq 1000 | sample -r 0.01 | trim 5
-160
-300
-337
-340
-434
-… with 6 more lines
+335
+414
+486
+649
+709
+… with 5 more lines
```

## Code block 71: `$ type shuf`

- id: `list-of-command-line-tools.html:block:71`
- hash: `246ef711`
- status: **accept**
- cause: random
- note: Random output (sample, shuf)

```diff
--- 2e
+++ 2.5e
@@ -5,16 +5,16 @@
 
 $ echo {a..z} | tr ' ' '\n' | shuf | trim 5
-s
+l
+q
+u
+j
 a
-k
-x
-y
 … with 21 more lines
 
 $ shuf -i 1-100 | trim 5
-61
-60
-5
-92
-10
+27
+19
+9
+100
+98
 … with 95 more lines
```

## Code block 76: `$ type sql2csv`

- id: `list-of-command-line-tools.html:block:76`
- hash: `636babb4`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type sql2csv
-sql2csv is /usr/bin/sql2csv
+sql2csv is /opt/uv/bin/sql2csv
 
 $ sql2csv --help
```

## Code block 80: `$ type tapkee`

- id: `list-of-command-line-tools.html:block:80`
- hash: `fbaf9f20`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type tapkee
-tapkee is /usr/bin/tapkee
+tapkee is /usr/local/bin/tapkee
 
 $ tapkee --help
```

## Code block 84: `$ type tldr`

- id: `list-of-command-line-tools.html:block:84`
- hash: `20a9a30f`
- status: **accept**
- cause: image
- note: tldr is tealdeer: different location and pages

```diff
--- 2e
+++ 2.5e
@@ -1,19 +1,17 @@
 $ type tldr
-tldr is /usr/local/bin/tldr
+tldr is /usr/bin/tldr
 
 $ tldr --help
 
 $ tldr tar | trim
-✔ Page not found. Updating cache...
-✔ Creating index...
-
-  tar
 
   Archiving utility.
-  Often combined with a compression method, such as gzip or bzip2.
-  More information: https://www.gnu.org/software/tar.
+  Often combined with a compression method, such as `gzip` or `bzip2`.
+  More information: <https://www.gnu.org/software/tar/manual/tar.html>.
 
-  - [c]reate an archive and write it to a [f]ile:
-    tar cf target.tar file1 file2 file3
+  [c]reate an archive and write it to a [f]ile:
 
-… with 22 more lines
+      tar cf path/to/target.tar path/to/file1 path/to/file2 ...
+
+  [c]reate a g[z]ipped archive and write it to a [f]ile:
+… with 27 more lines
```

## Code block 86: `$ type tree`

- id: `list-of-command-line-tools.html:block:86`
- hash: `005c65cc`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -15,3 +15,3 @@
 │   │   ├── logs.tar.gz
 │   │   ├── r-datasets.db
-… with 121572 more lines
+… with 105453 more lines
```

## Code block 88: `$ type ts`

- id: `list-of-command-line-tools.html:block:88`
- hash: `3cf96bee`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -3,3 +3,3 @@
 
 $ echo seq 5 | sample -d 500 | ts
-Dec 14 12:07:20 seq 5
+Nov 08 21:50:16 seq 5
```

## Code block 99: `$ type xsv`

- id: `list-of-command-line-tools.html:block:99`
- hash: `c4bbf5eb`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type xsv
-xsv is /usr/bin/xsv
+xsv is /usr/local/bin/xsv
 
 $ xsv --help
```

## Prose (replace): All command-line tools listed here are included in the Docker image. S

- id: `list-of-command-line-tools.html:prose:c37b8d38`
- hash: `43011537`
- status: **accept**
- cause: content
- note: Content pass: the versions are those of the current image; the printed book's image is :20210628

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-All command-line tools listed here are included in the Docker image. See Chapter 2 for instructions on how to set it up. Please note that citing open source software is not trivial, and that some information may be missing or incorrect.
+All command-line tools listed here are included in the Docker image. See Chapter 2 for instructions on how to set it up. The versions listed are the ones in the current Docker image; the image used for the printed book is available as datasciencetoolbox/dsatcl2e:20210628. Please note that citing open source software is not trivial, and that some information may be missing or incorrect.
```

## Prose (replace): Pattern scanning and text processing language. awk (version 1.3.4) by 

- id: `list-of-command-line-tools.html:prose:456f670d`
- hash: `d02a7140`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Pattern scanning and text processing language. awk (version 1.3.4) by Mike D. Brennan and Thomas E. Dickey (2019). More information: https://invisible-island.net/mawk.
+Pattern scanning and text processing language. awk (version 1.3.4 20260129) by Mike D. Brennan and Thomas E. Dickey (2026). More information: https://invisible-island.net/mawk.
```

## Prose (replace): Unified tool to manage AWS services. aws (version 2.1.32) by Amazon We

- id: `list-of-command-line-tools.html:prose:c10cdf0c`
- hash: `ae66183a`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Unified tool to manage AWS services. aws (version 2.1.32) by Amazon Web Services (2021). More information: https://aws.amazon.com/cli.
+Unified tool to manage AWS services. aws (version 2.31.35) by Amazon Web Services (2025). More information: https://aws.amazon.com/cli.
```

## Prose (replace): GNU Bourne-Again SHell. bash (version 5.0.17) by Brian Fox and Chet Ra

- id: `list-of-command-line-tools.html:prose:0a5519b1`
- hash: `5ce2c14e`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-GNU Bourne-Again SHell. bash (version 5.0.17) by Brian Fox and Chet Ramey (2019). More information: https://www.gnu.org/software/bash.
+GNU Bourne-Again SHell. bash (version 5.3.9) by Brian Fox and Chet Ramey (2025). More information: https://www.gnu.org/software/bash.
```

## Prose (replace): A cat clone with syntax highlighting and Git integration. bat (version

- id: `list-of-command-line-tools.html:prose:a00804b2`
- hash: `2dc08086`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-A cat clone with syntax highlighting and Git integration. bat (version 0.18.0) by David Peter (2021). More information: https://github.com/sharkdp/bat.
+A cat clone with syntax highlighting and Git integration. bat (version 0.25.0) by David Peter (2025). More information: https://github.com/sharkdp/bat.
```

## Prose (replace): Concatenate files and print on the standard output. cat (version 8.30)

- id: `list-of-command-line-tools.html:prose:1cab527f`
- hash: `cf48ae02`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Concatenate files and print on the standard output. cat (version 8.30) by Torbjorn Granlund and Richard M. Stallman (2018). More information: https://www.gnu.org/software/coreutils.
+Concatenate files and print on the standard output. cat (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): Change file mode bits. chmod (version 8.30) by David MacKenzie and Jim

- id: `list-of-command-line-tools.html:prose:7ac02296`
- hash: `ab3178ec`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Change file mode bits. chmod (version 8.30) by David MacKenzie and Jim Meyering (2018). I use chmod in Chapter 4 to make a tool executable. More information: https://www.gnu.org/software/coreutils.
+Change file mode bits. chmod (version 0.10.0) by the uutils contributors (2026). I use chmod in Chapter 4 to make a tool executable. More information: https://github.com/uutils/coreutils.
```

## Prose (replace): Columnate lists. column (version 2.36.1) by Karel Zak (2021). More inf

- id: `list-of-command-line-tools.html:prose:1536ddff`
- hash: `4f2a1e75`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Columnate lists. column (version 2.36.1) by Karel Zak (2021). More information: https://www.kernel.org/pub/linux/utils/util-linux.
+Columnate lists. column (version 2.41.3) by Karel Zak (2025). More information: https://www.kernel.org/pub/linux/utils/util-linux.
```

## Prose (replace): Copy files and directories. cp (version 8.30) by Torbjorn Granlund, Da

- id: `list-of-command-line-tools.html:prose:75ede25c`
- hash: `73950416`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Copy files and directories. cp (version 8.30) by Torbjorn Granlund, David MacKenzie, and Jim Meyering (2018). More information: https://www.gnu.org/software/coreutils.
+Copy files and directories. cp (version 9.7) by Torbjorn Granlund, David MacKenzie, and Jim Meyering (2025). More information: https://www.gnu.org/software/coreutils.
```

## Prose (replace): Filter and truncate CSV files. csvcut (version 1.0.5) by Christopher G

- id: `list-of-command-line-tools.html:prose:a068d689`
- hash: `6694722b`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Filter and truncate CSV files. csvcut (version 1.0.5) by Christopher Groskopf (2020). More information: https://csvkit.rtfd.org.
+Filter and truncate CSV files. csvcut (version 1.1.0) by Christopher Groskopf (2023). More information: https://csvkit.rtfd.org.
```

## Prose (replace): Search CSV files. csvgrep (version 1.0.5) by Christopher Groskopf (202

- id: `list-of-command-line-tools.html:prose:d4df10b0`
- hash: `61230b03`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Search CSV files. csvgrep (version 1.0.5) by Christopher Groskopf (2020). More information: https://csvkit.rtfd.org.
+Search CSV files. csvgrep (version 1.1.0) by Christopher Groskopf (2023). More information: https://csvkit.rtfd.org.
```

## Prose (replace): Execute a SQL-like join to merge CSV files on a specified column or co

- id: `list-of-command-line-tools.html:prose:6b6924eb`
- hash: `c01b1820`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Execute a SQL-like join to merge CSV files on a specified column or columns. csvjoin (version 1.0.5) by Christopher Groskopf (2020). More information: https://csvkit.rtfd.org.
+Execute a SQL-like join to merge CSV files on a specified column or columns. csvjoin (version 1.1.0) by Christopher Groskopf (2023). More information: https://csvkit.rtfd.org.
```

## Prose (replace): Render a CSV file in the console as a Markdown-compatible, fixed-width

- id: `list-of-command-line-tools.html:prose:42ccf4d7`
- hash: `3cd43340`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Render a CSV file in the console as a Markdown-compatible, fixed-width table. csvlook (version 1.0.5) by Christopher Groskopf (2020). More information: https://csvkit.rtfd.org.
+Render a CSV file in the console as a Markdown-compatible, fixed-width table. csvlook (version 1.1.0) by Christopher Groskopf (2023). More information: https://csvkit.rtfd.org.
```

## Prose (replace): Sort CSV files. csvsort (version 1.0.5) by Christopher Groskopf (2020)

- id: `list-of-command-line-tools.html:prose:3058557d`
- hash: `f567551b`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Sort CSV files. csvsort (version 1.0.5) by Christopher Groskopf (2020). More information: https://csvkit.rtfd.org.
+Sort CSV files. csvsort (version 1.1.0) by Christopher Groskopf (2023). More information: https://csvkit.rtfd.org.
```

## Prose (replace): Execute SQL statements on CSV files. csvsql (version 1.0.5) by Christo

- id: `list-of-command-line-tools.html:prose:984c6061`
- hash: `397bf537`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Execute SQL statements on CSV files. csvsql (version 1.0.5) by Christopher Groskopf (2020). More information: https://csvkit.rtfd.org.
+Execute SQL statements on CSV files. csvsql (version 1.1.0) by Christopher Groskopf (2023). More information: https://csvkit.rtfd.org.
```

## Prose (replace): Stack up the rows from multiple CSV files. csvstack (version 1.0.5) by

- id: `list-of-command-line-tools.html:prose:51585555`
- hash: `f0118b3f`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Stack up the rows from multiple CSV files. csvstack (version 1.0.5) by Christopher Groskopf (2020). More information: https://csvkit.rtfd.org.
+Stack up the rows from multiple CSV files. csvstack (version 1.1.0) by Christopher Groskopf (2023). More information: https://csvkit.rtfd.org.
```

## Prose (replace): Print descriptive statistics for each column in a CSV file. csvstat (v

- id: `list-of-command-line-tools.html:prose:79f3a73b`
- hash: `bec2e4ed`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Print descriptive statistics for each column in a CSV file. csvstat (version 1.0.5) by Christopher Groskopf (2020). More information: https://csvkit.rtfd.org.
+Print descriptive statistics for each column in a CSV file. csvstat (version 1.1.0) by Christopher Groskopf (2023). More information: https://csvkit.rtfd.org.
```

## Prose (replace): Transfer a URL. curl (version 7.68.0) by Daniel Stenberg (2016). More 

- id: `list-of-command-line-tools.html:prose:2944e175`
- hash: `c6be4e45`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Transfer a URL. curl (version 7.68.0) by Daniel Stenberg (2016). More information: https://curl.haxx.se.
+Transfer a URL. curl (version 8.18.0) by Daniel Stenberg (2026). More information: https://curl.se.
```

## Prose (replace): Remove sections from each line of files. cut (version 8.30) by David M

- id: `list-of-command-line-tools.html:prose:d6fc3800`
- hash: `8d18a9be`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Remove sections from each line of files. cut (version 8.30) by David M. Ihnat, David MacKenzie, and Jim Meyering (2019). More information: https://www.gnu.org/software/coreutils.
+Remove sections from each line of files. cut (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): Displays an image or image sequence on any X server. display (version 

- id: `list-of-command-line-tools.html:prose:f67553b8`
- hash: `185480e7`
- status: **accept**
- cause: content
- note: Content pass: display is the book's own shell function, not ImageMagick (which isn't in the image)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Displays an image or image sequence on any X server. display (version 6.9.10-23) by ImageMagick Studio LLC (2019). More information: https://imagemagick.org.
+Insert an image into this book. display is a shell function that I use to insert images into this book while it’s being rendered, so it isn’t available in the Docker image (see Chapter 7). ImageMagick’s display, which shows an image on an X server, isn’t installed either.
```

## Prose (replace): Run a program in a modified environment. env (version 8.30) by Richard

- id: `list-of-command-line-tools.html:prose:4869dc41`
- hash: `3e6c52a0`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Run a program in a modified environment. env (version 8.30) by Richard Mlynarik, David MacKenzie, and Assaf Gordon (2018). More information: https://www.gnu.org/software/coreutils.
+Run a program in a modified environment. env (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): Search for files in a directory hierarchy. find (version 4.7.0) by Eri

- id: `list-of-command-line-tools.html:prose:1ad273c5`
- hash: `c9fe6ca0`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Search for files in a directory hierarchy. find (version 4.7.0) by Eric B. Decker, James Youngman, and Kevin Dalley (2019). More information: https://www.gnu.org/software/findutils.
+Search for files in a directory hierarchy. find (version 4.10.0) by Eric B. Decker, James Youngman, and Kevin Dalley (2024). More information: https://www.gnu.org/software/findutils.
```

## Prose (replace): Wrap each input line to fit in specified width. fold (version 8.30) by

- id: `list-of-command-line-tools.html:prose:0a13efd0`
- hash: `a61e9ed5`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Wrap each input line to fit in specified width. fold (version 8.30) by David MacKenzie (2020). More information: https://www.gnu.org/software/coreutils.
+Wrap each input line to fit in specified width. fold (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): Interactive JSON viewer. fx (version 20.0.2) by Anton Medvedev (2020).

- id: `list-of-command-line-tools.html:prose:ffe9d1ba`
- hash: `e08c12c3`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Interactive JSON viewer. fx (version 20.0.2) by Anton Medvedev (2020). More information: https://github.com/antonmedv/fx.
+Interactive JSON viewer. fx (version 40.0.1) by Anton Medvedev (2026). More information: https://github.com/antonmedv/fx.
```

## Prose (replace): The stupid content tracker. git (version 2.25.1) by Linus Torvalds and

- id: `list-of-command-line-tools.html:prose:a6d532bd`
- hash: `11272e75`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-The stupid content tracker. git (version 2.25.1) by Linus Torvalds and Junio C. Hamano (2021). More information: https://git-scm.com.
+The stupid content tracker. git (version 2.53.0) by Linus Torvalds and Junio C. Hamano (2026). More information: https://git-scm.com.
```

## Prose (replace): Print lines that match patterns. grep (version 3.4) by Jim Meyering (2

- id: `list-of-command-line-tools.html:prose:584b9e83`
- hash: `1a8aafa4`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Print lines that match patterns. grep (version 3.4) by Jim Meyering (2019). More information: https://www.gnu.org/software/grep.
+Print lines that match patterns. grep (version 3.12) by Jim Meyering (2025). More information: https://www.gnu.org/software/grep.
```

## Prose (replace): Make JSON greppable. gron (version 0.6.1) by Tom Hudson (2021). More i

- id: `list-of-command-line-tools.html:prose:918ad2ff`
- hash: `f86ff335`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Make JSON greppable. gron (version 0.6.1) by Tom Hudson (2021). More information: https://github.com/TomNomNom/gron.
+Make JSON greppable. gron (version 0.7.1) by Tom Hudson (2022). More information: https://github.com/TomNomNom/gron.
```

## Prose (replace): Output the first part of files. head (version 8.30) by David MacKenzie

- id: `list-of-command-line-tools.html:prose:504ab555`
- hash: `a5b90b83`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Output the first part of files. head (version 8.30) by David MacKenzie and Jim Meyering (2019). More information: https://www.gnu.org/software/coreutils.
+Output the first part of files. head (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): Show or set the system’s host name. hostname (version 3.23) by Peter T

- id: `list-of-command-line-tools.html:prose:5d900a5a`
- hash: `cf7251d4`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Show or set the system’s host name. hostname (version 3.23) by Peter Tobias, Bernd Eckenfels, and Michael Meskes (2021). More information: https://sourceforge.net/projects/net-tools/.
+Show or set the system’s host name. hostname (version 3.25) by Peter Tobias, Bernd Eckenfels, and Michael Meskes (2024). More information: https://sourceforge.net/projects/net-tools/.
```

## Prose (replace): Convert common, but less awesome, tabular data formats to CSV. in2csv 

- id: `list-of-command-line-tools.html:prose:32273d63`
- hash: `a9906375`
- status: **accept**
- cause: content
- note: Content pass: in2csv's new version, and the new entry for ir (used by rush's generated scripts)

```diff
--- 2e
+++ 2.5e
@@ -1 +1,3 @@
-Convert common, but less awesome, tabular data formats to CSV. in2csv (version 1.0.5) by Christopher Groskopf (2020). More information: https://csvkit.rtfd.org.
+Convert common, but less awesome, tabular data formats to CSV. in2csv (version 1.1.0) by Christopher Groskopf (2023). More information: https://csvkit.rtfd.org.
+ir
+Run standalone R scripts from embedded dependency metadata. ir (version 0.4.1) by Tomasz Kalinowski (2026). More information: https://github.com/r-lib/ir.
```

## Prose (replace): Command-line JSON processor. jq (version 1.6) by Stephen Dolan (2021).

- id: `list-of-command-line-tools.html:prose:88b3b5d2`
- hash: `823a9b6b`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Command-line JSON processor. jq (version 1.6) by Stephen Dolan (2021). More information: https://stedolan.github.com/jq.
+Command-line JSON processor. jq (version 1.8.1) by Stephen Dolan (2025). More information: https://jqlang.org.
```

## Prose (replace): opposite of more. less (version 551) by Mark Nudelman (2019). More inf

- id: `list-of-command-line-tools.html:prose:16f92f97`
- hash: `31e923b1`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-opposite of more. less (version 551) by Mark Nudelman (2019). More information: https://www.greenwoodsoftware.com/less.
+opposite of more. less (version 668) by Mark Nudelman (2024). More information: https://www.greenwoodsoftware.com/less.
```

## Prose (replace): List directory contents. ls (version 8.30) by Richard M. Stallman and 

- id: `list-of-command-line-tools.html:prose:06f10809`
- hash: `f1532473`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-List directory contents. ls (version 8.30) by Richard M. Stallman and David MacKenzie (2019). More information: https://www.gnu.org/software/coreutils.
+List directory contents. ls (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): A Program for Maintaining Computer Programs. make (version 4.3) by Stu

- id: `list-of-command-line-tools.html:prose:6a8926d8`
- hash: `452340ad`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-A Program for Maintaining Computer Programs. make (version 4.3) by Stuart I. Feldman (2020). More information: https://www.gnu.org/software/make.
+A Program for Maintaining Computer Programs. make (version 4.4.1) by Stuart I. Feldman (2023). More information: https://www.gnu.org/software/make.
```

## Prose (replace): An interface to the system reference manuals. man (version 2.9.1) by J

- id: `list-of-command-line-tools.html:prose:5d7ed484`
- hash: `031fd5c6`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-An interface to the system reference manuals. man (version 2.9.1) by John W. Eaton and Colin Watson (2020). More information: https://nongnu.org/man-db.
+An interface to the system reference manuals. man (version 2.13.1) by John W. Eaton and Colin Watson (2025). More information: https://nongnu.org/man-db.
```

## Prose (replace): Make directories. mkdir (version 8.30) by David MacKenzie (2019). More

- id: `list-of-command-line-tools.html:prose:e780bee3`
- hash: `0338a533`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Make directories. mkdir (version 8.30) by David MacKenzie (2019). More information: https://www.gnu.org/software/coreutils.
+Make directories. mkdir (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): Move (rename) files. mv (version 8.30) by Mike Parker, David MacKenzie

- id: `list-of-command-line-tools.html:prose:1d3361f1`
- hash: `2eeedcf3`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Move (rename) files. mv (version 8.30) by Mike Parker, David MacKenzie, and Jim Meyering (2020). More information: https://www.gnu.org/software/coreutils.
+Move (rename) files. mv (version 9.7) by Mike Parker, David MacKenzie, and Jim Meyering (2025). More information: https://www.gnu.org/software/coreutils.
```

## Prose (replace): Nano’s ANOther editor, inspired by Pico. nano (version 5.4) by Benno S

- id: `list-of-command-line-tools.html:prose:f659002f`
- hash: `92500ede`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Nano’s ANOther editor, inspired by Pico. nano (version 5.4) by Benno Schulenberg, David Lawrence Ramsey, Jordi Mallach, Chris Allegretta, Robert Siemborski, and Adam Rogoyski (2020). More information: https://nano-editor.org.
+Nano’s ANOther editor, inspired by Pico. nano (version 8.7.1) by Benno Schulenberg, David Lawrence Ramsey, Jordi Mallach, Chris Allegretta, Robert Siemborski, and Adam Rogoyski (2026). More information: https://nano-editor.org.
```

## Prose (replace): Number lines of files. nl (version 8.30) by Scott Bartram and David Ma

- id: `list-of-command-line-tools.html:prose:ee2750cf`
- hash: `c9be6b3b`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Number lines of files. nl (version 8.30) by Scott Bartram and David MacKenzie (2020). More information: https://www.gnu.org/software/coreutils.
+Number lines of files. nl (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): Build and execute shell command lines from standard input in parallel.

- id: `list-of-command-line-tools.html:prose:11325d26`
- hash: `999f5828`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Build and execute shell command lines from standard input in parallel. parallel (version 20161222) by Ole Tange (2016). More information: https://www.gnu.org/software/parallel.
+Build and execute shell command lines from standard input in parallel. parallel (version 20240222) by Ole Tange (2024). More information: https://www.gnu.org/software/parallel.
```

## Prose (replace): Merge lines of files. paste (version 8.30) by David M. Ihnat and David

- id: `list-of-command-line-tools.html:prose:f7ccd2ed`
- hash: `4ab8d4bf`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Merge lines of files. paste (version 8.30) by David M. Ihnat and David MacKenzie (2019). More information: https://www.gnu.org/software/coreutils.
+Merge lines of files. paste (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): A tool for installing and managing Python packages. pip (version 20.0.

- id: `list-of-command-line-tools.html:prose:c5ce6a12`
- hash: `96bb3d2b`
- status: **accept**
- cause: content
- note: Content pass: pip runs `uv pip` in the image

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-A tool for installing and managing Python packages. pip (version 20.0.2) by PyPA (2020). More information: https://pip.pypa.io.
+A tool for installing and managing Python packages. pip (version 0.13.7) by Astral (2026). In the Docker image, pip runs uv pip, the pip interface of uv, so the version and author are those of uv. More information: https://docs.astral.sh/uv.
```

## Prose (replace): Print name of working directory. pwd (version 8.30) by Jim Meyering (2

- id: `list-of-command-line-tools.html:prose:e8da900d`
- hash: `193df83b`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Print name of working directory. pwd (version 8.30) by Jim Meyering (2019). More information: https://www.gnu.org/software/coreutils.
+Print name of working directory. pwd (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): An interpreted, interactive, object-oriented programming language. pyt

- id: `list-of-command-line-tools.html:prose:eb6a0066`
- hash: `1a509564`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-An interpreted, interactive, object-oriented programming language. python (version 3.8.5) by The Python Software Foundation (2021). More information: https://www.python.org.
+An interpreted, interactive, object-oriented programming language. python (version 3.13.18) by The Python Software Foundation (2026). More information: https://www.python.org.
```

## Prose (replace): A Language and Environment for Statistical Computing. R (version 4.0.4

- id: `list-of-command-line-tools.html:prose:10405949`
- hash: `d7c0bc44`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-A Language and Environment for Statistical Computing. R (version 4.0.4) by The R Foundation for Statistical Computing (2021). More information: https://www.r-project.org.
+A Language and Environment for Statistical Computing. R (version 4.5.2) by The R Foundation for Statistical Computing (2025). More information: https://www.r-project.org.
```

## Prose (replace): Reverse lines characterwise. rev (version 2.36.1) by Karel Zak (2021).

- id: `list-of-command-line-tools.html:prose:e777f37d`
- hash: `194ff7a1`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Reverse lines characterwise. rev (version 2.36.1) by Karel Zak (2021). More information: https://www.kernel.org/pub/linux/utils/util-linux.
+Reverse lines characterwise. rev (version 2.41.3) by Karel Zak (2025). More information: https://www.kernel.org/pub/linux/utils/util-linux.
```

## Prose (replace): Remove files or directories. rm (version 8.30) by Paul Rubin, David Ma

- id: `list-of-command-line-tools.html:prose:71a54ee8`
- hash: `82db0035`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Remove files or directories. rm (version 8.30) by Paul Rubin, David MacKenzie, Richard M. Stallman, and Jim Meyering (2019). More information: https://www.gnu.org/software/coreutils.
+Remove files or directories. rm (version 9.7) by Paul Rubin, David MacKenzie, Richard M. Stallman, and Jim Meyering (2025). More information: https://www.gnu.org/software/coreutils.
```

## Prose (replace): R One-Liners from the Shell. rush (version 0.1) by Jeroen Janssens (20

- id: `list-of-command-line-tools.html:prose:1ce9372d`
- hash: `aababc2b`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-R One-Liners from the Shell. rush (version 0.1) by Jeroen Janssens (2021). More information: https://github.com/jeroenjanssens/rush.
+R One-Liners from the Shell. rush (version 0.2.1.9000) by Jeroen Janssens (2026). More information: https://github.com/jeroenjanssens/rush.
```

## Prose (replace): Filter lines from standard input according to some probability, with a

- id: `list-of-command-line-tools.html:prose:ce9be56f`
- hash: `e0c7be48`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Filter lines from standard input according to some probability, with a given delay, and for a certain duration. sample (version 0.2.4) by Jeroen Janssens (2021). More information: https://github.com/jeroenjanssens/sample.
+Filter lines from standard input according to some probability, with a given delay, and for a certain duration. sample (version 0.2.5) by Jeroen Janssens (2021). More information: https://github.com/jeroenjanssens/sample.
```

## Prose (replace): OpenSSH secure file copy. scp (version 1:8.2p1-4ubuntu0.2) by Timo Rin

- id: `list-of-command-line-tools.html:prose:9e0f712b`
- hash: `033c58bf`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-OpenSSH secure file copy. scp (version 1:8.2p1-4ubuntu0.2) by Timo Rinne and Tatu Ylonen (2019). More information: https://www.openssh.com.
+OpenSSH secure file copy. scp (version 10.2p1) by Timo Rinne and Tatu Ylonen (2025). More information: https://www.openssh.com.
```

## Prose (replace): Stream editor for filtering and transforming text. sed (version 4.7) b

- id: `list-of-command-line-tools.html:prose:264e6a27`
- hash: `866d004c`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Stream editor for filtering and transforming text. sed (version 4.7) by Jay Fenlason, Tom Lord, Ken Pizzini, and Paolo Bonzini (2018). More information: https://www.gnu.org/software/sed.
+Stream editor for filtering and transforming text. sed (version 4.9) by Jay Fenlason, Tom Lord, Ken Pizzini, and Paolo Bonzini (2022). More information: https://www.gnu.org/software/sed.
```

## Prose (replace): Print a sequence of numbers. seq (version 8.30) by Ulrich Drepper (201

- id: `list-of-command-line-tools.html:prose:aa67ebf1`
- hash: `e5f6bde6`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Print a sequence of numbers. seq (version 8.30) by Ulrich Drepper (2019). More information: https://www.gnu.org/software/coreutils.
+Print a sequence of numbers. seq (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): Generate random permutations. shuf (version 8.30) by Paul Eggert (2019

- id: `list-of-command-line-tools.html:prose:1d1adeed`
- hash: `8f628906`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Generate random permutations. shuf (version 8.30) by Paul Eggert (2019). More information: https://www.gnu.org/software/coreutils.
+Generate random permutations. shuf (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): SciKit-Learn Laboratory. skll (version 2.5.0) by Educational Testing S

- id: `list-of-command-line-tools.html:prose:f13d9b4b`
- hash: `9c45de23`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-SciKit-Learn Laboratory. skll (version 2.5.0) by Educational Testing Service (2021). The actual tool is run_experiment. I use the alias skll because I find that easier to remember. More information: https://skll.readthedocs.org.
+SciKit-Learn Laboratory. skll (version 5.1.0) by Educational Testing Service (2024). The actual tool is run_experiment. I use the alias skll because I find that easier to remember. More information: https://skll.readthedocs.io.
```

## Prose (replace): Sort lines of text files. sort (version 8.30) by Mike Haertel and Paul

- id: `list-of-command-line-tools.html:prose:7363a341`
- hash: `56b410a0`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Sort lines of text files. sort (version 8.30) by Mike Haertel and Paul Eggert (2019). More information: https://www.gnu.org/software/coreutils.
+Sort lines of text files. sort (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): Split a file into pieces. split (version 8.30) by Torbjorn Granlund an

- id: `list-of-command-line-tools.html:prose:a3e8a9fa`
- hash: `6c7d0bdc`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Split a file into pieces. split (version 8.30) by Torbjorn Granlund and Richard M. Stallman (2019). More information: https://www.gnu.org/software/coreutils.
+Split a file into pieces. split (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): Soak up standard input and write to a file. sponge (version 0.65) by C

- id: `list-of-command-line-tools.html:prose:3a2c1084`
- hash: `dd075127`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Soak up standard input and write to a file. sponge (version 0.65) by Colin Watson and Tollef Fog Heen (2021). Useful if you want to read from and write to the same file in a single pipeline. More information: https://joeyh.name/code/moreutils.
+Soak up standard input and write to a file. sponge (version 0.69) by Colin Watson and Tollef Fog Heen (2024). Useful if you want to read from and write to the same file in a single pipeline. More information: https://joeyh.name/code/moreutils.
```

## Prose (replace): Execute an SQL query on a database and output the result to a CSV file

- id: `list-of-command-line-tools.html:prose:1dae1104`
- hash: `2b5c882f`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Execute an SQL query on a database and output the result to a CSV file. sql2csv (version 1.0.5) by Christopher Groskopf (2020). More information: https://csvkit.rtfd.org.
+Execute an SQL query on a database and output the result to a CSV file. sql2csv (version 1.1.0) by Christopher Groskopf (2023). More information: https://csvkit.rtfd.org.
```

## Prose (replace): OpenSSH remote login client. ssh (version 1:8.2p1-4ubuntu0.2) by Tatu 

- id: `list-of-command-line-tools.html:prose:93c46c30`
- hash: `185c9428`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-OpenSSH remote login client. ssh (version 1:8.2p1-4ubuntu0.2) by Tatu Ylonen, Aaron Campbell, Bob Beck, Markus Friedl, Niels Provos, Theo Raadt, Dug Song, and Markus Friedl (2020). More information: https://www.openssh.com.
+OpenSSH remote login client. ssh (version 10.2p1) by Tatu Ylonen, Aaron Campbell, Bob Beck, Markus Friedl, Niels Provos, Theo Raadt, Dug Song, and Markus Friedl (2025). More information: https://www.openssh.com.
```

## Prose (replace): Execute a command as another user. sudo (version 1.8.31) by Todd C. Mi

- id: `list-of-command-line-tools.html:prose:d946836a`
- hash: `98eb904a`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Execute a command as another user. sudo (version 1.8.31) by Todd C. Miller (2019). More information: https://www.sudo.ws.
+Execute a command as another user. sudo (version 1.9.17p2) by Todd C. Miller (2025). More information: https://www.sudo.ws.
```

## Prose (replace): Output the last part of files. tail (version 8.30) by Paul Rubin, Davi

- id: `list-of-command-line-tools.html:prose:72366502`
- hash: `f6676b58`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Output the last part of files. tail (version 8.30) by Paul Rubin, David MacKenzie, Ian Lance Taylor, and Jim Meyering (2019). More information: https://www.gnu.org/software/coreutils.
+Output the last part of files. tail (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): An efficient dimension reduction library. tapkee (version 1.2) by Serg

- id: `list-of-command-line-tools.html:prose:a2164b63`
- hash: `d8534508`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-An efficient dimension reduction library. tapkee (version 1.2) by Sergey Lisitsyn, Christian Widmer, and Fernando J. Iglesias Garcia (2013). More information: http://tapkee.lisitsyn.me.
+An efficient dimension reduction library. tapkee (version 1.4.0) by Sergey Lisitsyn, Christian Widmer, and Fernando J. Iglesias Garcia (2026). More information: https://github.com/lisitsyn/tapkee.
```

## Prose (replace): An archiving utility. tar (version 1.30) by John Gilmore and Jay Fenla

- id: `list-of-command-line-tools.html:prose:1a4ba868`
- hash: `cf4124a7`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-An archiving utility. tar (version 1.30) by John Gilmore and Jay Fenlason (2014). More information: https://www.gnu.org/software/tar.
+An archiving utility. tar (version 1.35) by John Gilmore and Jay Fenlason (2023). More information: https://www.gnu.org/software/tar.
```

## Prose (replace): Read from standard input and write to standard output and files. tee (

- id: `list-of-command-line-tools.html:prose:0282cfc9`
- hash: `86cc6155`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Read from standard input and write to standard output and files. tee (version 8.30) by Mike Parker, Richard M. Stallman, and David MacKenzie (2019). More information: https://www.gnu.org/software/coreutils.
+Read from standard input and write to standard output and files. tee (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): User interface to the TELNET protocol. telnet (version 0.17) by Mats E

- id: `list-of-command-line-tools.html:prose:7e80dc1f`
- hash: `f53a9f71`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-User interface to the TELNET protocol. telnet (version 0.17) by Mats Erik Andersson, Andreas Henriksson, and Christoph Biedl (1999). More information: http://www.hcs.harvard.edu/~dholland/computers/netkit.html.
+User interface to the TELNET protocol. telnet (version 2.7) by the GNU Inetutils developers (2025). More information: https://www.gnu.org/software/inetutils.
```

## Prose (replace): Collaborative cheatsheets for console commands. tldr (version 3.3.7) b

- id: `list-of-command-line-tools.html:prose:adebf1ca`
- hash: `11c7804a`
- status: **accept**
- cause: content
- note: Content pass: tldr is tealdeer in the image

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Collaborative cheatsheets for console commands. tldr (version 3.3.7) by Owen Voke (2021). More information: https://tldr.sh.
+Collaborative cheatsheets for console commands. tldr (version 1.8.1) by Danilo Bargen and Niklas Mohrin (2025). In the Docker image, tldr is tealdeer, a client written in Rust. More information: https://github.com/tealdeer-rs/tealdeer.
```

## Prose (replace): Translate or delete characters. tr (version 8.30) by Jim Meyering (201

- id: `list-of-command-line-tools.html:prose:1a8c2d5a`
- hash: `38f07660`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Translate or delete characters. tr (version 8.30) by Jim Meyering (2018). More information: https://www.gnu.org/software/coreutils.
+Translate or delete characters. tr (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): List contents of directories in a tree-like format. tree (version 1.8.

- id: `list-of-command-line-tools.html:prose:19f62000`
- hash: `ccfcea5c`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-List contents of directories in a tree-like format. tree (version 1.8.0) by Steve Baker (2018). More information: https://launchpad.net/ubuntu/+source/tree.
+List contents of directories in a tree-like format. tree (version 2.3.1) by Steve Baker (2026). More information: https://oldmanprogrammer.net/source.php?dir=projects/tree.
```

## Prose (replace): Timestamp input. ts (version 0.65) by Joey Hess (2021). More informati

- id: `list-of-command-line-tools.html:prose:b5fe553d`
- hash: `bb0f9822`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Timestamp input. ts (version 0.65) by Joey Hess (2021). More information: https://joeyh.name/code/moreutils.
+Timestamp input. ts (version 0.69) by Joey Hess (2024). More information: https://joeyh.name/code/moreutils.
```

## Prose (replace): Report or omit repeated lines. uniq (version 8.30) by Richard M. Stall

- id: `list-of-command-line-tools.html:prose:08e2712a`
- hash: `199652a2`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Report or omit repeated lines. uniq (version 8.30) by Richard M. Stallman and David MacKenzie (2019). More information: https://www.gnu.org/software/coreutils.
+Report or omit repeated lines. uniq (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): Extract files from rar archives. unrar (version 0.0.1) by Ben Asselsti

- id: `list-of-command-line-tools.html:prose:c879ef8f`
- hash: `b5c57b35`
- status: **accept**
- cause: content
- note: Content pass: unrar is unrar-free in the image; the old URL (home.gna.org) is gone

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Extract files from rar archives. unrar (version 0.0.1) by Ben Asselstine, Christian Scheurer, and Johannes Winkelmann (2014). More information: http://home.gna.org/unrar.
+Extract files from rar archives. unrar (version 0.3.3) by Ben Asselstine, Christian Scheurer, and Johannes Winkelmann (2025). In the Docker image, unrar is unrar-free. More information: https://gitlab.com/bgermann/unrar-free.
```

## Prose (replace): Fast machine learning library for online learning. vw (version 8.10.1)

- id: `list-of-command-line-tools.html:prose:d3bde95f`
- hash: `f89a970f`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Fast machine learning library for online learning. vw (version 8.10.1) by John Langford (2021). More information: https://vowpalwabbit.org.
+Fast machine learning library for online learning. vw (version 9.11.9) by John Langford (2026). More information: https://vowpalwabbit.org.
```

## Prose (replace): Print newline, word, and byte counts for each file. wc (version 8.30) 

- id: `list-of-command-line-tools.html:prose:6191bbfb`
- hash: `cf5a1cb0`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Print newline, word, and byte counts for each file. wc (version 8.30) by Paul Rubin and David MacKenzie (2019). More information: https://www.gnu.org/software/coreutils.
+Print newline, word, and byte counts for each file. wc (version 0.10.0) by the uutils contributors (2026). More information: https://github.com/uutils/coreutils.
```

## Prose (replace): Decompress and concatenate files to standard output. zcat (version 1.1

- id: `list-of-command-line-tools.html:prose:57609e47`
- hash: `62eebfa7`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Decompress and concatenate files to standard output. zcat (version 1.10) by Paul Eggert (2021). More information: https://www.nongnu.org/zutils/zutils.html.
+Decompress and concatenate files to standard output. zcat (version 1.14) by Paul Eggert (2025). More information: https://www.gnu.org/software/gzip.
```

## Prose (replace): The Z shell. zsh (version 5.8) by Paul Falstad and Peter Stephenson (2

- id: `list-of-command-line-tools.html:prose:9848c0d4`
- hash: `79af2fc6`
- status: **accept**
- cause: content
- note: Content pass: version, year, authors, and URL of the tool in the current image (sources in compare/tool-versions.tsv)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-The Z shell. zsh (version 5.8) by Paul Falstad and Peter Stephenson (2020). More information: https://www.zsh.org.
+The Z shell. zsh (version 5.9) by Paul Falstad and Peter Stephenson (2022). More information: https://www.zsh.org.
```

## External links differ

- id: `list-of-command-line-tools.html:external-links`
- hash: `26296828`
- status: **accept**
- cause: content
- note: Content pass: links of the tools in the current image (uutils, curl.se, jqlang.org, uv, ...)

```diff
--- 2e
+++ 2.5e
@@ -7,2 +7,2 @@
-https://www.gnu.org/software/coreutils
-https://www.gnu.org/software/coreutils
+https://github.com/uutils/coreutils
+https://github.com/uutils/coreutils
@@ -23,3 +23,2 @@
-https://curl.haxx.se
-https://www.gnu.org/software/coreutils
-https://imagemagick.org
+https://curl.se
+https://github.com/uutils/coreutils
@@ -28 +27 @@
-https://www.gnu.org/software/coreutils
+https://github.com/uutils/coreutils
@@ -30 +29 @@
-https://www.gnu.org/software/coreutils
+https://github.com/uutils/coreutils
@@ -35 +34 @@
-https://www.gnu.org/software/coreutils
+https://github.com/uutils/coreutils
@@ -40 +39,2 @@
-https://stedolan.github.com/jq
+https://github.com/r-lib/ir
+https://jqlang.org
@@ -43 +43 @@
-https://www.gnu.org/software/coreutils
+https://github.com/uutils/coreutils
@@ -46 +46 @@
-https://www.gnu.org/software/coreutils
+https://github.com/uutils/coreutils
@@ -49 +49 @@
-https://www.gnu.org/software/coreutils
+https://github.com/uutils/coreutils
@@ -51 +51 @@
-https://www.gnu.org/software/coreutils
+https://github.com/uutils/coreutils
@@ -53 +53 @@
-https://pip.pypa.io
+https://docs.astral.sh/uv
@@ -55 +55 @@
-https://www.gnu.org/software/coreutils
+https://github.com/uutils/coreutils
@@ -64 +64 @@
-https://www.gnu.org/software/coreutils
+https://github.com/uutils/coreutils
@@ -66,4 +66,4 @@
-https://www.gnu.org/software/coreutils
-https://skll.readthedocs.org
-https://www.gnu.org/software/coreutils
-https://www.gnu.org/software/coreutils
+https://github.com/uutils/coreutils
+https://skll.readthedocs.io
+https://github.com/uutils/coreutils
+https://github.com/uutils/coreutils
@@ -74,2 +74,2 @@
-https://www.gnu.org/software/coreutils
-http://tapkee.lisitsyn.me
+https://github.com/uutils/coreutils
+https://github.com/lisitsyn/tapkee
@@ -77,5 +77,5 @@
-https://www.gnu.org/software/coreutils
-http://www.hcs.harvard.edu/~dholland/computers/netkit.html
-https://tldr.sh
-https://www.gnu.org/software/coreutils
-https://launchpad.net/ubuntu/+source/tree
+https://github.com/uutils/coreutils
+https://www.gnu.org/software/inetutils
+https://github.com/tealdeer-rs/tealdeer
+https://github.com/uutils/coreutils
+https://oldmanprogrammer.net/source.php?dir=projects/tree
@@ -84 +84 @@
-https://www.gnu.org/software/coreutils
+https://github.com/uutils/coreutils
@@ -86 +86 @@
-http://home.gna.org/unrar
+https://gitlab.com/bgermann/unrar-free
@@ -89 +89 @@
-https://www.gnu.org/software/coreutils
+https://github.com/uutils/coreutils
@@ -93 +93 @@
-https://www.nongnu.org/zutils/zutils.html
+https://www.gnu.org/software/gzip
```

