# chapter-10-polyglot-data-science.html

Image: `datasciencetoolbox/dsatcl2e@sha256:dedbd1bfc3ea3db11abe3db1a3c972d85b732f796409580c0b012149d74a782e`

## Code block 0: `$ cd /data/ch10`

- id: `chapter-10-polyglot-data-science.html:block:0`
- hash: `0e7df2d9`
- status: **accept**
- cause: uutils
- note: Timestamps, ls sort order, no __pycache__ in data

```diff
--- 2e
+++ 2.5e
@@ -2,8 +2,7 @@
 
 $ l
-total 180K
-drwxr-xr-x 2 dst dst 4.0K Dec 14 12:03 __pycache__/
--rw-r--r-- 1 dst dst 164K Dec 14 12:03 alice.txt
--rwxr--r-- 1 dst dst  408 Dec 14 12:03 count.py*
--rw-r--r-- 1 dst dst  460 Dec 14 12:03 count.R
--rw-r--r-- 1 dst dst 1.7K Dec 14 12:03 Untitled1337.ipynb
+total 176K
+-rw-r--r-- 1 dst dst 1.7K Nov 10 11:51 Untitled1337.ipynb
+-rw-r--r-- 1 dst dst 164K Nov 10 11:51 alice.txt
+-rw-r--r-- 1 dst dst  460 Nov 10 11:51 count.R
+-rwxr-xr-x 1 dst dst  408 Nov 10 11:51 count.py*
```

## Code block 1: `$ jupyter console`

- id: `chapter-10-polyglot-data-science.html:block:1`
- hash: `1984ed0c`
- status: **accept**
- cause: quarto-term
- note: quarto-term 0.7.3 leaves the invisible byte-order mark (U+FEFF) at the start of the text out of the terminal, because avt gave it a column (asciinema/avt#27); it shows nothing either way

```diff
--- 2e
+++ 2.5e
@@ -26,5 +26,5 @@
 
 In [3]: ! head alice.txt
-﻿Project Gutenberg's Alice's Adventures in Wonderland, by Lewis Carroll
+Project Gutenberg's Alice's Adventures in Wonderland, by Lewis Carroll
 
 This eBook is for the use of anyone anywhere at no cost and with
```

## Code block 4: `$ R --quiet`

- id: `chapter-10-polyglot-data-science.html:block:4`
- hash: `02a4462e`
- status: **accept**
- cause: intended
- note: 2e cut off the last output of the R session; it is shown now

```diff
--- 2e
+++ 2.5e
@@ -16,2 +16,3 @@
 [1] "Alice's" "Alice's" "ALICE'S" "ALICE'S" "Alice"   "Alice"
 > length(alice) ➍
+[1] 403
```

## Code block 5: `> out_con <- fifo("out", "w+") ➊`

- id: `chapter-10-polyglot-data-science.html:block:5`
- hash: `7705c730`
- status: **accept**
- cause: intended
- note: 2e cut off the last output of the R session; it is shown now

```diff
--- 2e
+++ 2.5e
@@ -4,2 +4,3 @@
 > readLines(out_con) ➍
 [1] "bar"
+> close(out_con); close(in_con); unlink("out") ➎
```

## Code block 7: `$ spark-shell --master local[6]`

- id: `chapter-10-polyglot-data-science.html:block:7`
- hash: `288c2777`
- status: **accept**
- cause: quarto-term
- note: Spark clears its progress bar with spaces; quarto-term keeps them (styled), so the markers come after them

```diff
--- 2e
+++ 2.5e
@@ -14,5 +14,5 @@
 Type :help for more information.
 
-scala> val lines = sc.textFile("alice.txt") ➊
+scala> val lines = sc.textFile("alice.txt")                                      ➊
 lines: org.apache.spark.rdd.RDD[String] = alice.txt MapPartitionsRDD[1] at textF
 ile at <console>:24
@@ -22,5 +22,5 @@
 rroll
 
-scala> val words = lines.flatMap(line => line.split(" ")) ➋
+scala> val words = lines.flatMap(line => line.split(" "))                        ➋
 words: org.apache.spark.rdd.RDD[String] = MapPartitionsRDD[2] at flatMap at <con
 sole>:25
@@ -29,5 +29,5 @@
 res1: Array[String] = Array(Project, Gutenberg's, Alice's, Adventures, in)
 
-scala> val alice = words.pipe("grep -i alice") ➌
+scala> val alice = words.pipe("grep -i alice")                                   ➌
 alice: org.apache.spark.rdd.RDD[String] = PipedRDD[3] at pipe at <console>:25
 
@@ -35,5 +35,5 @@
 res2: Array[String] = Array(Alice's, Alice's, ALICE'S, ALICE'S, Alice)
 
-scala> val counts = alice.pipe("wc -l") ➍
+scala> val counts = alice.pipe("wc -l")                                          ➍
 counts: org.apache.spark.rdd.RDD[String] = PipedRDD[4] at pipe at <console>:25
 
@@ -41,5 +41,5 @@
 res3: Array[String] = Array(64, 72, 94, 93, 67, 13) ➎
 
-scala> counts.map(x => x.toInt).reduce(_ + _) ➏
+scala> counts.map(x => x.toInt).reduce(_ + _)                                    ➏
 res4: Int = 403
 
```

## 3 old anchor(s) missing

- id: `chapter-10-polyglot-data-science.html:anchors-missing`
- hash: `6b46fd10`
- status: **accept**
- cause: conversion
- note: Figure anchors are #fig-x instead of #fig:x (Quarto cross-references); section anchors are unchanged

```diff
fig:jupyterlab
fig:rstudio-console
fig:rstudio-terminal

(new-only: fig-jupyterlab, fig-jupyterlab-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-rstudio-console, fig-rstudio-console-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-rstudio-terminal, fig-rstudio-terminal-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, title-block-header)
```

## External links differ

- id: `chapter-10-polyglot-data-science.html:external-links`
- hash: `0e7b2419`
- status: **accept**
- cause: conversion
- note: bookdown linked R function names in inline code to rdrr.io; Quarto does not (no R code is run)

```diff
--- 2e
+++ 2.5e
@@ -1,5 +0,0 @@
-https://rdrr.io/r/base/system2.html
-https://rdrr.io/r/base/system2.html
-https://rdrr.io/r/base/connections.html
-https://rdrr.io/r/base/connections.html
-https://rdrr.io/r/base/connections.html
@@ -9,2 +3,0 @@
-https://rdrr.io/r/base/connections.html
-https://rdrr.io/r/base/connections.html
```

