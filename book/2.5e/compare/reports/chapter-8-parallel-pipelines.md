# chapter-8-parallel-pipelines.html

Image: `datasciencetoolbox/dsatcl2e@sha256:ac2e2f4327e2873ff504d7e72cc8f1fa8abb9701698a123b2539ad3157ce9302`

## Code block 0: `$ cd /data/ch08`

- id: `chapter-8-parallel-pipelines.html:block:0`
- hash: `96a771b6`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -3,6 +3,6 @@
 $ l
 total 20K
--rw-r--r-- 1 dst dst  126 Dec 14 11:54 emails.txt
--rw-r--r-- 1 dst dst   61 Dec 14 11:54 movies.txt
--rwxr-xr-x 1 dst dst  125 Dec 14 11:54 slow.sh*
--rw-r--r-- 1 dst dst 5.1K Dec 14 11:54 users.json
+-rw-r--r-- 1 dst dst  126 Nov 26 11:57 emails.txt
+-rw-r--r-- 1 dst dst   61 Nov 26 11:57 movies.txt
+-rwxr-xr-x 1 dst dst  125 Nov 26 11:57 slow.sh*
+-rw-r--r-- 1 dst dst 5.1K Nov 26 11:57 users.json
```

## Code block 2: `$ for i in {0..100..2}  ➊`

- id: `chapter-8-parallel-pipelines.html:block:2`
- hash: `f79701bd`
- status: **accept**
- cause: conversion
- note: Callout markers right after the code; 2e aligned the comments

```diff
--- 2e
+++ 2.5e
@@ -1,5 +1,5 @@
-$ for i in {0..100..2}  ➊
+$ for i in {0..100..2} ➊
 > do
-> echo "$i^2" | bc      ➋
+> echo "$i^2" | bc ➋
 > done | trim
 0
```

## Code block 4: `$ while read line                         ➊`

- id: `chapter-8-parallel-pipelines.html:block:4`
- hash: `30cd2da8`
- status: **accept**
- cause: conversion
- note: Callout markers right after the code; 2e aligned the comments

```diff
--- 2e
+++ 2.5e
@@ -1,6 +1,6 @@
-$ while read line                         ➊
+$ while read line ➊
 > do
-> echo "Sending invitation to ${line}."   ➋
-> done < emails                           ➌
+> echo "Sending invitation to ${line}." ➋
+> done < emails ➌
 Sending invitation to selma.andersen@example.com.
 Sending invitation to kent.clark@example.com.
