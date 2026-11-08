# list-of-command-line-tools.html

Image: `datasciencetoolbox/dsatcl2e@sha256:470005890402401f1d3c84f8ebb5afceaf53e7c57af54f8fb06709a2727f0560`

## Code block 2: `$ type aws`

- id: `list-of-command-line-tools.html:block:2`
- hash: `01db8da8`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type aws
-aws is /usr/local/bin/aws
+aws is /usr/bin/aws
 
 $ aws --help
```

## Code block 6: `$ type body`

- id: `list-of-command-line-tools.html:block:6`
- hash: `a0fcaa5e`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -4,12 +4,12 @@
 $ seq 10 | header -a 'values' | body shuf
 values
-3
-7
+8
 10
-9
-5
 4
 6
-8
+1
+5
+7
+3
+9
 2
-1
```

## Code block 12: `$ type cowsay`

- id: `list-of-command-line-tools.html:block:12`
- hash: `ce20a64f`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type cowsay
-cowsay is /usr/bin/cowsay
+cowsay is /usr/local/bin/cowsay
 
 $ man cowsay
```

## Code block 15: `$ type csvcut`

- id: `list-of-command-line-tools.html:block:15`
- hash: `243fd91e`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type csvcut
-csvcut is /usr/bin/csvcut
+csvcut is /opt/uv/bin/csvcut
 
 $ csvcut --help
```

## Code block 16: `$ type csvgrep`

- id: `list-of-command-line-tools.html:block:16`
- hash: `05e5b297`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type csvgrep
-csvgrep is /usr/bin/csvgrep
+csvgrep is /opt/uv/bin/csvgrep
 
 $ csvgrep --help
```

## Code block 17: `$ type csvjoin`

- id: `list-of-command-line-tools.html:block:17`
- hash: `4c2a213c`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type csvjoin
-csvjoin is /usr/bin/csvjoin
+csvjoin is /opt/uv/bin/csvjoin
 
 $ csvjoin --help
```

## Code block 20: `$ type csvsort`

- id: `list-of-command-line-tools.html:block:20`
- hash: `aae3c1fc`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type csvsort
-csvsort is /usr/bin/csvsort
+csvsort is /opt/uv/bin/csvsort
 
 $ csvsort --help
```

## Code block 21: `$ type csvsql`

- id: `list-of-command-line-tools.html:block:21`
- hash: `d9c1639c`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type csvsql
-csvsql is /usr/bin/csvsql
+csvsql is /opt/uv/bin/csvsql
 
 $ csvsql --help
```

## Code block 22: `$ type csvstack`

- id: `list-of-command-line-tools.html:block:22`
- hash: `9423a16a`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type csvstack
-csvstack is /usr/bin/csvstack
+csvstack is /opt/uv/bin/csvstack
 
 $ csvstack --help
```

## Code block 23: `$ type csvstat`

- id: `list-of-command-line-tools.html:block:23`
- hash: `226e4f65`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type csvstat
-csvstat is /usr/bin/csvstat
+csvstat is /opt/uv/bin/csvstat
 
 $ csvstat --help
```

## Code block 27: `$ type dseq`

- id: `list-of-command-line-tools.html:block:27`
- hash: `c544aaa1`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -3,5 +3,5 @@
 
 $ dseq 3
-2021-12-15
-2021-12-16
-2021-12-17
+2026-11-09
+2026-11-10
+2026-11-11
```

## Code block 32: `$ type find`

- id: `list-of-command-line-tools.html:block:32`
- hash: `720530b2`
- status: **accept**
- cause: uutils
- note: Timestamps and ls sort order (uutils sorts by byte value)

```diff
--- 2e
+++ 2.5e
@@ -5,9 +5,9 @@
 
 $ find /data -type f -name '*.csv' -size -3
-/data/ch03/tmnt-basic.csv
 /data/ch03/tmnt-missing-newline.csv
 /data/ch03/tmnt-with-header.csv
+/data/ch03/tmnt-basic.csv
+/data/ch07/datatypes.csv
+/data/ch05/names.csv
+/data/ch05/names-comma.csv
 /data/ch05/irismeta.csv
-/data/ch05/names-comma.csv
-/data/ch05/names.csv
-/data/ch07/datatypes.csv
```

## Code block 42: `$ type hostname`

- id: `list-of-command-line-tools.html:block:42`
- hash: `bdb03022`
- status: **accept**
- cause: random
- note: Container hostname

```diff
--- 2e
+++ 2.5e
@@ -5,5 +5,5 @@
 
 $ hostname
