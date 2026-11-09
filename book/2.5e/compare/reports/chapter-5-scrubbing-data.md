# chapter-5-scrubbing-data.html

Image: `datasciencetoolbox/dsatcl2e@sha256:9cd9b96f9e1b3a286a103fef60b0c6129cae316735486f496571ddd1293ad4e1`

## Code block 0: `$ cd /data/ch05`

- id: `chapter-5-scrubbing-data.html:block:0`
- hash: `90a1ec3a`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -3,9 +3,9 @@
 $ l
 total 200K
--rw-r--r-- 1 dst dst 164K Dec 14 11:47 alice.txt
--rw-r--r-- 1 dst dst 4.5K Dec 14 11:47 iris.csv
--rw-r--r-- 1 dst dst  179 Dec 14 11:47 irismeta.csv
--rw-r--r-- 1 dst dst  160 Dec 14 11:47 names-comma.csv
--rw-r--r-- 1 dst dst  129 Dec 14 11:47 names.csv
--rw-r--r-- 1 dst dst 7.8K Dec 14 11:47 tips.csv
--rw-r--r-- 1 dst dst 5.1K Dec 14 11:47 users.json
+-rw-r--r-- 1 dst dst 164K Nov  9 17:54 alice.txt
+-rw-r--r-- 1 dst dst 4.5K Nov  9 17:54 iris.csv
+-rw-r--r-- 1 dst dst  179 Nov  9 17:54 irismeta.csv
+-rw-r--r-- 1 dst dst  160 Nov  9 17:54 names-comma.csv
+-rw-r--r-- 1 dst dst  129 Nov  9 17:54 names.csv
+-rw-r--r-- 1 dst dst 7.8K Nov  9 17:54 tips.csv
+-rw-r--r-- 1 dst dst 5.1K Nov  9 17:54 users.json
```

## Code block 17: `$ seq -f "Line %g" 1000 | sample -r 1%`

- id: `chapter-5-scrubbing-data.html:block:17`
- hash: `4b6e540d`
- status: **accept**
- cause: random
- note: sample draws other lines

```diff
--- 2e
+++ 2.5e
@@ -1,8 +1,10 @@
 $ seq -f "Line %g" 1000 | sample -r 1%
-Line 45
-Line 223
-Line 355
-Line 369
-Line 438
-Line 807
-Line 813
+Line 24
+Line 93
+Line 330
+Line 653
+Line 654
+Line 804
+Line 846
+Line 888
+Line 912
```

## Code block 18: `$ seq -f "Line %g" 1000 | sample -r 1% -d 1000 -s 5 | ts ➊`

- id: `chapter-5-scrubbing-data.html:block:18`
- hash: `1265db44`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -1,7 +1,7 @@
 $ seq -f "Line %g" 1000 | sample -r 1% -d 1000 -s 5 | ts ➊
-Dec 14 11:48:10 Line 58
-Dec 14 11:48:11 Line 60
-Dec 14 11:48:12 Line 230
-Dec 14 11:48:13 Line 250
-Dec 14 11:48:14 Line 785
-Dec 14 11:48:15 Line 786
+Nov 09 17:54:11 Line 211
+Nov 09 17:54:12 Line 372
+Nov 09 17:54:13 Line 504
+Nov 09 17:54:14 Line 720
+Nov 09 17:54:15 Line 742
+Nov 09 17:54:16 Line 783
```

## Code block 68: `$ curl -sL 'http://en.wikipedia.org/wiki/List_of_countries_and_territo`

- id: `chapter-5-scrubbing-data.html:block:68`
- hash: `102df3bd`
- status: **accept**
- cause: content
- note: Content pass: the Wikipedia page was deleted in January 2025; download the Internet Archive copy of October 2021 (the same bytes as before)

```diff
--- 2e
+++ 2.5e
@@ -1,2 +1,2 @@
-$ curl -sL 'http://en.wikipedia.org/wiki/List_of_countries_and_territories_by_bo
-rder/area_ratio' > wiki.html
+$ curl -sL 'https://web.archive.org/web/20211005234015id_/https://en.wikipedia.o
+rg/wiki/List_of_countries_and_territories_by_border/area_ratio' > wiki.html
```

## Code block 69: `$ < wiki.html trim`

- id: `chapter-5-scrubbing-data.html:block:69`
- hash: `096f2d19`
- status: **accept**
- cause: network
- note: Cached 2021 Wikipedia page (October 2021 snapshot), slightly different from the copy 2e fetched

