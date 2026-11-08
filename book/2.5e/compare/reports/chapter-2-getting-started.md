# chapter-2-getting-started.html

Image: `datasciencetoolbox/dsatcl2e@sha256:9cd9b96f9e1b3a286a103fef60b0c6129cae316735486f496571ddd1293ad4e1`

## Extra code block 38: `$ csvlook /data/ch07/tips.csv`

- id: `chapter-2-getting-started.html:block-extra:6d823d14`
- hash: `703e6c59`
- status: **accept**
- cause: content
- note: Content pass: csvlook example, now without `which csvlook`

```diff
--- 2e
+++ 2.5e
@@ -0,0 +1,12 @@
+$ csvlook /data/ch07/tips.csv
+│  bill │   tip │ sex    │ smoker │ day  │ time   │ size │
+├───────┼───────┼────────┼────────┼──────┼────────┼──────┤
+│ 16.99 │  1.01 │ Female │  False │ Sun  │ Dinner │    2 │
+│ 10.34 │  1.66 │ Male   │  False │ Sun  │ Dinner │    3 │
+│ 21.01 │  3.50 │ Male   │  False │ Sun  │ Dinner │    3 │
+│ 23.68 │  3.31 │ Male   │  False │ Sun  │ Dinner │    2 │
+│ 24.59 │  3.61 │ Female │  False │ Sun  │ Dinner │    4 │
+│ 25.29 │  4.71 │ Male   │  False │ Sun  │ Dinner │    4 │
+│  8.77 │  2.00 │ Male   │  False │ Sun  │ Dinner │    2 │
+│ 26.88 │  3.12 │ Male   │  False │ Sun  │ Dinner │    4 │
+… with 236 more lines
```

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
- hash: `d1875701`
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
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch02/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch03/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch04/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch05/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch06/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch07/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch08/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch09/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch10/
 
 $ cd ch02
```

## Code block 18: `$ curl "https://www.gutenberg.org/files/11/11-0.txt" | grep " CHAPTER"`

- id: `chapter-2-getting-started.html:block:18`
- hash: `0d3d9f82`
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
+100 170.2k 100 170.2k   0      0 126.8M      0                              0
 
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
- hash: `cf7cabab`
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
+   1   │      1  2026-11-09
+   2   │      2  2026-11-10
+   3   │      3  2026-11-11
+   4   │      4  2026-11-12
+   5   │      5  2026-11-13
 ───────┴────────────────────────────────────────────────────────────────────────
 
@@ -22,8 +22,8 @@
        │ File: dates.txt
 ───────┼────────────────────────────────────────────────────────────────────────
-   1   │      1  2021-12-15
-   2   │      2  2021-12-16
-   3   │      3  2021-12-17
-   4   │      4  2021-12-18
-   5   │      5  2021-12-19
+   1   │      1  2026-11-09
+   2   │      2  2026-11-10
+   3   │      3  2026-11-11
+   4   │      4  2026-11-12
+   5   │      5  2026-11-13
 ───────┴────────────────────────────────────────────────────────────────────────
```

## Code block 27: `$ ls /data/ch10`

- id: `chapter-2-getting-started.html:block:27`
- hash: `24222aa9`
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
+-rw-r--r-- 1 dst dst 1.7K Nov  8 21:47 Untitled1337.ipynb
+-rw-r--r-- 1 dst dst 164K Nov  8 21:47 alice.txt
+-rw-r--r-- 1 dst dst  460 Nov  8 21:47 count.R
+-rwxr-xr-x 1 dst dst  408 Nov  8 21:47 count.py*
```

## Code block 33: `$ cd /data`

- id: `chapter-2-getting-started.html:block:33`
- hash: `fbe94778`
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
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch02/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch03/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch04/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch05/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch06/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch07/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch08/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch09/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 ch10/
+drwxr-xr-x 2 dst dst 4.0K Nov  8 21:47 logs/
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
- hash: `c3b30832`
- status: **accept**
- cause: intended
- note: Content pass: the csvlook function as a copyable code block (datasciencetoolbox#20); `command csvlook` instead of /usr/bin/csvlook

```diff
--- 2e
+++ 2.5e
@@ -1,18 +1,4 @@
-$ which csvlook
 csvlook () {
-        /usr/bin/csvlook "$@" | trim | sed 's/- | -/──┼──/g;s/| -/├──/g;s/- |/──
-┤/;s/|/│/g;2s/-/─/g'
+  command csvlook "$@" | trim |
+    sed '2s/- | -/──┼──/g;2s/| -/├──/g;2s/- |/──┤/;s/|/│/g;2s/-/─/g'
 }
