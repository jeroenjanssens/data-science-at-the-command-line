# chapter-1-introduction.html

Image: `datasciencetoolbox/dsatcl2e@sha256:e14d28e462d5441405520c216fae7cbdaac47694336e393d72d1811e440455d6`

## Code block 0: `$ whoami`

- id: `chapter-1-introduction.html:block:0`
- hash: `7f6bb8b5`
- status: **accept**
- cause: time
- note: date prints the render date; container runs in UTC (decision 8). keep-last-prompt: 2e had an extra empty line before the final prompt

```diff
--- 2e
+++ 2.5e
@@ -3,5 +3,5 @@
 
 $ date
-Tue Dec 14 11:43:30 AM CET 2021
+Thu Nov  5 05:49:15 PM UTC 2026
 
 $ echo 'The command line is awesome!' | cowsay -f tux
@@ -19,4 +19,3 @@
     \___)=(___/
 
-
 $
```

## 3 old anchor(s) missing

- id: `chapter-1-introduction.html:anchors-missing`
- hash: `487c3d22`
- status: **accept**
- cause: conversion
- note: Figure anchors are #fig-x instead of #fig:x (Quarto cross-references); section anchors are unchanged

```diff
fig:diagram-osemn
fig:mac-terminal
fig:ubuntu-terminal

(new-only: fig-diagram-osemn, fig-diagram-osemn-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-mac-terminal, fig-mac-terminal-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-ubuntu-terminal, fig-ubuntu-terminal-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fn1, fn2, fn3, fn4, fn5, fn6, fn7, fn8, fn9, fnref1, fnref2, fnref3, fnref4, fnref5, fnref6, fnref7, fnref8, fnref9, footnotes, title-block-header)
```

## 8 broken internal link(s)

- id: `chapter-1-introduction.html:broken-links`
- hash: `cf5db932`
- status: **accept**
- cause: intended
- note: Links to chapters 3-11 that haven't been converted yet (later rounds)

```diff
chapter-10-polyglot-data-science.qmd (page missing)
chapter-3-obtaining-data.qmd (page missing)
chapter-4-creating-command-line-tools.qmd (page missing)
chapter-5-scrubbing-data.qmd (page missing)
chapter-6-project-management-with-make.qmd (page missing)
chapter-7-exploring-data.qmd (page missing)
chapter-8-parallel-pipelines.qmd (page missing)
chapter-9-modeling-data.qmd (page missing)
```

