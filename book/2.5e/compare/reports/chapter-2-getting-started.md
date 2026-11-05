# chapter-2-getting-started.html

Image: `datasciencetoolbox/dsatcl2e@sha256:e14d28e462d5441405520c216fae7cbdaac47694336e393d72d1811e440455d6`

## Code block 3: `$ docker run --rm -it -v "$(p`

- id: `chapter-2-getting-started.html:block:3`
- hash: `412b4e61`
- status: **accept**
- cause: conversion
- note: 2e showed a truncated command ("$(p"); the full command is shown now

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-$ docker run --rm -it -v "$(p
+$ docker run --rm -it -v "$(pwd)":/data datasciencetoolbox/dsatcl2e
```

## Code block 14: `$ cd /data`

- id: `chapter-2-getting-started.html:block:14`
- hash: `7f3bd044`
- status: **accept**
- cause: image
- note: Timestamps (time); /data has no csvconf/ directory and ch04/ has no subdirectory anymore (data); ls sort order (uutils)

```diff
--- 2e
+++ 2.5e
@@ -2,15 +2,14 @@
 
 $ l
-total 40K
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 ch02/
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 ch03/
-drwxr-xr-x 3 dst dst 4.0K Dec 14 11:43 ch04/
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 ch05/
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 ch06/
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 ch07/
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 ch08/
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 ch09/
-drwxr-xr-x 4 dst dst 4.0K Dec 14 11:43 ch10/
-drwxr-xr-x 3 dst dst 4.0K Dec 14 11:43 csvconf/
+total 36K
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch02/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch03/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch04/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch05/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch06/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch07/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch08/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch09/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch10/
 
 $ cd ch02
```

## Code block 18: `$ curl "https://www.gutenberg.org/files/11/11-0.txt" | grep " CHAPTER"`

- id: `chapter-2-getting-started.html:block:18`
- hash: `ba045aac`
- status: **accept**
- cause: network
- note: Served from the cache (2021 version of the text, same size). curl 8 progress meter layout differs; speed is local

```diff
--- 2e
+++ 2.5e
@@ -1,7 +1,7 @@
 $ curl "https://www.gutenberg.org/files/11/11-0.txt" | grep " CHAPTER" > chapter
 s.txt
-  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
-                                 Dload  Upload   Total   Spent    Left  Speed
-100  170k  100  170k    0     0   202k      0 --:--:-- --:--:-- --:--:--  203k
+  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
+                                 Dload  Upload  Total   Spent   Left   Speed
+100 170.2k 100 170.2k   0      0 147.7M      0                              0
 
 $ cat chapters.txt
```

## Code block 23: `$ cat movies.txt 404.txt`

- id: `chapter-2-getting-started.html:block:23`
- hash: `abe457ce`
- status: **accept**
- cause: uutils
- note: Error messages are prefixed with 'cat:' instead of '/usr/bin/cat:'

```diff
--- 2e
+++ 2.5e
@@ -5,3 +5,3 @@
 Indiana Jones
 Back to the Future
-/usr/bin/cat: 404.txt: No such file or directory
+cat: 404.txt: No such file or directory
```

## Code block 26: `$ dseq 5 > dates.txt`

- id: `chapter-2-getting-started.html:block:26`
- hash: `e47e6d67`
- status: **accept**
- cause: time
- note: dseq prints dates relative to the render date

```diff
--- 2e
+++ 2.5e
@@ -7,9 +7,9 @@
        │ File: dates-nl.txt
 ───────┼────────────────────────────────────────────────────────────────────────
-   1   │      1  2021-12-15
-   2   │      2  2021-12-16
-   3   │      3  2021-12-17
-   4   │      4  2021-12-18
-   5   │      5  2021-12-19
+   1   │      1  2026-11-06
+   2   │      2  2026-11-07
+   3   │      3  2026-11-08
+   4   │      4  2026-11-09
+   5   │      5  2026-11-10
 ───────┴────────────────────────────────────────────────────────────────────────
 
@@ -22,8 +22,8 @@
        │ File: dates.txt
 ───────┼────────────────────────────────────────────────────────────────────────
