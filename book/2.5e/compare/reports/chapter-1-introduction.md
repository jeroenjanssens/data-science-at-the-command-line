# chapter-1-introduction.html

Image: `datasciencetoolbox/dsatcl2e@sha256:9cd9b96f9e1b3a286a103fef60b0c6129cae316735486f496571ddd1293ad4e1`

## Code block 0: `$ whoami`

- id: `chapter-1-introduction.html:block:0`
- hash: `8b9dccf2`
- status: **accept**
- cause: time
- note: date prints the render date; container runs in UTC (decision 8). keep-last-prompt: 2e had an extra empty line before the final prompt

```diff
--- 2e
+++ 2.5e
@@ -3,5 +3,5 @@
 
 $ date
-Tue Dec 14 11:43:30 AM CET 2021
+Mon Nov  9 06:41:56 PM UTC 2026
 
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

## Footnotes differ (9 vs 9)

- id: `chapter-1-introduction.html:footnotes`
- hash: `bf986545`
- status: **accept**
- cause: content
- note: Citations show the versions and years of the tools in the current image (content pass, tools.bib)

```diff
--- 2e
+++ 2.5e
@@ -4,2 +4,2 @@
-Christopher Groskopf, csvstat – Print Descriptive Statistics for Each Column in a CSV File, version 1.0.5, 2020, https://csvkit.rtfd.org.
-Jeroen Janssens, rush – R One-Liners from the Shell, version 0.1, 2021, https://github.com/jeroenjanssens/rush.
+Christopher Groskopf, csvstat – Print Descriptive Statistics for Each Column in a CSV File, version 1.1.0, 2023, https://csvkit.rtfd.org.
+Jeroen Janssens, rush – R One-Liners from the Shell, version 0.2.1.9000, 2026, https://github.com/jeroenjanssens/rush.
@@ -7,2 +7,2 @@
-Ole Tange, parallel – Build and Execute Shell Command Lines from Standard Input in Parallel, version 20161222, 2016, https://www.gnu.org/software/parallel.
-Linus Torvalds and Junio C. Hamano, git – the Stupid Content Tracker, version 2.25.1, 2021, https://git-scm.com.
+Ole Tange, parallel – Build and Execute Shell Command Lines from Standard Input in Parallel, version 20240222, 2024, https://www.gnu.org/software/parallel.
+Linus Torvalds and Junio C. Hamano, git – the Stupid Content Tracker, version 2.53.0, 2026, https://git-scm.com.
```

