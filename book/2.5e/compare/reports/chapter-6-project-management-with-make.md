# chapter-6-project-management-with-make.html

Image: `datasciencetoolbox/dsatcl2e@sha256:9cd9b96f9e1b3a286a103fef60b0c6129cae316735486f496571ddd1293ad4e1`

## Code block 0: `$ cd /data/ch06`

- id: `chapter-6-project-management-with-make.html:block:0`
- hash: `32dac0a0`
- status: **accept**
- cause: uutils
- note: Timestamps and ls sort order (uutils sorts by byte value)

```diff
--- 2e
+++ 2.5e
@@ -3,9 +3,9 @@
 $ l
 total 28K
--rw-r--r-- 1 dst dst  37 Dec 14 11:49 Makefile.test
--rw-r--r-- 1 dst dst  16 Dec 14 11:49 numbers.make
--rw-r--r-- 1 dst dst  26 Dec 14 11:49 numbers-write.make
--rw-r--r-- 1 dst dst  21 Dec 14 11:49 numbers-write-var.make
--rw-r--r-- 1 dst dst 432 Dec 14 11:49 starwars.make
--rw-r--r-- 1 dst dst 263 Dec 14 11:49 tasks.make
--rw-r--r-- 1 dst dst  27 Dec 14 11:49 template.make
+-rw-r--r-- 1 dst dst  37 Nov  9 17:54 Makefile.test
+-rw-r--r-- 1 dst dst  21 Nov  9 17:54 numbers-write-var.make
+-rw-r--r-- 1 dst dst  26 Nov  9 17:54 numbers-write.make
+-rw-r--r-- 1 dst dst  16 Nov  9 17:54 numbers.make
+-rw-r--r-- 1 dst dst 432 Nov  9 17:54 starwars.make
+-rw-r--r-- 1 dst dst 263 Nov  9 17:54 tasks.make
+-rw-r--r-- 1 dst dst  27 Nov  9 17:54 template.make
```

## 2 old anchor(s) missing

- id: `chapter-6-project-management-with-make.html:anchors-missing`
- hash: `ccc01452`
- status: **accept**
- cause: conversion
- note: Figure anchors are #fig-x instead of #fig:x (Quarto cross-references); section anchors are unchanged

```diff
fig:dependencies
fig:starwars-image

(new-only: fig-dependencies, fig-dependencies-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-starwars-image, fig-starwars-image-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fn1, fn2, fn3, fnref1, fnref2, fnref3, footnotes, title-block-header)
```

## Footnotes differ (3 vs 3)

- id: `chapter-6-project-management-with-make.html:footnotes`
- hash: `ae259b41`
- status: **accept**
- cause: conversion
- note: Citations show the versions and years of the tools in the current image (content pass, tools.bib)

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Stuart I. Feldman, make – A Program for Maintaining Computer Programs, version 4.3, 2020, https://www.gnu.org/software/make.
+Stuart I. Feldman, make – A Program for Maintaining Computer Programs, version 4.4.1, 2023, https://www.gnu.org/software/make.
@@ -3 +3 @@
-Torvalds and Hamano, git – the Stupid Content Tracker.
+Linus Torvalds and Junio C. Hamano, git – the Stupid Content Tracker, version 2.53.0, 2026, https://git-scm.com.
```

## Image changed: images/heights.png

- id: `chapter-6-project-management-with-make.html:image:images/heights.png`
- hash: `8ad89dcd`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html

```diff
images/heights.png: 70129 -> 136185 bytes
```

