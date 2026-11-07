# chapter-5-scrubbing-data.html

Image: `datasciencetoolbox/dsatcl2e@sha256:470005890402401f1d3c84f8ebb5afceaf53e7c57af54f8fb06709a2727f0560`

## Code block 0: `$ cd /data/ch05`

- id: `chapter-5-scrubbing-data.html:block:0`
- hash: `74031b08`
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
+-rw-r--r-- 1 dst dst 164K Nov  7 09:27 alice.txt
+-rw-r--r-- 1 dst dst 4.5K Nov  7 09:27 iris.csv
+-rw-r--r-- 1 dst dst  179 Nov  7 09:27 irismeta.csv
+-rw-r--r-- 1 dst dst  160 Nov  7 09:27 names-comma.csv
+-rw-r--r-- 1 dst dst  129 Nov  7 09:27 names.csv
+-rw-r--r-- 1 dst dst 7.8K Nov  7 09:27 tips.csv
+-rw-r--r-- 1 dst dst 5.1K Nov  7 09:27 users.json
```

## Code block 17: `$ seq -f "Line %g" 1000 | sample -r 1%`

- id: `chapter-5-scrubbing-data.html:block:17`
- hash: `98fc5078`
- status: **accept**
- cause: random
- note: sample draws other lines

```diff
--- 2e
+++ 2.5e
@@ -1,8 +1,14 @@
 $ seq -f "Line %g" 1000 | sample -r 1%
-Line 45
-Line 223
-Line 355
-Line 369
-Line 438
-Line 807
-Line 813
+Line 44
+Line 87
+Line 203
+Line 217
+Line 233
+Line 380
+Line 388
+Line 531
+Line 568
+Line 574
+Line 687
+Line 816
+Line 994
```

## Code block 18: `$ seq -f "Line %g" 1000 | sample -r 1% -d 1000 -s 5 | ts ➊`

- id: `chapter-5-scrubbing-data.html:block:18`
- hash: `ff255bd8`
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
+Nov 07 09:27:50 Line 18
+Nov 07 09:27:51 Line 101
+Nov 07 09:27:52 Line 236
+Nov 07 09:27:53 Line 275
+Nov 07 09:27:54 Line 617
+Nov 07 09:27:55 Line 635
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