```

## Code block 6: `$ for chapter in /data/*`

- id: `chapter-8-parallel-pipelines.html:block:6`
- hash: `191b7cb6`
- status: **accept**
- cause: image
- note: No csvconf directory in /data anymore

```diff
--- 2e
+++ 2.5e
@@ -12,3 +12,2 @@
 Processing Chapter /data/ch09.
 Processing Chapter /data/ch10.
-Processing Chapter /data/csvconf.
```

## Code block 7: `$ find /data -type f -name '*.csv' -size -2k`

- id: `chapter-8-parallel-pipelines.html:block:7`
- hash: `981c51be`
- status: **accept**
- cause: uutils
- note: Timestamps and ls sort order (uutils sorts by byte value)

```diff
--- 2e
+++ 2.5e
@@ -1,8 +1,8 @@
 $ find /data -type f -name '*.csv' -size -2k
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

## Code block 9: `$ for i in {A..C}; do`

- id: `chapter-8-parallel-pipelines.html:block:9`
- hash: `eb498c8e`
- status: **accept**
- cause: random
- note: Background jobs: PIDs, timestamps, random durations, and order

```diff
--- 2e
+++ 2.5e
@@ -2,19 +2,21 @@
 > ./slow.sh $i & ➊
 > done
-[2] 386 ➋
-[3] 388
-[4] 391
+[2] 172 ➋
+[3] 173
+[4] 174
 
-$ Dec 14 11:54:18 Starting job A
-Dec 14 11:54:18 Starting job B
-Dec 14 11:54:18 Starting job C
-Dec 14 11:54:20Dec 14 11:54:20 Job B took 2 seconds
- Job C took 2 seconds
+$ Nov 26 11:57:54Nov 26 11:57:54 Starting job A
+ Starting job B
+Nov 26 11:57:54 Starting job C
+Nov 26 11:57:55 Job B took 1 seconds
 
 [3]  - done       ./slow.sh $i
+
+$ Nov 26 11:57:56 Job A took 2 seconds
+
+[2]  - done       ./slow.sh $i
+
+$ Nov 26 11:57:59 Job C took 5 seconds
+
+[4]  + done       ./slow.sh $i
 $
-[4]  + done       ./slow.sh $i
-$ Dec 14 11:54:23 Job A took 5 seconds
-
-[2]  + done       ./slow.sh $i
-$
```

## Code block 10: `$ seq 0 2 100 | parallel "echo {}^2 | bc" | trim`

- id: `chapter-8-parallel-pipelines.html:block:10`
- hash: `c1e5788c`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -1,6 +1,6 @@
 $ seq 0 2 100 | parallel "echo {}^2 | bc" | trim
 0
+4
 16
-4
 36
 64
@@ -8,5 +8,5 @@
 144
 196
+256
 324
-400
 … with 41 more lines
```

## Code block 11: `$ parallel --jobs 2 ./slow.sh ::: {A..C}`

- id: `chapter-8-parallel-pipelines.html:block:11`
- hash: `720ae362`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -1,7 +1,7 @@
 $ parallel --jobs 2 ./slow.sh ::: {A..C}
-Dec 14 11:54:28 Starting job B
-Dec 14 11:54:31 Job B took 3 seconds
-Dec 14 11:54:28 Starting job A
-Dec 14 11:54:33 Job A took 5 seconds
-Dec 14 11:54:32 Starting job C
-Dec 14 11:54:37 Job C took 5 seconds
+Nov 26 11:58:02 Starting job A
+Nov 26 11:58:06 Job A took 4 seconds
+Nov 26 11:58:02 Starting job B
+Nov 26 11:58:07 Job B took 5 seconds
+Nov 26 11:58:06 Starting job C
+Nov 26 11:58:08 Job C took 2 seconds
```

## Code block 15: `$ find /data/ch03 -type f | parallel echo '{#}\) \"{}\" has basename \`

- id: `chapter-8-parallel-pipelines.html:block:15`
- hash: `b2507846`
- status: **accept**
- cause: uutils
- note: Timestamps and ls sort order (uutils sorts by byte value)

```diff
--- 2e
+++ 2.5e
@@ -1,7 +1,7 @@
 $ find /data/ch03 -type f | parallel echo '{#}\) \"{}\" has basename \"{/}\"' ➊
-1) "/data/ch03/tmnt-basic.csv" has basename "tmnt-basic.csv"
-2) "/data/ch03/logs.tar.gz" has basename "logs.tar.gz"
-3) "/data/ch03/tmnt-missing-newline.csv" has basename "tmnt-missing-newline.csv"
-4) "/data/ch03/r-datasets.db" has basename "r-datasets.db"
-5) "/data/ch03/top2000.xlsx" has basename "top2000.xlsx"
-6) "/data/ch03/tmnt-with-header.csv" has basename "tmnt-with-header.csv"
+1) "/data/ch03/tmnt-missing-newline.csv" has basename "tmnt-missing-newline.csv"
+2) "/data/ch03/r-datasets.db" has basename "r-datasets.db"
+3) "/data/ch03/tmnt-with-header.csv" has basename "tmnt-with-header.csv"
+4) "/data/ch03/tmnt-basic.csv" has basename "tmnt-basic.csv"
+5) "/data/ch03/logs.tar.gz" has basename "logs.tar.gz"
+6) "/data/ch03/top2000.xlsx" has basename "top2000.xlsx"
```

## Code block 23: `$ seq 5 | parallel --tag "echo 'sqrt({})' | bc -l"`

- id: `chapter-8-parallel-pipelines.html:block:23`
- hash: `e38b3981`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -1,7 +1,7 @@
 $ seq 5 | parallel --tag "echo 'sqrt({})' | bc -l"
 1       1
+2       1.41421356237309504880
 3       1.73205080756887729352
 4       2.00000000000000000000
-2       1.41421356237309504880
 5       2.23606797749978969640
 
```

## Code block 26: `$ aws ec2 describe-instances | jq '.Reservations[].Instances[] | {publ`

- id: `chapter-8-parallel-pipelines.html:block:26`
- hash: `08a8743e`
- status: **accept**
- cause: intended
- note: Fake output is shown now: in 2e the echo chain ended with &&, so it never ran and the next command was typed after a continuation prompt

```diff
--- 2e
+++ 2.5e
@@ -1,2 +1,10 @@
 $ aws ec2 describe-instances | jq '.Reservations[].Instances[] | {public_dns: .P
 ublicDnsName, state: .State.Name}'
+{
+  "state": "running",
+  "public_dns": "ec2-54-88-122-140.compute-1.amazonaws.com"
+}
+{
+  "state": "stopped",
+  "public_dns": null
+}
```

## Code block 27: `> aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | se`

- id: `chapter-8-parallel-pipelines.html:block:27`
- hash: `7cec57b4`
- status: **accept**
- cause: intended
- note: Fake output is shown now: in 2e the echo chain ended with &&, so it never ran and the next command was typed after a continuation prompt

```diff
--- 2e
+++ 2.5e
@@ -1,3 +1,3 @@
-> aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select(.Stat
+$ aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select(.Stat
 e.Name=="running") | .PublicDnsName' | tee hostnames
 ec2-54-88-122-140.compute-1.amazonaws.com
```

## Code block 39: `$ l nyc*json.gz`

- id: `chapter-8-parallel-pipelines.html:block:39`
- hash: `baba119a`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -1,11 +1,11 @@
 $ l nyc*json.gz
--rw-r--r-- 1 dst dst 16K Dec 14 11:55 nyc-10.json.gz
--rw-r--r-- 1 dst dst 13K Dec 14 11:56 nyc-1.json.gz
--rw-r--r-- 1 dst dst 14K Dec 14 11:55 nyc-2.json.gz
--rw-r--r-- 1 dst dst 14K Dec 14 11:55 nyc-3.json.gz
--rw-r--r-- 1 dst dst 14K Dec 14 11:55 nyc-4.json.gz
--rw-r--r-- 1 dst dst 16K Dec 14 11:55 nyc-5.json.gz
--rw-r--r-- 1 dst dst 16K Dec 14 11:55 nyc-6.json.gz
--rw-r--r-- 1 dst dst 16K Dec 14 11:55 nyc-7.json.gz
--rw-r--r-- 1 dst dst 16K Dec 14 11:56 nyc-8.json.gz
--rw-r--r-- 1 dst dst 15K Dec 14 11:56 nyc-9.json.gz
+-rw-r--r-- 1 dst dst 16K Nov 26 11:58 nyc-1.json.gz
+-rw-r--r-- 1 dst dst 17K Nov 26 11:58 nyc-10.json.gz
+-rw-r--r-- 1 dst dst 15K Nov 26 11:58 nyc-2.json.gz
+-rw-r--r-- 1 dst dst 16K Nov 26 11:58 nyc-3.json.gz
+-rw-r--r-- 1 dst dst 17K Nov 26 11:58 nyc-4.json.gz
+-rw-r--r-- 1 dst dst 14K Nov 26 11:58 nyc-5.json.gz
+-rw-r--r-- 1 dst dst 16K Nov 26 11:58 nyc-6.json.gz
+-rw-r--r-- 1 dst dst 15K Nov 26 11:58 nyc-7.json.gz
+-rw-r--r-- 1 dst dst 17K Nov 26 11:58 nyc-8.json.gz
+-rw-r--r-- 1 dst dst 18K Nov 26 11:58 nyc-9.json.gz
```

## Code block 40: `$ zcat nyc-1.json.gz | trim`

- id: `chapter-8-parallel-pipelines.html:block:40`
- hash: `8b905105`
- status: **accept**
- cause: network
- note: NYC Open Data cached in November 2026 (no 2021 copy)

```diff
--- 2e
+++ 2.5e
@@ -1,12 +1,12 @@
 $ zcat nyc-1.json.gz | trim
-{"unique_key":"52779474","created_date":"2021-12-13T02:10:31.000","agency":"NYP…
-{"unique_key":"52776058","created_date":"2021-12-13T02:09:50.000","agency":"NYP…
-{"unique_key":"52775678","created_date":"2021-12-13T02:08:53.000","agency":"NYP…
-{"unique_key":"52782776","created_date":"2021-12-13T02:07:37.000","closed_date"…
-{"unique_key":"52778629","created_date":"2021-12-13T02:07:32.000","agency":"NYP…
-{"unique_key":"52776019","created_date":"2021-12-13T02:07:23.000","agency":"NYP…
-{"unique_key":"52776002","created_date":"2021-12-13T02:04:07.000","agency":"NYP…
-{"unique_key":"52775975","created_date":"2021-12-13T02:02:46.000","agency":"NYP…
-{"unique_key":"52776757","created_date":"2021-12-13T02:01:36.000","agency":"NYP…
-{"unique_key":"52780492","created_date":"2021-12-13T02:01:35.000","agency":"NYP…
+{"unique_key":"70999722","created_date":"2026-11-04T02:05:23.000","agency":"NYP…
+{"unique_key":"70996337","created_date":"2026-11-04T02:04:46.000","agency":"NYP…
+{"unique_key":"70992486","created_date":"2026-11-04T02:04:27.000","agency":"DOT…
+{"unique_key":"70994889","created_date":"2026-11-04T02:04:03.000","agency":"NYP…
+{"unique_key":"70996371","created_date":"2026-11-04T02:03:26.000","agency":"NYP…
+{"unique_key":"70996950","created_date":"2026-11-04T02:03:16.000","agency":"NYP…
+{"unique_key":"70994472","created_date":"2026-11-04T02:02:45.000","agency":"NYP…
+{"unique_key":"71000949","created_date":"2026-11-04T02:02:28.000","agency":"NYP…
+{"unique_key":"70993548","created_date":"2026-11-04T02:01:53.000","agency":"DEP…
+{"unique_key":"70996360","created_date":"2026-11-04T02:01:21.000","agency":"NYP…
 … with 90 more lines
```

## Code block 41: `$ zcat nyc-1.json.gz | head -n 1`

- id: `chapter-8-parallel-pipelines.html:block:41`
- hash: `df6b33d7`
- status: **accept**
- cause: network
- note: NYC Open Data cached in November 2026 (no 2021 copy)

```diff
--- 2e
+++ 2.5e
@@ -1,13 +1,16 @@
 $ zcat nyc-1.json.gz | head -n 1
-{"unique_key":"52779474","created_date":"2021-12-13T02:10:31.000","agency":"NYPD
-","agency_name":"New York City Police Department","complaint_type":"Encampment",
-"descriptor":"N/A","location_type":"Subway","status":"In Progress","community_bo
-ard":"Unspecified QUEENS","borough":"QUEENS","x_coordinate_state_plane":"1039396
-","y_coordinate_state_plane":"195150","open_data_channel_type":"MOBILE","park_fa
-cility_name":"Unspecified","park_borough":"QUEENS","bridge_highway_name":"E","br
-idge_highway_segment":"Mezzanine","latitude":"40.702146602995356","longitude":"-
-73.80111202259863","location":{"latitude":"40.702146602995356","longitude":"-73.
-80111202259863","human_address":"{\"address\": \"\", \"city\": \"\", \"state\":
-\"\", \"zip\": \"\"}"},":@computed_region_efsh_h5xi":"24340",":@computed_region_
-f5dn_yrer":"41",":@computed_region_yeji_bk3q":"3",":@computed_region_92fq_4b7q":
-"6",":@computed_region_sbqj_enih":"61"}
+{"unique_key":"70999722","created_date":"2026-11-04T02:05:23.000","agency":"NYPD
+","agency_name":"New York City Police Department","complaint_type":"Noise - Resi
+dential","descriptor":"Banging/Pounding","location_type":"Residential Building/H
+ouse","incident_zip":"10023","incident_address":"21 WEST END AVENUE","street_nam
+e":"WEST END AVENUE","cross_street_1":"WEST 60 STREET","cross_street_2":"WEST 61
+ STREET","intersection_street_1":"WEST 60 STREET","intersection_street_2":"WEST
+61 STREET","address_type":"ADDRESS","city":"NEW YORK","landmark":"WEST END AVENU
+E","status":"In Progress","community_board":"07 MANHATTAN","council_district":"0
+6","police_precinct":"Precinct 20","bbl":"1011717510","borough":"MANHATTAN","x_c
+oordinate_state_plane":"987063","y_coordinate_state_plane":"220706","open_data_c
+hannel_type":"MOBILE","park_facility_name":"Unspecified","park_borough":"MANHATT
+AN","latitude":"40.772462881371915","longitude":"-73.98984401160628","location":
+{"type":"Point","coordinates":[-73.989844011606,40.772462881372]},":@computed_re
+gion_f5dn_yrer":"20",":@computed_region_yeji_bk3q":"4",":@computed_region_sbqj_e
+nih":"12",":@computed_region_92fq_4b7q":"19"}
```

## Code block 42: `$ zcat nyc*json.gz | ➊`

- id: `chapter-8-parallel-pipelines.html:block:42`
- hash: `83728306`
- status: **accept**
- cause: uutils
- note: Timestamps and ls sort order (uutils sorts by byte value)

```diff
--- 2e
+++ 2.5e
@@ -8,7 +8,7 @@
 │ borough       │ count │
 ├───────────────┼───────┤
-│ brooklyn      │   285 │
-│ queens        │   271 │
-│ manhattan     │   226 │
-│ bronx         │   200 │
-│ staten_island │    18 │
+│ brooklyn      │   337 │
+│ manhattan     │   246 │
+│ queens        │   220 │
+│ bronx         │   169 │
+│ staten_island │    28 │
```

## Code block 44: `$ ssh $(head -n 1 hostnames) ls`

- id: `chapter-8-parallel-pipelines.html:block:44`
- hash: `6501c706`
- status: **accept**
- cause: intended
- note: Fake output is shown now: in 2e the echo chain ended with &&, so it never ran and the next command was typed after a continuation prompt

```diff
--- 2e
+++ 2.5e
@@ -1 +1,4 @@
 $ ssh $(head -n 1 hostnames) ls
+nyc-1.json.csv
+nyc-1.json.gz
+jq
```

## Code block 45: `> cat nyc-1.json.csv`

- id: `chapter-8-parallel-pipelines.html:block:45`
- hash: `abcbe18d`
- status: **accept**
- cause: intended
- note: Fake output is shown now: in 2e the echo chain ended with &&, so it never ran and the next command was typed after a continuation prompt

```diff
--- 2e
+++ 2.5e
@@ -1,3 +1,3 @@
-> cat nyc-1.json.csv
+$ cat nyc-1.json.csv
 bronx,3
 brooklyn,5
```

## Code block 46: `$ cat nyc*csv | header -a borough,count |`

- id: `chapter-8-parallel-pipelines.html:block:46`
- hash: `51511bb1`
- status: **accept**
- cause: uutils
- note: Timestamps and ls sort order (uutils sorts by byte value)

```diff
--- 2e
+++ 2.5e
@@ -4,7 +4,7 @@
 │ borough       │ count │
 ├───────────────┼───────┤
-│ brooklyn      │   285 │
-│ queens        │   271 │
-│ manhattan     │   226 │
-│ bronx         │   200 │
-│ staten_island │    18 │
+│ brooklyn      │   337 │
+│ manhattan     │   246 │
+│ queens        │   220 │
+│ bronx         │   169 │
+│ staten_island │    28 │
```

## Code block 47: `$ cat nyc*csv | header -a borough,count |`

- id: `chapter-8-parallel-pipelines.html:block:47`
- hash: `d4c6bea2`
- status: **accept**
- cause: uutils
- note: Timestamps and ls sort order (uutils sorts by byte value)

```diff
--- 2e
+++ 2.5e
@@ -5,7 +5,7 @@
 │ borough       │ count │
 ├───────────────┼───────┤
-│ brooklyn      │   285 │
-│ queens        │   271 │
-│ manhattan     │   226 │
-│ bronx         │   200 │
-│ staten_island │    18 │
+│ brooklyn      │   337 │
+│ manhattan     │   246 │
+│ queens        │   220 │
+│ bronx         │   169 │
+│ staten_island │    28 │
```

## Prose (replace): The Z shell has a feature called brace expansion, which transforms {0.

- id: `chapter-8-parallel-pipelines.html:prose:744d984f`
- hash: `6c67ec89`
- status: **accept**
- cause: content
- note: {0..100..2} gives 2 in the second iteration, issue #121

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-The Z shell has a feature called brace expansion, which transforms {0..100..2} into a list separated by spaces: 0 2 4 … 98 100. The variable i is assigned the value “0” in the first iteration, “1” in the second iteration, and so forth.
+The Z shell has a feature called brace expansion, which transforms {0..100..2} into a list separated by spaces: 0 2 4 … 98 100. The variable i is assigned the value “0” in the first iteration, “2” in the second iteration, and so forth.
```

## Prose (replace): When the input items are filenames, there are a couple of modifiers yo

- id: `chapter-8-parallel-pipelines.html:prose:1517aaa7`
- hash: `f7694ef7`
- status: **accept**
- cause: content
- note: Wording, issue #121

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-When the input items are filenames, there are a couple of modifiers you can use only parts of the filename. For example, with {/}, only the basename of the filename will be used:
+When the input items are filenames, there are a couple of modifiers you can use to get only parts of the filename. For example, with {/}, only the basename of the filename will be used:
```

## Prose (replace): By default, parallel runs one job per CPU core. You can control the nu

- id: `chapter-8-parallel-pipelines.html:prose:6f32c5c9`
- hash: `3b825ad3`
- status: **accept**
- cause: content
- note: Clearer -j+M and -j-M, issue #121

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-By default, parallel runs one job per CPU core. You can control the number of jobs that will be run concurrently with the --jobs or -j option. Specifying a number means that many jobs will be run concurrently. If you put a plus sign in front of the number then parallel will run N jobs plus the number of CPU cores. If you put a minus sign in front of the number then parallel will run N-M jobs. Where N is the number of CPU cores. You can also specify a percentage, where the default is 100% of the number of CPU cores. The optimal number of jobs to run concurrently depends on the actual commands you are running.
+By default, parallel runs one job per CPU core. You can control the number of jobs that will be run concurrently with the --jobs or -j option. Specifying a number means that many jobs will be run concurrently. If you put a plus sign in front of the number M (for example, -j+2), then parallel will run N+M jobs, where N is the number of CPU cores. If you put a minus sign in front of it (for example, -j-2), then parallel will run N-M jobs. You can also specify a percentage, where the default is 100% of the number of CPU cores. The optimal number of jobs to run concurrently depends on the actual commands you are running.
```

## 3 old anchor(s) missing

- id: `chapter-8-parallel-pipelines.html:anchors-missing`
- hash: `711f60a5`
- status: **accept**
- cause: conversion
- note: Figure anchors are #fig-x instead of #fig:x (Quarto cross-references); section anchors are unchanged

```diff
fig:diagram-parallel-output
fig:diagram-parallel-processing
fig:diagram-parallel-results

(new-only: fig-diagram-parallel-output, fig-diagram-parallel-output-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-diagram-parallel-processing, fig-diagram-parallel-processing-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-diagram-parallel-results, fig-diagram-parallel-results-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fn1, fn10, fn11, fn2, fn3, fn4, fn5, fn6, fn7, fn8, fn9, fnref1, fnref10, fnref11, fnref2, fnref3, fnref4, fnref5, fnref6, fnref7, fnref8, fnref9, footnotes, title-block-header)
```

## External links differ

- id: `chapter-8-parallel-pipelines.html:external-links`
- hash: `9dae1f49`
- status: **accept**
- cause: conversion
- note: bookdown linked R function names in inline code to rdrr.io; Quarto does not (no R code is run)

```diff
--- 2e
+++ 2.5e
@@ -2 +1,0 @@
-https://rdrr.io/r/base/Paren.html
```

## Footnotes differ (11 vs 11)

- id: `chapter-8-parallel-pipelines.html:footnotes`
- hash: `d264a6fb`
- status: **accept**
- cause: conversion
- note: Citations show the versions and years of the tools in the current image (content pass, tools.bib)

```diff
--- 2e
+++ 2.5e
@@ -1,5 +1,5 @@
-Tange, parallel – Build and Execute Shell Command Lines from Standard Input in Parallel.
-Nelson, bc – an Arbitrary Precision Calculator Language.
-Stallman and MacKenzie, ls – List Directory Contents.
-Eric B. Decker, James Youngman, and Kevin Dalley, find – Search for Files in a Directory Hierarchy, version 4.7.0, 2019, https://www.gnu.org/software/findutils.
-Hess, ts – Timestamp Input.
+Ole Tange, parallel – Build and Execute Shell Command Lines from Standard Input in Parallel, version 20240222, 2024, https://www.gnu.org/software/parallel.
+Philip A. Nelson, bc – an Arbitrary Precision Calculator Language, version 1.07.1, 2017, https://www.gnu.org/software/bc.
+uutils contributors, ls – List Directory Contents, version 0.10.0, 2026, https://github.com/uutils/coreutils.
+Eric B. Decker, James Youngman, and Kevin Dalley, find – Search for Files in a Directory Hierarchy, version 4.10.0, 2024, https://www.gnu.org/software/findutils.
+Joey Hess, ts – Timestamp Input, version 0.69, 2024, https://joeyh.name/code/moreutils.
@@ -7,5 +7,5 @@
-Amazon Web Services, aws – Unified Tool to Manage AWS Services, version 2.1.32, 2021, https://aws.amazon.com/cli.
-Tatu Ylonen et al., ssh – OpenSSH Remote Login Client, version 1:8.2p1-4ubuntu0.2, 2020, https://www.openssh.com.
-Peter Tobias, Bernd Eckenfels, and Michael Meskes, hostname – Show or Set the System’s Host Name, version 3.23, 2021, https://sourceforge.net/projects/net-tools/.
-Paul Eggert, zcat – Decompress and Concatenate Files to Standard Output, version 1.10, 2021, https://www.nongnu.org/zutils/zutils.html.
-Janssens, rush – R One-Liners from the Shell.
+Amazon Web Services, aws – Unified Tool to Manage AWS Services, version 2.31.35, 2025, https://aws.amazon.com/cli.
+Tatu Ylonen et al., ssh – OpenSSH Remote Login Client, version 10.2p1, 2025, https://www.openssh.com.
+Peter Tobias, Bernd Eckenfels, and Michael Meskes, hostname – Show or Set the System’s Host Name, version 3.25, 2024, https://sourceforge.net/projects/net-tools/.
+Paul Eggert, zcat – Decompress and Concatenate Files to Standard Output, version 1.14, 2025, https://www.gnu.org/software/gzip.
+Jeroen Janssens, rush – R One-Liners from the Shell, version 0.2.1.9000, 2026, https://github.com/jeroenjanssens/rush.
```