-   1   │      1  2021-12-15
-   2   │      2  2021-12-16
-   3   │      3  2021-12-17
-   4   │      4  2021-12-18
-   5   │      5  2021-12-19
+   1   │      1  2026-11-06
+   2   │      2  2026-11-07
+   3   │      3  2026-11-08
+   4   │      4  2026-11-09
+   5   │      5  2026-11-10
 ───────┴────────────────────────────────────────────────────────────────────────
```

## Code block 27: `$ ls /data/ch10`

- id: `chapter-2-getting-started.html:block:27`
- hash: `c5b3c9d3`
- status: **accept**
- cause: uutils
- note: ls sorts by byte value (uppercase first); no __pycache__/ in data; timestamps; count.py permissions

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ ls /data/ch10
-alice.txt  count.py  count.R  __pycache__  Untitled1337.ipynb
+Untitled1337.ipynb  alice.txt  count.R  count.py
 
 $ alias l
@@ -6,8 +6,7 @@
 
 $ l /data/ch10
-total 180K
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 __pycache__/
--rw-r--r-- 1 dst dst 164K Dec 14 11:43 alice.txt
--rwxr--r-- 1 dst dst  408 Dec 14 11:43 count.py*
--rw-r--r-- 1 dst dst  460 Dec 14 11:43 count.R
--rw-r--r-- 1 dst dst 1.7K Dec 14 11:43 Untitled1337.ipynb
+total 176K
+-rw-r--r-- 1 dst dst 1.7K Nov  5 22:32 Untitled1337.ipynb
+-rw-r--r-- 1 dst dst 164K Nov  5 22:32 alice.txt
+-rw-r--r-- 1 dst dst  460 Nov  5 22:32 count.R
+-rwxr-xr-x 1 dst dst  408 Nov  5 22:32 count.py*
```

## Code block 33: `$ cd /data`

- id: `chapter-2-getting-started.html:block:33`
- hash: `0a39c6ce`
- status: **accept**
- cause: image
- note: Same as block 14: timestamps, no csvconf/, ls sort order

```diff
--- 2e
+++ 2.5e
@@ -4,14 +4,13 @@
 
 $ l
-total 44K
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 ch02/
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 ch03/
-drwxr-xr-x 3 dst dst 4.0K Dec 14 11:43 ch04/
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 ch05/
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 ch06/
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 ch07/
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 ch08/
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:43 ch09/
-drwxr-xr-x 4 dst dst 4.0K Dec 14 11:43 ch10/
-drwxr-xr-x 3 dst dst 4.0K Dec 14 11:43 csvconf/
-drwxr-xr-x 2 dst dst 4.0K Dec 14 11:44 logs/
+total 40K
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch02/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch03/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch04/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch05/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch06/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch07/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch08/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch09/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 ch10/
+drwxr-xr-x 2 dst dst 4.0K Nov  5 22:32 logs/
```

## Code block 34: `$ mkdir -v backup`

- id: `chapter-2-getting-started.html:block:34`
- hash: `5a8be738`
- status: **accept**
- cause: uutils
- note: 'mkdir:'/'cp:' instead of '/usr/bin/mkdir:'/'/usr/bin/cp:'; no csvconf/ directory

```diff
--- 2e
+++ 2.5e
@@ -1,16 +1,15 @@
 $ mkdir -v backup
-/usr/bin/mkdir: created directory 'backup'
+mkdir: created directory 'backup'
 
 $ cp -v * backup
-/usr/bin/cp: -r not specified; omitting directory 'backup'
-/usr/bin/cp: -r not specified; omitting directory 'ch02'
-/usr/bin/cp: -r not specified; omitting directory 'ch03'
-/usr/bin/cp: -r not specified; omitting directory 'ch04'
-/usr/bin/cp: -r not specified; omitting directory 'ch05'
-/usr/bin/cp: -r not specified; omitting directory 'ch06'
-/usr/bin/cp: -r not specified; omitting directory 'ch07'
-/usr/bin/cp: -r not specified; omitting directory 'ch08'
-/usr/bin/cp: -r not specified; omitting directory 'ch09'
-/usr/bin/cp: -r not specified; omitting directory 'ch10'
-/usr/bin/cp: -r not specified; omitting directory 'csvconf'
-/usr/bin/cp: -r not specified; omitting directory 'logs'
+cp: -r not specified; omitting directory 'backup'
+cp: -r not specified; omitting directory 'ch02'
+cp: -r not specified; omitting directory 'ch03'
+cp: -r not specified; omitting directory 'ch04'
+cp: -r not specified; omitting directory 'ch05'
+cp: -r not specified; omitting directory 'ch06'
+cp: -r not specified; omitting directory 'ch07'
+cp: -r not specified; omitting directory 'ch08'
+cp: -r not specified; omitting directory 'ch09'
+cp: -r not specified; omitting directory 'ch10'
+cp: -r not specified; omitting directory 'logs'
```