-2c3edb64827b
+215104384d46
 
 $ hostname -i
```

## Code block 43: `$ type in2csv`

- id: `list-of-command-line-tools.html:block:43`
- hash: `aab9deab`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type in2csv
-in2csv is /usr/bin/in2csv
+in2csv is /opt/uv/bin/in2csv
 
 $ in2csv --help
```

## Code block 45: `$ type json2csv`

- id: `list-of-command-line-tools.html:block:45`
- hash: `24f5a238`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type json2csv
-json2csv is /usr/bin/json2csv
+json2csv is /usr/local/bin/json2csv
 
 $ json2csv --help
```

## Code block 46: `$ type l`

- id: `list-of-command-line-tools.html:block:46`
- hash: `9b785ba7`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -10,8 +10,8 @@
 $ l
 total 924K
--rw-r--r-- 1 dst dst 627K Dec 14 12:03 logs.tar.gz
--rw-r--r-- 1 dst dst 189K Dec 14 12:03 r-datasets.db
--rw-r--r-- 1 dst dst  149 Dec 14 12:03 tmnt-basic.csv
--rw-r--r-- 1 dst dst  148 Dec 14 12:03 tmnt-missing-newline.csv
--rw-r--r-- 1 dst dst  181 Dec 14 12:03 tmnt-with-header.csv
--rw-r--r-- 1 dst dst  91K Dec 14 12:03 top2000.xlsx
+-rw-r--r-- 1 dst dst 627K Nov  8 14:58 logs.tar.gz
+-rw-r--r-- 1 dst dst 189K Nov  8 14:58 r-datasets.db
+-rw-r--r-- 1 dst dst  149 Nov  8 14:58 tmnt-basic.csv
+-rw-r--r-- 1 dst dst  148 Nov  8 14:58 tmnt-missing-newline.csv
+-rw-r--r-- 1 dst dst  181 Nov  8 14:58 tmnt-with-header.csv
+-rw-r--r-- 1 dst dst  91K Nov  8 14:58 top2000.xlsx
```

## Code block 48: `$ type ls`

- id: `list-of-command-line-tools.html:block:48`
- hash: `d40db31c`
- status: **accept**
- cause: image
- note: No csvconf directory in /data anymore

```diff
--- 2e
+++ 2.5e
@@ -5,3 +5,3 @@
 
 $ ls /data
-ch02  ch03  ch04  ch05  ch06  ch07  ch08  ch09  ch10  csvconf
+ch02  ch03  ch04  ch05  ch06  ch07  ch08  ch09  ch10
```

## Code block 56: `$ type paste`

- id: `list-of-command-line-tools.html:block:56`
- hash: `65584270`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -5,9 +5,9 @@
 
 $ paste -d, <(seq 5) <(dseq 5)
-1,2021-12-15
-2,2021-12-16
-3,2021-12-17
-4,2021-12-18
-5,2021-12-19
+1,2026-11-09
+2,2026-11-10
+3,2026-11-11
+4,2026-11-12
+5,2026-11-13
 
 $ seq 5 | paste -sd+
```

## Code block 58: `$ type pip`

- id: `list-of-command-line-tools.html:block:58`
- hash: `69a4bcb9`
- status: **accept**
- cause: image
- note: pip is a uv shim; pip freeze shows the uv environment

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type pip
-pip is /usr/bin/pip
+pip is /usr/local/bin/pip
 
 $ man pip
@@ -7,4 +7,3 @@
 
 $ pip freeze | grep sci
-scikit-learn==0.24.2
-scipy==1.7.0
+Using Python 3.13.18 environment at: /opt/venv
```

## Code block 59: `$ type pup`

- id: `list-of-command-line-tools.html:block:59`
- hash: `05fd273e`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type pup
-pup is /usr/bin/pup
+pup is /usr/local/bin/pup
 
 $ pup --help
```

## Code block 65: `$ type rush`

- id: `list-of-command-line-tools.html:block:65`
- hash: `04a5e579`
- status: **accept**
- cause: image
- note: rush location; tibble 3 printing; starwars.csv 2021 snapshot capitalizes Lars

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type rush
-rush is /usr/local/lib/R/site-library/rush/exec/rush
+rush is /usr/local/bin/rush
 
 $ rush --help
@@ -8,5 +8,5 @@
 
 $ rush run --tidyverse 'filter(starwars, species == "Human") %>% select(name)'
-# A tibble: 35 x 1
+# A tibble: 35 × 1
    name
    <chr>
@@ -15,5 +15,5 @@
  3 Leia Organa
  4 Owen Lars
- 5 Beru Whitesun lars
+ 5 Beru Whitesun Lars
  6 Biggs Darklighter
  7 Obi-Wan Kenobi
@@ -21,3 +21,3 @@
  9 Wilhuff Tarkin
 10 Han Solo
-# … with 25 more rows
+# ℹ 25 more rows
```

