# chapter-3-obtaining-data.html

Image: `datasciencetoolbox/dsatcl2e@sha256:9cd9b96f9e1b3a286a103fef60b0c6129cae316735486f496571ddd1293ad4e1`

## Code block 0: `$ cd /data/ch03`

- id: `chapter-3-obtaining-data.html:block:0`
- hash: `657d538e`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -3,8 +3,8 @@
 $ l
 total 924K
--rw-r--r-- 1 dst dst 627K Dec 14 11:46 logs.tar.gz
--rw-r--r-- 1 dst dst 189K Dec 14 11:46 r-datasets.db
--rw-r--r-- 1 dst dst  149 Dec 14 11:46 tmnt-basic.csv
--rw-r--r-- 1 dst dst  148 Dec 14 11:46 tmnt-missing-newline.csv
--rw-r--r-- 1 dst dst  181 Dec 14 11:46 tmnt-with-header.csv
--rw-r--r-- 1 dst dst  91K Dec 14 11:46 top2000.xlsx
+-rw-r--r-- 1 dst dst 627K Nov  8 21:16 logs.tar.gz
+-rw-r--r-- 1 dst dst 189K Nov  8 21:16 r-datasets.db
+-rw-r--r-- 1 dst dst  149 Nov  8 21:16 tmnt-basic.csv
+-rw-r--r-- 1 dst dst  148 Nov  8 21:16 tmnt-missing-newline.csv
+-rw-r--r-- 1 dst dst  181 Nov  8 21:16 tmnt-with-header.csv
+-rw-r--r-- 1 dst dst  91K Nov  8 21:16 top2000.xlsx
```

## Code block 3: `$ curl "https://en.wikipedia.org/wiki/List_of_windmills_in_the_Netherl`

- id: `chapter-3-obtaining-data.html:block:3`
- hash: `1bcd6b2c`
- status: **accept**
- cause: image
- note: curl 8 progress meter layout

```diff
--- 2e
+++ 2.5e
@@ -1,8 +1,8 @@
 $ curl "https://en.wikipedia.org/wiki/List_of_windmills_in_the_Netherlands" |
 > trim ➊
-  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
-                                 Dload  Upload   Total   Spent    Left  Speed
-  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!
-DOCTYPE html>
+  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
+                                 Dload  Upload  Total   Spent   Left   Speed
+  0      0   0      0   0      0      0      0                              0<!D
+OCTYPE html>
 <html class="client-nojs" lang="en" dir="ltr">
 <head>
@@ -11,7 +11,7 @@
 <script>document.documentElement.className="client-js";RLCONF={"wgBreakFrames":…
 "wgRelevantPageName":"List_of_windmills_in_the_Netherlands","wgRelevantArticleI…
-,"site.styles":"ready","user.styles":"ready","ext.globalCssJs.user":"ready","us…
+"noscript":"ready","user.styles":"ready","ext.globalCssJs.user":"ready","user":…
 "ext.growthExperiments.SuggestedEditSession"];</script>
 <script>(RLQ=window.RLQ||[]).push(function(){mw.loader.implement("user.options@…
-100  249k    0  249k    0     0   853k      0 --:--:-- --:--:-- --:--:--  867k
-… with 1754 more lines
+100 246.3k 100 246.3k   0      0 158.8M      0                              0
+… with 1729 more lines
```

## Code block 5: `$ curl -s "https://en.wikipedia.org/wiki/List_of_windmills_in_Frieslan`

- id: `chapter-3-obtaining-data.html:block:5`
- hash: `eaf34d69`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -3,9 +3,9 @@
 $ l
 total 1.4M
--rw-r--r-- 1 dst dst 432K Dec 14 11:46 List_of_windmills_in_Friesland
--rw-r--r-- 1 dst dst 627K Dec 14 11:46 logs.tar.gz
--rw-r--r-- 1 dst dst 189K Dec 14 11:46 r-datasets.db
--rw-r--r-- 1 dst dst  149 Dec 14 11:46 tmnt-basic.csv
--rw-r--r-- 1 dst dst  148 Dec 14 11:46 tmnt-missing-newline.csv
--rw-r--r-- 1 dst dst  181 Dec 14 11:46 tmnt-with-header.csv
--rw-r--r-- 1 dst dst  91K Dec 14 11:46 top2000.xlsx
+-rw-r--r-- 1 dst dst 430K Nov  8 21:16 List_of_windmills_in_Friesland
+-rw-r--r-- 1 dst dst 627K Nov  8 21:16 logs.tar.gz
+-rw-r--r-- 1 dst dst 189K Nov  8 21:16 r-datasets.db
+-rw-r--r-- 1 dst dst  149 Nov  8 21:16 tmnt-basic.csv
+-rw-r--r-- 1 dst dst  148 Nov  8 21:16 tmnt-missing-newline.csv
+-rw-r--r-- 1 dst dst  181 Nov  8 21:16 tmnt-with-header.csv
+-rw-r--r-- 1 dst dst  91K Nov  8 21:16 top2000.xlsx
```

## Code block 9: `$ curl -s "https://bit.ly/2XBxvwK"`

- id: `chapter-3-obtaining-data.html:block:9`
- hash: `48524532`
- status: **accept**
- cause: network
- note: Cached response from November 2026 (no 2021 copy available)

```diff
--- 2e
+++ 2.5e
@@ -1,5 +1,4 @@
 $ curl -s "https://bit.ly/2XBxvwK"
 <html>