-
-$ csvlook /data/ch07/tips.csv
-│  bill │   tip │ sex    │ smoker │ day  │ time   │ size │
-├───────┼───────┼────────┼────────┼──────┼────────┼──────┤
-│ 16.99 │  1.01 │ Female │  False │ Sun  │ Dinner │    2 │
-│ 10.34 │  1.66 │ Male   │  False │ Sun  │ Dinner │    3 │
-│ 21.01 │  3.50 │ Male   │  False │ Sun  │ Dinner │    3 │
-│ 23.68 │  3.31 │ Male   │  False │ Sun  │ Dinner │    2 │
-│ 24.59 │  3.61 │ Female │  False │ Sun  │ Dinner │    4 │
-│ 25.29 │  4.71 │ Male   │  False │ Sun  │ Dinner │    4 │
-│  8.77 │  2.00 │ Male   │  False │ Sun  │ Dinner │    2 │
-│ 26.88 │  3.12 │ Male   │  False │ Sun  │ Dinner │    4 │
-… with 236 more lines
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

## Prose (replace): If you still prefer to run the command-line tools natively rather than

- id: `chapter-2-getting-started.html:prose:6ff8ee51`
- hash: `786cda22`
- status: **accept**
- cause: content
- note: Content pass: point to the image's Dockerfile instead of installation instructions that don't exist

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-If you still prefer to run the command-line tools natively rather than inside a Docker container, then you can, of course, install the command-line tools individually yourself. Please be aware that this is a very time-consuming process. The Appendix lists all the command-line tools used in the book. The installation instructions are for Ubuntu only. The scripts and data sets used in the book can be obtained by cloning this book’s GitHub repository.
+If you still prefer to run the command-line tools natively rather than inside a Docker container, then you can, of course, install the command-line tools individually yourself. Please be aware that this is a very time-consuming process. The Appendix lists all the command-line tools used in the book. The Dockerfile of the Docker image shows how each of them is installed on Ubuntu. The scripts and data sets used in the book can be obtained by cloning this book’s GitHub repository.
```

## Prose (insert): The Docker image works on Intel/AMD and ARM computers, including Macs 

- id: `chapter-2-getting-started.html:prose:99530bad`
- hash: `b4f046ca`
- status: **accept**
- cause: content
- note: Content pass: note about ARM support and the :20210628 image

```diff
--- 2e
+++ 2.5e
@@ -0,0 +1 @@
+The Docker image works on Intel/AMD and ARM computers, including Macs with Apple Silicon. It has been updated since the book was published, so some output may look slightly different from the printed book. If you want the exact environment that was used for the printed book, use datasciencetoolbox/dsatcl2e:20210628 instead of datasciencetoolbox/dsatcl2e in the commands in this chapter.
```

## Prose (replace): If the output is a comma-separated values, I often pipe it through csv

- id: `chapter-2-getting-started.html:prose:25395da1`
- hash: `49f62c19`
- status: **accept**
- cause: content
- note: Content pass: show the csvlook function as a copyable code block (datasciencetoolbox#20)

```diff
--- 2e
+++ 2.5e
@@ -1 +1,2 @@
-If the output is a comma-separated values, I often pipe it through csvlook to turn it into a nice-looking table. If you run csvlook, you’ll see the complete table. I have redefined csvlook such that the table is shortened by trim:
+If the output is a comma-separated values, I often pipe it through csvlook to turn it into a nice-looking table. If you run csvlook, you’ll see the complete table. I have redefined csvlook such that the table is shortened by trim, and drawn with box-drawing characters:
+command makes sure that the original csvlook is run, not the function itself. To get the same behavior on your own machine, add this function to your ~/.zshrc. Here’s the result:
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

## External links differ

- id: `chapter-2-getting-started.html:external-links`
- hash: `9985b1eb`
- status: **accept**
- cause: content
- note: Content pass: link to the image's Dockerfile

```diff
--- 2e
+++ 2.5e
@@ -1,0 +2 @@
+https://github.com/datasciencetoolbox/datasciencetoolbox/blob/main/Dockerfile
```

## Footnotes differ (23 vs 23)

- id: `chapter-2-getting-started.html:footnotes`
- hash: `87e88f1a`
- status: **accept**
- cause: content
- note: Citations show the versions and years of the tools in the current image (content pass, tools.bib)

