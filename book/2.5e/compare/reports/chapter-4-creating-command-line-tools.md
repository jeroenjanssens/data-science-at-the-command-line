# chapter-4-creating-command-line-tools.html

Image: `datasciencetoolbox/dsatcl2e@sha256:ac2e2f4327e2873ff504d7e72cc8f1fa8abb9701698a123b2539ad3157ce9302`

## Code block 0: `$ cd /data/ch04`

- id: `chapter-4-creating-command-line-tools.html:block:0`
- hash: `bdf5e7f2`
- status: **accept**
- cause: uutils
- note: Timestamps and ls sort order (uutils sorts by byte value)

```diff
--- 2e
+++ 2.5e
@@ -3,10 +3,10 @@
 $ l
 total 32K
--rwxr-xr-x 1 dst dst 400 Dec 14 11:46 fizzbuzz.py*
--rwxr-xr-x 1 dst dst 391 Dec 14 11:46 fizzbuzz.R*
--rwxr-xr-x 1 dst dst 182 Dec 14 11:46 stream.py*
--rwxr-xr-x 1 dst dst 147 Dec 14 11:46 stream.R*
--rwxr-xr-x 1 dst dst 105 Dec 14 11:46 top-words-4.sh*
--rwxr-xr-x 1 dst dst 128 Dec 14 11:46 top-words-5.sh*
--rwxr-xr-x 1 dst dst 647 Dec 14 11:46 top-words.py*
--rwxr-xr-x 1 dst dst 584 Dec 14 11:46 top-words.R*
+-rwxr-xr-x 1 dst dst 391 Nov 26 11:53 fizzbuzz.R*
+-rwxr-xr-x 1 dst dst 400 Nov 26 11:53 fizzbuzz.py*
+-rwxr-xr-x 1 dst dst 147 Nov 26 11:53 stream.R*
+-rwxr-xr-x 1 dst dst 182 Nov 26 11:53 stream.py*
+-rwxr-xr-x 1 dst dst 105 Nov 26 11:53 top-words-4.sh*
+-rwxr-xr-x 1 dst dst 128 Nov 26 11:53 top-words-5.sh*
+-rwxr-xr-x 1 dst dst 584 Nov 26 11:53 top-words.R*
+-rwxr-xr-x 1 dst dst 647 Nov 26 11:53 top-words.py*
```

## Code block 1: `$ curl -sL "https://www.gutenberg.org/files/11/11-0.txt" | trim`