## Code block 35: `$ rm -i *`

- id: `chapter-2-getting-started.html:block:35`
- hash: `20766df6`
- status: **accept**
- cause: image
- note: 11 instead of 12 files in /data because csvconf/ is gone

```diff
--- 2e
+++ 2.5e
@@ -1,2 +1,2 @@
 $ rm -i *
-zsh: sure you want to delete all 12 files in /data [yn]? n
+zsh: sure you want to delete all 11 files in /data [yn]? n
```

## Code block 37: `$ which csvlook`

- id: `chapter-2-getting-started.html:block:37`
- hash: `745617c9`
- status: **accept**
- cause: intended
- note: Rendering harness: csvlook is now a typed function calling `command csvlook`, and only changes dashes on its separator line

```diff
--- 2e
+++ 2.5e
@@ -1,6 +1,6 @@
 $ which csvlook
 csvlook () {
-        /usr/bin/csvlook "$@" | trim | sed 's/- | -/──┼──/g;s/| -/├──/g;s/- |/──
-┤/;s/|/│/g;2s/-/─/g'
+        command csvlook "$@" | trim | sed '2s/- | -/──┼──/g;2s/| -/├──/g;2s/- |/
+──┤/;s/|/│/g;2s/-/─/g'
 }
 
```

## Code block 40: `$ man tar | trim 20`

- id: `chapter-2-getting-started.html:block:40`
- hash: `ea75842f`
- status: **accept**
- cause: image
- note: Newer GNU tar man page

```diff
--- 2e
+++ 2.5e
@@ -10,5 +10,5 @@
 
    UNIX-style usage
-       tar -A [OPTIONS] ARCHIVE ARCHIVE
+       tar -A [OPTIONS] -f ARCHIVE ARCHIVE...
 
        tar -c [-f ARCHIVE] [OPTIONS] [FILE...]
@@ -16,7 +16,7 @@
        tar -d [-f ARCHIVE] [OPTIONS] [FILE...]
 
+       tar -r [-f ARCHIVE] [OPTIONS] [FILE...]
+
        tar -t [-f ARCHIVE] [OPTIONS] [MEMBER...]
 
-       tar -r [-f ARCHIVE] [OPTIONS] [FILE...]
-
-… with 1147 more lines
+… with 1144 more lines
```

## Code block 42: `$ man zshbuiltins | trim`

- id: `chapter-2-getting-started.html:block:42`
- hash: `0c52123f`
- status: **accept**
- cause: image
- note: Newer zsh/groff justify the man page differently

```diff
--- 2e
+++ 2.5e
@@ -7,6 +7,6 @@
 SHELL BUILTIN COMMANDS
        Some shell builtin commands take options as described in individual en‐
-       tries; these are often referred to in the  list  below  as  `flags'  to
-       avoid  confusion  with  shell options, which may also have an effect on
-       the behaviour of builtin commands.  In this introductory section,  `op‐
-… with 2735 more lines
+       tries;  these  are  often  referred  to in the list below as `flags' to
+       avoid confusion with shell options, which may also have  an  effect  on
+       the  behaviour of builtin commands.  In this introductory section, `op‐
+… with 2807 more lines
```

## Code block 43: `$ jq --help | trim`

- id: `chapter-2-getting-started.html:block:43`
- hash: `e5b9ceeb`
- status: **accept**
- cause: image
- note: jq 1.8.1 instead of 1.6