-<head><title>Bitly</title></head>
 <body><a href="https://youtu.be/dQw4w9WgXcQ">moved here</a></body>
 </html>%
```

## Code block 11: `$ curl -sI "https://youtu.be/dQw4w9WgXcQ" | trim`

- id: `chapter-3-obtaining-data.html:block:11`
- hash: `31b3b566`
- status: **accept**
- cause: network
- note: Cached response from November 2026 (no 2021 copy available)

```diff
--- 2e
+++ 2.5e
@@ -1,12 +1,12 @@
 $ curl -sI "https://youtu.be/dQw4w9WgXcQ" | trim
-HTTP/2 303
+HTTP/1.1 303
 content-type: application/binary
 x-content-type-options: nosniff
+connection-allowlist-report-only: (response-origin "https://youtube.com" "https…
 cache-control: no-cache, no-store, max-age=0, must-revalidate
 pragma: no-cache
 expires: Mon, 01 Jan 1990 00:00:00 GMT
-date: Tue, 14 Dec 2021 10:46:22 GMT
+date: Thu, 05 Nov 2026 21:51:23 GMT
 location: https://www.youtube.com/watch?v=dQw4w9WgXcQ&feature=youtu.be
-content-length: 0
 x-frame-options: SAMEORIGIN
-… with 11 more lines
+… with 16 more lines
```

## Code block 12: `$ man curl | trim 20`

- id: `chapter-3-obtaining-data.html:block:12`
- hash: `0e0089ec`
- status: **accept**
- cause: image
- note: curl 8 man page

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
 $ man curl | trim 20
-curl(1)                           Curl Manual                          curl(1)
+curl(1)                           curl Manual                          curl(1)
 
 NAME
@@ -9,14 +9,14 @@
 
 DESCRIPTION
-       curl  is  a tool to transfer data from or to a server, using one of the
-       supported protocols (DICT, FILE, FTP, FTPS, GOPHER, HTTP, HTTPS,  IMAP,
-       IMAPS,  LDAP,  LDAPS,  MQTT, POP3, POP3S, RTMP, RTMPS, RTSP, SCP, SFTP,
-       SMB, SMBS, SMTP, SMTPS, TELNET and TFTP). The command  is  designed  to
-       work without user interaction.
+       curl is a tool for transferring data from or to a server using URLs. It
+       supports these protocols: DICT, FILE, FTP, FTPS, GOPHER, GOPHERS, HTTP,
+       HTTPS,  IMAP, IMAPS, LDAP, LDAPS, MQTT, POP3, POP3S, RTMP, RTMPS, RTSP,
+       SCP, SFTP, SMB, SMBS, SMTP, SMTPS, TELNET, TFTP, WS and WSS.
 
-       curl offers a busload of useful tricks like proxy support, user authen‐
-       tication, FTP upload, HTTP post, SSL connections, cookies, file  trans‐
-       fer  resume,  Metalink,  and more. As you will see below, the number of
-       features will make your head spin!
+       curl is powered by  libcurl  for  all  transfer-related  features.  See
+       libcurl(3) for details.
 
-… with 3986 more lines
+URL
+       The  URL  syntax is protocol-dependent. You find a detailed description
+       in RFC 3986.
+… with 7571 more lines
```

## Code block 22: `$ curl "https://www.nporadio2.nl/data/download/TOP-2000-2020.xlsx" > t`

- id: `chapter-3-obtaining-data.html:block:22`
- hash: `75d45ed3`
- status: **accept**
- cause: image
- note: curl 8 progress meter layout

```diff
--- 2e
+++ 2.5e
@@ -1,7 +1,7 @@
 $ curl "https://www.nporadio2.nl/data/download/TOP-2000-2020.xlsx" > top2000.xls
 x
-  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
-                                 Dload  Upload   Total   Spent    Left  Speed
-100 41744  100 41744    0     0  46024      0 --:--:-- --:--:-- --:--:-- 46228
+  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
+                                 Dload  Upload  Total   Spent   Left   Speed
+100      8 100      8   0      0   9445      0                              0
 
 $ in2csv top2000.xlsx | tee top2000.csv | trim
```

## Code block 23: `$ csvgrep top2000.csv --columns ARTIEST --regex '^Queen$' | csvlook -I`

- id: `chapter-3-obtaining-data.html:block:23`
- hash: `cfb31730`
- status: **accept**
- cause: image
- note: csvkit 1.1.0 on an empty file: an empty table instead of StopIteration; no ResourceWarning

```diff
--- 2e
+++ 2.5e
@@ -1,3 +1,3 @@
 $ csvgrep top2000.csv --columns ARTIEST --regex '^Queen$' | csvlook -I ➊
-StopIteration:
-StopIteration:
+││
+│  │
```

## Code block 24: `$ in2csv --names top2000.xlsx`

- id: `chapter-3-obtaining-data.html:block:24`
- hash: `3f8d1215`
- status: **accept**
- cause: image
- note: csvkit 1.1.0 on an empty file: an empty table instead of StopIteration; no ResourceWarning

```diff
--- 2e
+++ 2.5e
@@ -1,3 +1,2 @@
 $ in2csv --names top2000.xlsx
 BadZipFile: File is not a zip file
-sys:1: ResourceWarning: unclosed file <_io.BufferedReader name='top2000.xlsx'>
```

## Code block 28: `$ curl -s "http://newsapi.org/v2/everything?q=linux&apiKey=$(< /data/.`

- id: `chapter-3-obtaining-data.html:block:28`
- hash: `89edfe60`
- status: **accept**
- cause: network
- note: newsapi response rebuilt from the 2e output (no API key); the long description is cut at a different place

```diff
--- 2e
+++ 2.5e
@@ -13,5 +13,5 @@
       "author": "Igor Bonifacic",
       "title": "'Arma 3' and 'DayZ' add BattlEye anti-cheat support through Val…
-      "description": "While there are still many unknowns about Steam Deck\r\n
+      "description": "While there are still many unknowns about Steam Deck\r\n …
       "url": "https://www.engadget.com/arma-3-dayz-proton-battleye-support-2246…
       "urlToImage": "https://s.yimg.com/os/creatr-uploaded-images/2021-12/bcb0f…
```

## Footnotes differ (13 vs 13)

- id: `chapter-3-obtaining-data.html:footnotes`
- hash: `1cbc023f`
- status: **accept**
- cause: content
- note: Citations show the versions and years of the tools in the current image (content pass, tools.bib)

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,4 @@
-Daniel Stenberg, curl – Transfer a URL, version 7.68.0, 2016, https://curl.haxx.se.
-Christopher Groskopf, in2csv – Convert Common, but Less Awesome, Tabular Data Formats to CSV, version 1.0.5, 2020, https://csvkit.rtfd.org.
-Christopher Groskopf, sql2csv – Execute an SQL Query on a Database and Output the Result to a CSV File, version 1.0.5, 2020, https://csvkit.rtfd.org.
-John Gilmore and Jay Fenlason, tar – an Archiving Utility, version 1.30, 2014, https://www.gnu.org/software/tar.
+Daniel Stenberg, curl – Transfer a URL, version 8.18.0, 2026, https://curl.se.
+Christopher Groskopf, in2csv – Convert Common, but Less Awesome, Tabular Data Formats to CSV, version 1.1.0, 2023, https://csvkit.rtfd.org.
+Christopher Groskopf, sql2csv – Execute an SQL Query on a Database and Output the Result to a CSV File, version 1.1.0, 2023, https://csvkit.rtfd.org.
+John Gilmore and Jay Fenlason, tar – an Archiving Utility, version 1.35, 2023, https://www.gnu.org/software/tar.
@@ -7 +7 @@
-Ben Asselstine, Christian Scheurer, and Johannes Winkelmann, unrar – Extract Files from Rar Archives, version 0.0.1, 2014, http://home.gna.org/unrar.
+Ben Asselstine, Christian Scheurer, and Johannes Winkelmann, unrar – Extract Files from Rar Archives, version 0.3.3, 2025, https://gitlab.com/bgermann/unrar-free.
@@ -10 +10 @@
-Christopher Groskopf, csvlook – Render a CSV File in the Console as a Markdown-Compatible, Fixed-Width Table, version 1.0.5, 2020, https://csvkit.rtfd.org.
+Christopher Groskopf, csvlook – Render a CSV File in the Console as a Markdown-Compatible, Fixed-Width Table, version 1.1.0, 2023, https://csvkit.rtfd.org.
@@ -12 +12 @@
-Mats Erik Andersson, Andreas Henriksson, and Christoph Biedl, telnet – User Interface to the TELNET Protocol, version 0.17, 1999, http://www.hcs.harvard.edu/~dholland/computers/netkit.html.
+GNU Inetutils developers, telnet – User Interface to the TELNET Protocol, version 2.7, 2025, https://www.gnu.org/software/inetutils.
```