```diff
--- 2e
+++ 2.5e
@@ -1,7 +1,7 @@
-Richard M. Stallman and David MacKenzie, ls – List Directory Contents, version 8.30, 2019, https://www.gnu.org/software/coreutils.
-Torbjorn Granlund and Richard M. Stallman, cat – Concatenate Files and Print on the Standard Output, version 8.30, 2018, https://www.gnu.org/software/coreutils.
-Stephen Dolan, jq – Command-Line JSON Processor, version 1.6, 2021, https://stedolan.github.com/jq.
-Ulrich Drepper, seq – Print a Sequence of Numbers, version 8.30, 2019, https://www.gnu.org/software/coreutils.
-Jim Meyering, pwd – Print Name of Working Directory, version 8.30, 2019, https://www.gnu.org/software/coreutils.
-David MacKenzie and Jim Meyering, head – Output the First Part of Files, version 8.30, 2019, https://www.gnu.org/software/coreutils.
-David M. Ihnat and David MacKenzie, paste – Merge Lines of Files, version 8.30, 2019, https://www.gnu.org/software/coreutils.
+uutils contributors, ls – List Directory Contents, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+uutils contributors, cat – Concatenate Files and Print on the Standard Output, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+Stephen Dolan, jq – Command-Line JSON Processor, version 1.8.1, 2025, https://jqlang.org.
+uutils contributors, seq – Print a Sequence of Numbers, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+uutils contributors, pwd – Print Name of Working Directory, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+uutils contributors, head – Output the First Part of Files, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+uutils contributors, paste – Merge Lines of Files, version 0.10.0, 2026, https://github.com/uutils/coreutils.
@@ -10,4 +10,4 @@
-Jim Meyering, grep – Print Lines That Match Patterns, version 3.4, 2019, https://www.gnu.org/software/grep.
-Paul Rubin and David MacKenzie, wc – Print Newline, Word, and Byte Counts for Each File, version 8.30, 2019, https://www.gnu.org/software/coreutils.
-Mike Haertel and Paul Eggert, sort – Sort Lines of Text Files, version 8.30, 2019, https://www.gnu.org/software/coreutils.
-Karel Zak, rev – Reverse Lines Characterwise, version 2.36.1, 2021, https://www.kernel.org/pub/linux/utils/util-linux.
+Jim Meyering, grep – Print Lines That Match Patterns, version 3.12, 2025, https://www.gnu.org/software/grep.
+uutils contributors, wc – Print Newline, Word, and Byte Counts for Each File, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+uutils contributors, sort – Sort Lines of Text Files, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+Karel Zak, rev – Reverse Lines Characterwise, version 2.41.3, 2025, https://www.kernel.org/pub/linux/utils/util-linux.
@@ -15 +15 @@
-Colin Watson and Tollef Fog Heen, sponge – Soak up Standard Input and Write to a File, version 0.65, 2021, https://joeyh.name/code/moreutils.
+Colin Watson and Tollef Fog Heen, sponge – Soak up Standard Input and Write to a File, version 0.69, 2024, https://joeyh.name/code/moreutils.
@@ -17,7 +17,7 @@
-Scott Bartram and David MacKenzie, nl – Number Lines of Files, version 8.30, 2020, https://www.gnu.org/software/coreutils.
-Mike Parker, David MacKenzie, and Jim Meyering, mv – Move (Rename) Files, version 8.30, 2020, https://www.gnu.org/software/coreutils.
-Paul Rubin et al., rm – Remove Files or Directories, version 8.30, 2019, https://www.gnu.org/software/coreutils.
-Torbjorn Granlund, David MacKenzie, and Jim Meyering, cp – Copy Files and Directories, version 8.30, 2018, https://www.gnu.org/software/coreutils.
-David MacKenzie, mkdir – Make Directories, version 8.30, 2019, https://www.gnu.org/software/coreutils.
-John W. Eaton and Colin Watson, man – an Interface to the System Reference Manuals, version 2.9.1, 2020, https://nongnu.org/man-db.
-Owen Voke, tldr – Collaborative Cheatsheets for Console Commands, version 3.3.7, 2021, https://tldr.sh.
+uutils contributors, nl – Number Lines of Files, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+Mike Parker, David MacKenzie, and Jim Meyering, mv – Move (Rename) Files, version 9.7, 2025, https://www.gnu.org/software/coreutils.
+Paul Rubin et al., rm – Remove Files or Directories, version 9.7, 2025, https://www.gnu.org/software/coreutils.
+Torbjorn Granlund, David MacKenzie, and Jim Meyering, cp – Copy Files and Directories, version 9.7, 2025, https://www.gnu.org/software/coreutils.
+uutils contributors, mkdir – Make Directories, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+John W. Eaton and Colin Watson, man – an Interface to the System Reference Manuals, version 2.13.1, 2025, https://nongnu.org/man-db.
+Danilo Bargen and Niklas Mohrin, tldr – Collaborative Cheatsheets for Console Commands, version 1.8.1, 2025, https://github.com/tealdeer-rs/tealdeer.
```