```diff
--- 2e
+++ 2.5e
@@ -7,6 +7,6 @@
 <script>document.documentElement.className="client-js";RLCONF={"wgBreakFrames":…
 "Lists of countries by geography","Lists by area","Border-related lists"],"wgPa…
-"wgGENewcomerTasksGuidanceEnabled":true,"wgGEAskQuestionEnabled":false,"wgGELin…
-"ext.cx.eventlogging.campaigns","ext.centralNotice.geoIP","ext.centralNotice.st…
+"wgGELinkRecommendationsFrontendEnabled":!1,"wgCentralAuthMobileDomain":!1,"wgW…
+"ext.uls.compactlinks","ext.uls.interface","ext.cx.eventlogging.campaigns","ext…
 <script>(RLQ=window.RLQ||[]).push(function(){mw.loader.implement("user.options@…
-… with 3070 more lines
+… with 3071 more lines
```

## Prose (replace): Wikpedia holds a wealth of information. Much of this information is or

- id: `chapter-5-scrubbing-data.html:prose:817727e5`
- hash: `679ac23e`
- status: **accept**
- cause: content
- note: Content pass: say that the page was deleted and that a 2021 copy is used

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Wikpedia holds a wealth of information. Much of this information is ordered in tables, which can be regarded as data sets. For example, this page contains a list of countries and territories together with their border length, their area, and the ratio between the two.
+Wikpedia holds a wealth of information. Much of this information is ordered in tables, which can be regarded as data sets. For example, this page contains a list of countries and territories together with their border length, their area, and the ratio between the two. The page was deleted from Wikipedia in January 2025, so I use a copy from October 2021 that the Internet Archive keeps.
```

## Prose (replace): The HTML is saved to a file named wiki.html. Let’s see how the first 1

- id: `chapter-5-scrubbing-data.html:prose:1b80e66e`
- hash: `17e527b4`
- status: **accept**
- cause: content
- note: Content pass: explain the id_ in the Internet Archive URL

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-The HTML is saved to a file named wiki.html. Let’s see how the first 10 lines look like:
+The id_ after the date makes the Internet Archive return the page as it was, without its own navigation bar. The HTML is saved to a file named wiki.html. Let’s see how the first 10 lines look like:
```

## 1 old anchor(s) missing

- id: `chapter-5-scrubbing-data.html:anchors-missing`
- hash: `24892e80`
- status: **accept**
- cause: conversion
- note: Figure anchors are #fig-x instead of #fig:x (Quarto cross-references); section anchors are unchanged

```diff
fig:fb-image

(new-only: fig-fb-image, fig-fb-image-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fn1, fn10, fn11, fn12, fn13, fn14, fn15, fn16, fn17, fn18, fn19, fn2, fn20, fn21, fn22, fn23, fn24, fn25, fn26, fn27, fn3, fn4, fn5, fn6, fn7, fn8, fn9, fnref1, fnref10, fnref11, fnref12, fnref13, fnref14, fnref15, fnref16, fnref17, fnref18, fnref19, fnref2, fnref20, fnref21, fnref22, fnref23, fnref24, fnref25, fnref26, fnref27, fnref3, fnref4, fnref5, fnref6, fnref7, fnref8, fnref9, footnotes, title-block-header)
```

## External links differ