- id: `chapter-4-creating-command-line-tools.html:block:1`
- hash: `6fdf1ff6`
- status: **accept**
- cause: quarto-term
- note: trim measures terminal columns now (dsutils 4f49774), so the line is cut later; quarto-term 0.7.3 leaves the invisible byte-order mark (U+FEFF) at the start of the text out of the terminal, because avt gave it a column (asciinema/avt#27); it shows nothing either way

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ curl -sL "https://www.gutenberg.org/files/11/11-0.txt" | trim
-﻿The Project Gutenberg eBook of Alice’s Adventures in Wonderland, by Lewis …
+The Project Gutenberg eBook of Alice’s Adventures in Wonderland, by Lewis Carro…
 
 This eBook is for the use of anyone anywhere in the United States and
```

## Code block 6: `  GNU nano 5.4                     /tmp/zshpu0emE`

- id: `chapter-4-creating-command-line-tools.html:block:6`
- hash: `c8596489`
- status: **accept**
- cause: image
- note: nano 8.7.1: version, temporary file name, and shortcut labels

```diff
--- 2e
+++ 2.5e
@@ -1,3 +1,3 @@
-  GNU nano 5.4                     /tmp/zshpu0emE
+  GNU nano 8.7.1                    /tmp/zshX8ZtA4
 curl -sL "https://www.gutenberg.org/files/11/11-0.txt" |
 tr '[:upper:]' '[:lower:]' |
@@ -13,4 +13,4 @@
 
                                 [ Read 8 lines ]
-^G Help      ^O Write Out ^W Where Is  ^K Cut       ^T Execute   ^C Location
-^X Exit      ^R Read File ^\ Replace   ^U Paste     ^J Justify   ^_ Go To Line
+^G Help      ^O Write Out ^F Where Is  ^K Cut       ^T Execute   ^C Location
+^X Exit      ^R Read File ^\ Replace   ^U Paste     ^J Justify   ^/ Go To Line
```

## Code block 7: `  GNU nano 5.4                     /tmp/zshpu0emE`

- id: `chapter-4-creating-command-line-tools.html:block:7`
- hash: `d01f63e6`
- status: **accept**
- cause: image
- note: nano 8.7.1: version, temporary file name, and shortcut labels

```diff
--- 2e
+++ 2.5e
@@ -1,3 +1,3 @@
-  GNU nano 5.4                     /tmp/zshpu0emE
+  GNU nano 8.7.1                    /tmp/zshX8ZtA4
 curl -sL "https://www.gutenberg.org/files/11/11-0.txt" |
 tr '[:upper:]' '[:lower:]' |
@@ -12,5 +12,5 @@
 
 
-File Name to Write: top-words-1.sh
-^G Help             M-D DOS Format      M-A Append          M-B Backup File
-^C Cancel           M-M Mac Format      M-P Prepend         ^T Browse
+Write to File: top-words-1.sh
+^G Help         M-D DOS Format  M-A Append      M-B Backup File ^T Browse
+^C Cancel       M-M Mac Format  M-P Prepend     ^Q Discard buffer
```

## Code block 8: `  GNU nano 5.4                     /tmp/zshpu0emE`

- id: `chapter-4-creating-command-line-tools.html:block:8`
- hash: `b680447c`
- status: **accept**
- cause: image
- note: nano 8.7.1: version, temporary file name, and shortcut labels

```diff
--- 2e
+++ 2.5e
@@ -1,3 +1,3 @@
-  GNU nano 5.4                     /tmp/zshpu0emE
+  GNU nano 8.7.1                    /tmp/zshX8ZtA4
 curl -sL "https://www.gutenberg.org/files/11/11-0.txt" |
 tr '[:upper:]' '[:lower:]' |
```

## Code block 9: `  GNU nano 5.4                     top-words-1.sh`

- id: `chapter-4-creating-command-line-tools.html:block:9`
- hash: `47977702`
- status: **accept**
- cause: image
- note: nano 8.7.1: version, temporary file name, and shortcut labels

```diff
--- 2e
+++ 2.5e
@@ -1,3 +1,3 @@
-  GNU nano 5.4                     top-words-1.sh
+  GNU nano 8.7.1                    top-words-1.sh
 curl -sL "https://www.gutenberg.org/files/11/11-0.txt" |
 tr '[:upper:]' '[:lower:]' |
@@ -13,4 +13,4 @@
 
                                [ Wrote 8 lines ]
-^G Help      ^O Write Out ^W Where Is  ^K Cut       ^T Execute   ^C Location
-^X Exit      ^R Read File ^\ Replace   ^U Paste     ^J Justify   ^_ Go To Line
+^G Help      ^O Write Out ^F Where Is  ^K Cut       ^T Execute   ^C Location
+^X Exit      ^R Read File ^\ Replace   ^U Paste     ^J Justify   ^/ Go To Line
```

## Code block 10: `$ pwd`

- id: `chapter-4-creating-command-line-tools.html:block:10`
- hash: `29841d7b`
- status: **accept**
- cause: uutils
- note: Timestamps and ls sort order (uutils sorts by byte value)

```diff
--- 2e
+++ 2.5e
@@ -4,14 +4,14 @@
 $ l
 total 44K
--rwxr-xr-x 1 dst dst  400 Dec 14 11:46 fizzbuzz.py*
--rwxr-xr-x 1 dst dst  391 Dec 14 11:46 fizzbuzz.R*
--rw-r--r-- 1 dst dst 7.5K Dec 14 11:47 stopwords
--rwxr-xr-x 1 dst dst  182 Dec 14 11:46 stream.py*
--rwxr-xr-x 1 dst dst  147 Dec 14 11:46 stream.R*
--rw-r--r-- 1 dst dst  173 Dec 14 11:47 top-words-1.sh
--rwxr-xr-x 1 dst dst  105 Dec 14 11:46 top-words-4.sh*
--rwxr-xr-x 1 dst dst  128 Dec 14 11:46 top-words-5.sh*
--rwxr-xr-x 1 dst dst  647 Dec 14 11:46 top-words.py*
--rwxr-xr-x 1 dst dst  584 Dec 14 11:46 top-words.R*
+-rwxr-xr-x 1 dst dst  391 Nov 26 11:53 fizzbuzz.R*
+-rwxr-xr-x 1 dst dst  400 Nov 26 11:53 fizzbuzz.py*
+-rw-r--r-- 1 dst dst 7.5K Nov 26 11:53 stopwords
+-rwxr-xr-x 1 dst dst  147 Nov 26 11:53 stream.R*
+-rwxr-xr-x 1 dst dst  182 Nov 26 11:53 stream.py*
+-rw-r--r-- 1 dst dst  173 Nov 26 11:53 top-words-1.sh
+-rwxr-xr-x 1 dst dst  105 Nov 26 11:53 top-words-4.sh*
+-rwxr-xr-x 1 dst dst  128 Nov 26 11:53 top-words-5.sh*
+-rwxr-xr-x 1 dst dst  584 Nov 26 11:53 top-words.R*
+-rwxr-xr-x 1 dst dst  647 Nov 26 11:53 top-words.py*
 
 $ bat top-words-1.sh
```

## Code block 13: `$ l top-words-{1,2}.sh`

- id: `chapter-4-creating-command-line-tools.html:block:13`
- hash: `97721351`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -1,3 +1,3 @@
 $ l top-words-{1,2}.sh
--rw-r--r-- 1 dst dst 173 Dec 14 11:47 top-words-1.sh
--rwxr--r-- 1 dst dst 173 Dec 14 11:47 top-words-2.sh*
+-rw-r--r-- 1 dst dst 173 Nov 26 11:53 top-words-1.sh
+-rwxr--r-- 1 dst dst 173 Nov 26 11:53 top-words-2.sh*
```

## Code block 17: `  GNU nano 5.4                     top-words-3.sh`

- id: `chapter-4-creating-command-line-tools.html:block:17`
- hash: `9e2b7eee`
- status: **accept**
- cause: image
- note: nano 8.7.1: version, temporary file name, and shortcut labels

```diff
--- 2e
+++ 2.5e
@@ -1,3 +1,3 @@
-  GNU nano 5.4                     top-words-3.sh
+  GNU nano 8.7.1                    top-words-3.sh
 curl -sL "https://www.gutenberg.org/files/11/11-0.txt" |
 tr '[:upper:]' '[:lower:]' |
@@ -13,4 +13,4 @@
 
                                 [ Read 8 lines ]
-^G Help      ^O Write Out ^W Where Is  ^K Cut       ^T Execute   ^C Location
-^X Exit      ^R Read File ^\ Replace   ^U Paste     ^J Justify   ^_ Go To Line
+^G Help      ^O Write Out ^F Where Is  ^K Cut       ^T Execute   ^C Location
+^X Exit      ^R Read File ^\ Replace   ^U Paste     ^J Justify   ^/ Go To Line
```

## Code block 18: `  GNU nano 5.4                     top-words-3.sh *`

- id: `chapter-4-creating-command-line-tools.html:block:18`
- hash: `beee4ca2`
- status: **accept**
- cause: image
- note: nano 8.7.1: version, temporary file name, and shortcut labels

```diff
--- 2e
+++ 2.5e
@@ -1,3 +1,3 @@
-  GNU nano 5.4                     top-words-3.sh *
+  GNU nano 8.7.1                    top-words-3.sh *
 #!/usr/bin/env bash
 curl -sL "https://www.gutenberg.org/files/11/11-0.txt" |
```

## Code block 19: `  GNU nano 5.4                     top-words-3.sh *`

- id: `chapter-4-creating-command-line-tools.html:block:19`
- hash: `531a7577`
- status: **accept**
- cause: image
- note: nano 8.7.1: version, temporary file name, and shortcut labels

```diff
--- 2e
+++ 2.5e
@@ -1,3 +1,3 @@
-  GNU nano 5.4                     top-words-3.sh *
+  GNU nano 8.7.1                    top-words-3.sh *
 #!/usr/bin/env bash
 curl -sL "https://www.gutenberg.org/files/11/11-0.txt" |
@@ -12,5 +12,5 @@
 
 
-File Name to Write: top-words-3.sh
-^G Help             M-D DOS Format      M-A Append          M-B Backup File
-^C Cancel           M-M Mac Format      M-P Prepend         ^T Browse
+Write to File: top-words-3.sh
+^G Help         M-D DOS Format  M-A Append      M-B Backup File ^T Browse
+^C Cancel       M-M Mac Format  M-P Prepend     ^Q Discard buffer
```

## Code block 22: `$ curl -sL 'https://www.gutenberg.org/files/11/11-0.txt' | ./top-words`

- id: `chapter-4-creating-command-line-tools.html:block:22`
- hash: `e2150541`
- status: **accept**
- cause: uutils
- note: Timestamps and ls sort order (uutils sorts by byte value)

```diff
--- 2e
+++ 2.5e
@@ -24,12 +24,12 @@
 
 $ man bash | ./top-words-4.sh
-    585 command
-    332 set
-    313 word
-    313 option
-    304 file
-    300 variable
-    298 bash
-    258 list
-    257 expansion
-    238 history
+    676 command
+    392 bash
+    362 word
+    355 variable
+    354 set
+    349 option
+    330 file
+    302 expansion
+    280 history
+    274 list
```

## Code block 26: `$ echo $PATH`

- id: `chapter-4-creating-command-line-tools.html:block:26`
- hash: `52ca49d9`
- status: **accept**
- cause: image
- note: PATH of the new image (/opt/venv/bin, /opt/uv/bin; no rush/exec)

```diff
--- 2e
+++ 2.5e
@@ -1,3 +1,3 @@
 $ echo $PATH
-/usr/local/lib/R/site-library/rush/exec:/usr/bin/dsutils:/home/dst/.local/bin:/u
-sr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
+/opt/venv/bin:/opt/uv/bin:/usr/bin/dsutils:/home/dst/.local/bin:/usr/local/sbin:
+/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

## Code block 27: `$ echo $PATH | tr ':' '\n'`

- id: `chapter-4-creating-command-line-tools.html:block:27`
- hash: `3bebf2de`
- status: **accept**
- cause: image
- note: PATH of the new image (/opt/venv/bin, /opt/uv/bin; no rush/exec)

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,5 @@
 $ echo $PATH | tr ':' '\n'
-/usr/local/lib/R/site-library/rush/exec
+/opt/venv/bin
+/opt/uv/bin
 /usr/bin/dsutils
 /home/dst/.local/bin
```

## Code block 28: `$ cp -v top-words{-5.sh,}`

- id: `chapter-4-creating-command-line-tools.html:block:28`
- hash: `44186ec6`
- status: **accept**
- cause: image
- note: curl 8 progress meter layout

```diff
--- 2e
+++ 2.5e
@@ -5,12 +5,12 @@
 
 $ echo $PATH
-/usr/local/lib/R/site-library/rush/exec:/usr/bin/dsutils:/home/dst/.local/bin:/u
-sr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/data/ch04
+/opt/venv/bin:/opt/uv/bin:/usr/bin/dsutils:/home/dst/.local/bin:/usr/local/sbin:
+/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/data/ch04
 
 $ curl "https://www.gutenberg.org/files/11/11-0.txt" |
 > top-words 10
-  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
-                                 Dload  Upload   Total   Spent    Left  Speed
-100  170k  100  170k    0     0   115k      0  0:00:01  0:00:01 --:--:--  116k
+  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
+                                 Dload  Upload  Total   Spent   Left   Speed
+100 170.2k 100 170.2k   0      0 50.85M      0                              0
     403 alice
      98 gutenberg
```

## Code block 31: `$ time < alice.txt top-words 5`

- id: `chapter-4-creating-command-line-tools.html:block:31`
- hash: `3c9105de`
- status: **accept**
- cause: time
- note: Timings

```diff
--- 2e
+++ 2.5e
@@ -5,5 +5,5 @@
      76 queen
      71 time
-top-words 5 < alice.txt  0.38s user 0.04s system 149% cpu 0.278 total
+top-words 5 < alice.txt  0.03s user 0.01s system 153% cpu 0.023 total
 
 $ time < alice.txt top-words.py 5
@@ -13,5 +13,5 @@
      76 queen
      71 time
-top-words.py 5 < alice.txt  1.36s user 0.03s system 95% cpu 1.454 total
+top-words.py 5 < alice.txt  0.19s user 0.01s system 4% cpu 4.426 total
 
 $ time < alice.txt top-words.R 5
@@ -21,3 +21,3 @@
      76 queen
      71 time
-top-words.R 5 < alice.txt  1.48s user 0.14s system 91% cpu 1.774 total
+top-words.R 5 < alice.txt  0.14s user 0.06s system 4% cpu 4.281 total
```

## Prose (replace): We know have a valid command-line tool that we can execute from the co

- id: `chapter-4-creating-command-line-tools.html:prose:259aee0e`
- hash: `33a1022d`
- status: **accept**
- cause: content
- note: Typo: know -> now, PR #114

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-We know have a valid command-line tool that we can execute from the command line. But we can do better than this. We can make our command-line tool more reusable. The first command in our file is curl, which downloads the text from which we wish to obtain the top 10 most-used words. So, the data and operations are combined into one.
+We now have a valid command-line tool that we can execute from the command line. But we can do better than this. We can make our command-line tool more reusable. The first command in our file is curl, which downloads the text from which we wish to obtain the top 10 most-used words. So, the data and operations are combined into one.
```

## Footnotes differ (14 vs 14)

- id: `chapter-4-creating-command-line-tools.html:footnotes`
- hash: `a8152a2c`
- status: **accept**
- cause: conversion
- note: Citations show the versions and years of the tools in the current image (content pass, tools.bib)

```diff
--- 2e
+++ 2.5e
@@ -2,10 +2,10 @@
-Jim Meyering, tr – Translate or Delete Characters, version 8.30, 2018, https://www.gnu.org/software/coreutils.
-Meyering, grep – Print Lines That Match Patterns.
-Haertel and Eggert, sort – Sort Lines of Text Files.
-Richard M. Stallman and David MacKenzie, uniq – Report or Omit Repeated Lines, version 8.30, 2019, https://www.gnu.org/software/coreutils.
-Brian Fox and Chet Ramey, bash – GNU Bourne-Again SHell, version 5.0.17, 2019, https://www.gnu.org/software/bash.
-David MacKenzie and Jim Meyering, chmod – Change File Mode Bits, version 8.30, 2018, https://www.gnu.org/software/coreutils.
-Benno Schulenberg et al., nano – Nano’s ANOther editor, inspired by Pico, version 5.4, 2020, https://nano-editor.org.
-The Python Software Foundation, python – an Interpreted, Interactive, Object-Oriented Programming Language, version 3.8.5, 2021, https://www.python.org.
-Richard Mlynarik, David MacKenzie, and Assaf Gordon, env – Run a Program in a Modified Environment, version 8.32, 2020, https://www.gnu.org/software/coreutils.
-The R Foundation for Statistical Computing, R – a Language and Environment for Statistical Computing, version 4.0.4, 2021, https://www.r-project.org.
+uutils contributors, tr – Translate or Delete Characters, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+Jim Meyering, grep – Print Lines That Match Patterns, version 3.12, 2025, https://www.gnu.org/software/grep.
+uutils contributors, sort – Sort Lines of Text Files, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+uutils contributors, uniq – Report or Omit Repeated Lines, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+Brian Fox and Chet Ramey, bash – GNU Bourne-Again SHell, version 5.3.9, 2025, https://www.gnu.org/software/bash.
+uutils contributors, chmod – Change File Mode Bits, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+Benno Schulenberg et al., nano – Nano’s ANOther editor, inspired by Pico, version 8.7.1, 2026, https://nano-editor.org.
+The Python Software Foundation, python – an Interpreted, Interactive, Object-Oriented Programming Language, version 3.13.18, 2026, https://www.python.org.
+uutils contributors, env – Run a Program in a Modified Environment, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+The R Foundation for Statistical Computing, R – a Language and Environment for Statistical Computing, version 4.5.2, 2025, https://www.r-project.org.
```