```diff
--- 2e
+++ 2.5e
@@ -1,8 +1,8 @@
 $ jq --help | trim
-jq - commandline JSON processor [version 1.6]
+jq - commandline JSON processor [version 1.8.1]
 
-Usage:  /usr/bin/jq [options] <jq filter> [file...]
-        /usr/bin/jq [options] --args <jq filter> [strings...]
-        /usr/bin/jq [options] --jsonargs <jq filter> [JSON_TEXTS...]
+Usage:  jq [options] <jq filter> [file...]
+        jq [options] --args <jq filter> [strings...]
+        jq [options] --jsonargs <jq filter> [JSON_TEXTS...]
 
 jq is a tool for processing JSON inputs, applying the given filter to
@@ -10,3 +10,3 @@
 standard output.
 
-… with 37 more lines
+… with 52 more lines
```

## Code block 44: `$ tldr tar | trim 20`

- id: `chapter-2-getting-started.html:block:44`
- hash: `35bae9d7`
- status: **accept**
- cause: image
- note: tldr is tealdeer now; different pages and layout. Prose (02:680-690) still fits

```diff
--- 2e
+++ 2.5e
@@ -1,22 +1,22 @@
 $ tldr tar | trim 20
 
-  tar
+  Archiving utility.
+  Often combined with a compression method, such as `gzip` or `bzip2`.
+  More information: <https://www.gnu.org/software/tar/manual/tar.html>.
 
-  Archiving utility.
-  Often combined with a compression method, such as gzip or bzip2.
-  More information: https://www.gnu.org/software/tar.
+  [c]reate an archive and write it to a [f]ile:
 
-  - [c]reate an archive and write it to a [f]ile:
-    tar cf target.tar file1 file2 file3
+      tar cf path/to/target.tar path/to/file1 path/to/file2 ...
 
-  - [c]reate a g[z]ipped archive and write it to a [f]ile:
-    tar czf target.tar.gz file1 file2 file3
+  [c]reate a g[z]ipped archive and write it to a [f]ile:
 
-  - [c]reate a g[z]ipped archive from a directory using relative paths:
-    tar czf target.tar.gz --directory=path/to/directory .
+      tar czf path/to/target.tar.gz path/to/file1 path/to/file2 ...
 
-  - E[x]tract a (compressed) archive [f]ile into the current directory [v]erbos…
-    tar xvf source.tar[.gz|.bz2|.xz]
+  [c]reate a g[z]ipped (compressed) archive from a directory using relative pat…
 
-  - E[x]tract a (compressed) archive [f]ile into the target directory:
-… with 12 more lines
+      tar czf path/to/target.tar.gz [-C|--directory] path/to/directory .
+
+  E[x]tract a (compressed) archive [f]ile into the current directory [v]erbosel…
+
+      tar xvf path/to/source.tar.ext
+… with 17 more lines
```

## 8 old anchor(s) missing

- id: `chapter-2-getting-started.html:anchors-missing`
- hash: `97aa3a9a`
- status: **accept**
- cause: conversion
- note: Figure anchors are #fig-x instead of #fig:x (Quarto cross-references); section anchors are unchanged

```diff
fig:diagram-essential-pipe
fig:diagram-essential-redirect-devnull
fig:diagram-essential-redirect-stdout
fig:diagram-essential-sponge
fig:diagram-essential-stdin-cat
fig:diagram-essential-streams
fig:diagram-essential-tee
fig:umbrella

(new-only: fig-diagram-essential-pipe, fig-diagram-essential-pipe-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-diagram-essential-redirect-devnull, fig-diagram-essential-redirect-devnull-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-diagram-essential-redirect-stdout, fig-diagram-essential-redirect-stdout-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-diagram-essential-sponge, fig-diagram-essential-sponge-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-diagram-essential-stdin-cat, fig-diagram-essential-stdin-cat-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-diagram-essential-streams, fig-diagram-essential-streams-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-diagram-essential-tee, fig-diagram-essential-tee-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-umbrella, fig-umbrella-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fn1, fn10, fn11, fn12, fn13, fn14, fn15, fn16, fn17, fn18, fn19, fn2, fn20, fn21, fn22, fn23, fn3, fn4, fn5, fn6, fn7, fn8, fn9, fnref1, fnref10, fnref11, fnref12, fnref13, fnref14, fnref15, fnref16, fnref17, fnref18, fnref19, fnref2, fnref20, fnref21, fnref22, fnref23, fnref3, fnref4, fnref5, fnref6, fnref7, fnref8, fnref9, footnotes, title-block-header)
```