- id: `chapter-5-scrubbing-data.html:external-links`
- hash: `a2709f90`
- status: **accept**
- cause: content
- note: Content pass: link to the Internet Archive copy

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-http://en.wikipedia.org/wiki/List_of_countries_and_territories_by_border/area_ratio
+https://web.archive.org/web/20211005234015/https://en.wikipedia.org/wiki/List_of_countries_and_territories_by_border/area_ratio
```

## Footnotes differ (27 vs 27)

- id: `chapter-5-scrubbing-data.html:footnotes`
- hash: `aa4f74bb`
- status: **accept**
- cause: conversion
- note: Citations show the versions and years of the tools in the current image (content pass, tools.bib)

```diff
--- 2e
+++ 2.5e
@@ -1,6 +1,6 @@
-Meyering, grep – Print Lines That Match Patterns.
-Mike D. Brennan and Thomas E. Dickey, awk – Pattern Scanning and Text Processing Language, version 1.3.4, 2019, https://invisible-island.net/mawk.
-Dolan, jq – Command-Line JSON Processor.
-Chiang, pup – Parsing HTML at the Command Line.
-Stallman and MacKenzie, uniq – Report or Omit Repeated Lines.
-Janssens, rush – R One-Liners from the Shell.
+Jim Meyering, grep – Print Lines That Match Patterns, version 3.12, 2025, https://www.gnu.org/software/grep.
+Mike D. Brennan and Thomas E. Dickey, awk – Pattern Scanning and Text Processing Language, version 1.3.4 20260129, 2026, https://invisible-island.net/mawk.
+Stephen Dolan, jq – Command-Line JSON Processor, version 1.8.1, 2025, https://jqlang.org.
+Eric Chiang, pup – Parsing HTML at the Command Line, version 0.4.0, 2016, https://github.com/EricChiang/pup.
+uutils contributors, uniq – Report or Omit Repeated Lines, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+Jeroen Janssens, rush – R One-Liners from the Shell, version 0.2.1.9000, 2026, https://github.com/jeroenjanssens/rush.
@@ -9,7 +9,7 @@
-Raymond, The Art of Unix Programming.
-MacKenzie and Meyering, head – Output the First Part of Files.
-Jay Fenlason et al., sed – Stream Editor for Filtering and Transforming Text, version 4.7, 2018, https://www.gnu.org/software/sed.
-Paul Rubin et al., tail – Output the Last Part of Files, version 8.30, 2019, https://www.gnu.org/software/coreutils.
-Jeroen Janssens, sample – Filter Lines from Standard Input According to Some Probability, with a Given Delay, and for a Certain Duration, version 0.2.4, 2021, https://github.com/jeroenjanssens/sample.
-Joey Hess, ts – Timestamp Input, version 0.65, 2021, https://joeyh.name/code/moreutils.
-Meyering, tr – Translate or Delete Characters.
+Eric S Raymond, The Art of Unix Programming (Addison-Wesley Professional, 2003).
+uutils contributors, head – Output the First Part of Files, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+Jay Fenlason et al., sed – Stream Editor for Filtering and Transforming Text, version 4.9, 2022, https://www.gnu.org/software/sed.
+uutils contributors, tail – Output the Last Part of Files, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+Jeroen Janssens, sample – Filter Lines from Standard Input According to Some Probability, with a Given Delay, and for a Certain Duration, version 0.2.5, 2021, https://github.com/jeroenjanssens/sample.
+Joey Hess, ts – Timestamp Input, version 0.69, 2024, https://joeyh.name/code/moreutils.
+uutils contributors, tr – Translate or Delete Characters, version 0.10.0, 2026, https://github.com/uutils/coreutils.
@@ -19,6 +19,6 @@
-Christopher Groskopf, csvsql – Execute SQL Statements on CSV Files, version 1.0.5, 2020, https://csvkit.rtfd.org.
-Christopher Groskopf, csvcut – Filter and Truncate CSV Files, version 1.0.5, 2020, https://csvkit.rtfd.org.
-Christopher Groskopf, csvgrep – Search CSV Files, version 1.0.5, 2020, https://csvkit.rtfd.org.
-Mike Parker, Richard M. Stallman, and David MacKenzie, tee – Read from Standard Input and Write to Standard Output and Files, version 8.30, 2019, https://www.gnu.org/software/coreutils.
-Ihnat and MacKenzie, paste – Merge Lines of Files.
-Christopher Groskopf, csvjoin – Execute a SQL -Like Join to Merge CSV Files on a Specified Column or Columns, version 1.0.5, 2020, https://csvkit.rtfd.org.
+Christopher Groskopf, csvsql – Execute SQL Statements on CSV Files, version 1.1.0, 2023, https://csvkit.rtfd.org.
+Christopher Groskopf, csvcut – Filter and Truncate CSV Files, version 1.1.0, 2023, https://csvkit.rtfd.org.
+Christopher Groskopf, csvgrep – Search CSV Files, version 1.1.0, 2023, https://csvkit.rtfd.org.
+uutils contributors, tee – Read from Standard Input and Write to Standard Output and Files, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+uutils contributors, paste – Merge Lines of Files, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+Christopher Groskopf, csvjoin – Execute a SQL -Like Join to Merge CSV Files on a Specified Column or Columns, version 1.1.0, 2023, https://csvkit.rtfd.org.
```

## Image changed: images/fb.png

- id: `chapter-5-scrubbing-data.html:image:images/fb.png`
- hash: `76f0047e`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html

```diff
images/fb.png: 14637 -> 16572 bytes
```