## Code block 66: `$ type sample`

- id: `list-of-command-line-tools.html:block:66`
- hash: `f5a26fd7`
- status: **accept**
- cause: random
- note: Random output (sample, shuf)

```diff
--- 2e
+++ 2.5e
@@ -1,12 +1,12 @@
 $ type sample
-sample is /usr/local/bin/sample
+sample is /opt/uv/bin/sample
 
 $ sample --help
 
 $ seq 1000 | sample -r 0.01 | trim 5
-160
-300
-337
-340
-434
-… with 6 more lines
+50
+53
+57
+82
+343
+… with 7 more lines
```

## Code block 71: `$ type shuf`

- id: `list-of-command-line-tools.html:block:71`
- hash: `49a8480c`
- status: **accept**
- cause: random
- note: Random output (sample, shuf)

```diff
--- 2e
+++ 2.5e
@@ -5,16 +5,16 @@
 
 $ echo {a..z} | tr ' ' '\n' | shuf | trim 5
-s
-a
-k
+f
+o
+r
+u
 x
-y
 … with 21 more lines
 
 $ shuf -i 1-100 | trim 5
-61
-60
-5
-92
-10
+98
+18
+9
+63
+28
 … with 95 more lines
```

## Code block 76: `$ type sql2csv`

- id: `list-of-command-line-tools.html:block:76`
- hash: `636babb4`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type sql2csv
-sql2csv is /usr/bin/sql2csv
+sql2csv is /opt/uv/bin/sql2csv
 
 $ sql2csv --help
```

## Code block 80: `$ type tapkee`

- id: `list-of-command-line-tools.html:block:80`
- hash: `fbaf9f20`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type tapkee
-tapkee is /usr/bin/tapkee
+tapkee is /usr/local/bin/tapkee
 
 $ tapkee --help
```

## Code block 84: `$ type tldr`

- id: `list-of-command-line-tools.html:block:84`
- hash: `20a9a30f`
- status: **accept**
- cause: image
- note: tldr is tealdeer: different location and pages

```diff
--- 2e
+++ 2.5e
@@ -1,19 +1,17 @@
 $ type tldr
-tldr is /usr/local/bin/tldr
+tldr is /usr/bin/tldr
 
 $ tldr --help
 
 $ tldr tar | trim
-✔ Page not found. Updating cache...
-✔ Creating index...
-
-  tar
 
   Archiving utility.
-  Often combined with a compression method, such as gzip or bzip2.
-  More information: https://www.gnu.org/software/tar.
+  Often combined with a compression method, such as `gzip` or `bzip2`.
+  More information: <https://www.gnu.org/software/tar/manual/tar.html>.
 
-  - [c]reate an archive and write it to a [f]ile:
-    tar cf target.tar file1 file2 file3
+  [c]reate an archive and write it to a [f]ile:
 
-… with 22 more lines
+      tar cf path/to/target.tar path/to/file1 path/to/file2 ...
+
+  [c]reate a g[z]ipped archive and write it to a [f]ile:
+… with 27 more lines
```

## Code block 86: `$ type tree`

- id: `list-of-command-line-tools.html:block:86`
- hash: `f9f50e3b`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -15,3 +15,3 @@
 │   │   ├── logs.tar.gz
 │   │   ├── r-datasets.db
-… with 121572 more lines
+… with 106047 more lines
```

## Code block 88: `$ type ts`

- id: `list-of-command-line-tools.html:block:88`
- hash: `cc1ae077`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -3,3 +3,3 @@
 
 $ echo seq 5 | sample -d 500 | ts
-Dec 14 12:07:20 seq 5
+Nov 08 15:00:01 seq 5
```

## Code block 99: `$ type xsv`

- id: `list-of-command-line-tools.html:block:99`
- hash: `c4bbf5eb`
- status: **accept**
- cause: image
- note: Tools live in other places in the new image

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ type xsv
-xsv is /usr/bin/xsv
+xsv is /usr/local/bin/xsv
 
 $ xsv --help
```

