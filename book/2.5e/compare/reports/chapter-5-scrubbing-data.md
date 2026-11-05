# chapter-5-scrubbing-data.html

Image: `datasciencetoolbox/dsatcl2e@sha256:e14d28e462d5441405520c216fae7cbdaac47694336e393d72d1811e440455d6`

## Code block 0: `$ cd /data/ch05`

- id: `chapter-5-scrubbing-data.html:block:0`
- hash: `68407095`
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
+-rw-r--r-- 1 dst dst 164K Nov  5 22:33 alice.txt
+-rw-r--r-- 1 dst dst 4.5K Nov  5 22:33 iris.csv
+-rw-r--r-- 1 dst dst  179 Nov  5 22:33 irismeta.csv
+-rw-r--r-- 1 dst dst  160 Nov  5 22:33 names-comma.csv
+-rw-r--r-- 1 dst dst  129 Nov  5 22:33 names.csv
+-rw-r--r-- 1 dst dst 7.8K Nov  5 22:33 tips.csv
+-rw-r--r-- 1 dst dst 5.1K Nov  5 22:33 users.json
```

## Code block 2: `$ grep -E "fizz|buzz" fb.seq | ➊`

- id: `chapter-5-scrubbing-data.html:block:2`
- hash: `f5723c41`
- status: **fix-quarto-term**
- cause: quarto-term
- note: quarto-term decodes each PTY read separately, so a multibyte character split between reads becomes two replacement characters and the line wraps

```diff
--- 2e
+++ 2.5e
@@ -9,3 +9,4 @@
    2   │ ·····14·buzz␊
    3   │ ······6·fizzbuzz␊
-───────┴────────────────────────────────────────────────────────────────────────
+───────┴───────────────────────────────────────────────────────────���──────────
+──
```

## Code block 17: `$ seq -f "Line %g" 1000 | sample -r 1%`

- id: `chapter-5-scrubbing-data.html:block:17`
- hash: `1ef616a3`
- status: **accept**
- cause: random
- note: sample draws other lines

```diff
--- 2e
+++ 2.5e
@@ -1,8 +1,9 @@
 $ seq -f "Line %g" 1000 | sample -r 1%
-Line 45
-Line 223
-Line 355
-Line 369
-Line 438
-Line 807
-Line 813
+Line 24
+Line 288
+Line 403
+Line 410
+Line 499
+Line 508
+Line 643
+Line 690
```

## Code block 18: `$ seq -f "Line %g" 1000 | sample -r 1% -d 1000 -s 5 | ts ➊`

- id: `chapter-5-scrubbing-data.html:block:18`
- hash: `3f5eb8ff`
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
+Nov 05 22:33:21 Line 96
+Nov 05 22:33:22 Line 224
+Nov 05 22:33:23 Line 333
+Nov 05 22:33:24 Line 400
+Nov 05 22:33:25 Line 545
+Nov 05 22:33:26 Line 547
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

## Footnotes differ (27 vs 27)

- id: `chapter-5-scrubbing-data.html:footnotes`
- hash: `28b19abc`
- status: **accept**
- cause: conversion
- note: bookdown rendered the book as one document, so citations already cited in an earlier chapter got the short Chicago form; Quarto renders chapters separately, so the first citation in each chapter is full

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Meyering, grep – Print Lines That Match Patterns.
+Jim Meyering, grep – Print Lines That Match Patterns, version 3.4, 2019, https://www.gnu.org/software/grep.
@@ -3,4 +3,4 @@
-Dolan, jq – Command-Line JSON Processor.
-Chiang, pup – Parsing HTML at the Command Line.
-Stallman and MacKenzie, uniq – Report or Omit Repeated Lines.
-Janssens, rush – R One-Liners from the Shell.
+Stephen Dolan, jq – Command-Line JSON Processor, version 1.6, 2021, https://stedolan.github.com/jq.
+Eric Chiang, pup – Parsing HTML at the Command Line, version 0.4.0, 2016, https://github.com/EricChiang/pup.
+Richard M. Stallman and David MacKenzie, uniq – Report or Omit Repeated Lines, version 8.30, 2019, https://www.gnu.org/software/coreutils.
+Jeroen Janssens, rush – R One-Liners from the Shell, version 0.1, 2021, https://github.com/jeroenjanssens/rush.
@@ -9,2 +9,2 @@
-Raymond, The Art of Unix Programming.
-MacKenzie and Meyering, head – Output the First Part of Files.
+Eric S Raymond, The Art of Unix Programming (Addison-Wesley Professional, 2003).
+David MacKenzie and Jim Meyering, head – Output the First Part of Files, version 8.30, 2019, https://www.gnu.org/software/coreutils.
@@ -15 +15 @@
-Meyering, tr – Translate or Delete Characters.
+Jim Meyering, tr – Translate or Delete Characters, version 8.30, 2018, https://www.gnu.org/software/coreutils.
@@ -23 +23 @@
-Ihnat and MacKenzie, paste – Merge Lines of Files.
+David M. Ihnat and David MacKenzie, paste – Merge Lines of Files, version 8.30, 2019, https://www.gnu.org/software/coreutils.
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

