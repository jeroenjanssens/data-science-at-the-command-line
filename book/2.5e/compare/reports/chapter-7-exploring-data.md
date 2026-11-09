# chapter-7-exploring-data.html

Image: `datasciencetoolbox/dsatcl2e@sha256:9cd9b96f9e1b3a286a103fef60b0c6129cae316735486f496571ddd1293ad4e1`

## Code block 0: `$ cd /data/ch07`

- id: `chapter-7-exploring-data.html:block:0`
- hash: `c95e2435`
- status: **accept**
- cause: uutils
- note: Timestamps and ls sort order (uutils sorts by byte value)

```diff
--- 2e
+++ 2.5e
@@ -3,6 +3,6 @@
 $ l
 total 104K
--rw-r--r-- 1 dst dst  125 Dec 14 11:49 datatypes.csv
--rw-r--r-- 1 dst dst 7.8K Dec 14 11:49 tips.csv
--rw-r--r-- 1 dst dst  83K Dec 14 11:49 venture.csv
--rw-r--r-- 1 dst dst 4.6K Dec 14 11:49 venture-wide.csv
+-rw-r--r-- 1 dst dst  125 Nov  9 18:43 datatypes.csv
+-rw-r--r-- 1 dst dst 7.8K Nov  9 18:43 tips.csv
+-rw-r--r-- 1 dst dst 4.6K Nov  9 18:43 venture-wide.csv
+-rw-r--r-- 1 dst dst  83K Nov  9 18:43 venture.csv
```

## Code block 20: `> library(tidyverse)                            ➊`

- id: `chapter-7-exploring-data.html:block:20`
- hash: `a1a77299`
- status: **accept**
- cause: image
- note: tidyverse 2 startup message; callout marker right after the code (2e aligned the comments)

```diff
--- 2e
+++ 2.5e
@@ -1,27 +1,27 @@
-> library(tidyverse)                            ➊
-── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
-✔ ggplot2 3.3.3     ✔ purrr   0.3.4
-✔ tibble  3.0.6     ✔ dplyr   1.0.4
-✔ tidyr   1.1.2     ✔ stringr 1.4.0
-✔ readr   1.4.0     ✔ forcats 0.5.1
+> library(tidyverse) ➊
+── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
+✔ dplyr     1.2.1     ✔ readr     2.2.0
+✔ forcats   1.0.1     ✔ stringr   1.6.0
+✔ ggplot2   4.0.3     ✔ tibble    3.3.1
+✔ lubridate 1.9.5     ✔ tidyr     1.3.2
+✔ purrr     1.2.2
 ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
 ✖ dplyr::filter() masks stats::filter()
 ✖ dplyr::lag()    masks stats::lag()
-> df <- read_csv("tips.csv")                    ➋
+ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all confl
+icts to become errors
+> df <- read_csv("tips.csv") ➋
 
+Rows: 244 Columns: 7
 ── Column specification ────────────────────────────────────────────────────────
-cols(
-  bill = col_double(),
-  tip = col_double(),
-  sex = col_character(),
-  smoker = col_character(),
-  day = col_character(),
-  time = col_character(),
-  size = col_double()
-)
+Delimiter: ","
+chr (4): sex, smoker, day, time
+dbl (3): bill, tip, size
 
-> df <- mutate(df, percent = tip / bill * 100)  ➌
-> write_csv(df, "percent.csv")                  ➍
-> q("no")                                       ➎
-
+ℹ Use `spec()` to retrieve the full column specification for this data.
+ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message
+.
+> df <- mutate(df, percent = tip / bill * 100) ➌
+> write_csv(df, "percent.csv") ➍
+> q("no") ➎
 $
```

## Code block 23: `$ rush run --help`

- id: `chapter-7-exploring-data.html:block:23`
- hash: `3dd91960`
- status: **accept**
- cause: image
- note: rush 0.2.1: new help text and generated script (ir shebang); prose to update (book-changes-plan D, ch 7)

```diff
--- 2e
+++ 2.5e
@@ -3,27 +3,56 @@
 
 Usage:
-  rush run [options] <expression> [--] [<file>...]
+  rush run [options] [<expression>] [--] [<file>...]
+
+Arguments:
+  <expression>             R expression to evaluate. The value of the last
+                           expression is printed or written out.
+  <file>                   Data file(s) to read. Two variables are always set:
+                           'df' (the first input) and 'dfs' (a named list of
+                           all inputs, keyed by file stem). Database files
+                           (.duckdb, .sqlite) are nested one level deeper:
+                           dfs$dbname$tablename. The reader is chosen by
+                           extension. Use '-' to read from standard input
+                           (becomes dfs$stdin).
+
+Note: -d/--delimiter sets both input and output delimiter. Use -F, -D, or -O
+to override format and delimiter for each side independently.
 
 Reading options:
-  -d, --delimiter <str>    Delimiter [default: ,].
-  -C, --no-clean-names     No clean names.
-  -H, --no-header          No header.
+  -d, --delimiter <str>         Delimiter (input and output) [default: ,].
+      --input-delimiter <str>   Input delimiter (overrides -d).
+  -F, --input-format <format>   Input format [default: auto].
+      --input-sheet <name|int>  Excel sheet to read.
+      --names <a,b,c>           Column names (implies no input header).
+  -C, --no-clean-names          No clean names.
+  -H, --no-header               No header (input and output).
+      --no-input-header         No input header.
+      --no-output-header        No output header.
 
 Setup options:
-  -l, --library <name>     Libraries to load.
-  -t, --tidyverse          Enter the Tidyverse.
+  -l, --library <name>          Libraries to load.
+  -t, --tidyverse               Enter the Tidyverse.
 
 Saving options:
-      --dpi <str|int>      Plot resolution [default: 300].
-      --height <int>       Plot height.
-  -o, --output <str>       Output file.
-      --units <str>        Plot size units [default: in].
-  -w, --width <int>        Plot width.
+      --dpi <int>               Plot resolution [default: 300].
+      --head <int>              Limit output rows.
+      --height <num>            Plot height.
+  -o, --output <str>            Output file.
+  -D, --output-delimiter <str>  Output delimiter (overrides -d).
+  -O, --output-format <format>  Output format [default: auto].
+      --output-indent <int>     Indentation level (JSON, YAML) [default: 2].
+      --output-record <str>     Record element name (XML, TOML) [default: record
+].
+      --output-root <str>       Root element name (XML) [default: root].
+      --output-sheet <str>      Excel sheet name to write.
+      --units <str>             Plot size units [default: in].
+  -w, --width <num>             Plot width.
 
 General options:
-  -n, --dry-run            Only print generated script.
-  -h, --help               Show this help.
-  -q, --quiet              Be quiet.
-      --seed <int>         Seed random number generator.
-  -v, --verbose            Be verbose.
-      --version            Show version.
+  -n, --dry-run                 Only print generated script.
+  -h, --help                    Show this help.
+  -I, --no-ir                   Run with Rscript, not ir.
+  -R, --no-rush                 Inline all code (no rush dep).
+      --seed <int>              Seed random number generator.
+  -v, --verbose                 Be verbose.
+      --version                 Show version.
```

## Code block 24: `$ rush run -n --tidyverse 'mutate(df, percent = tip / bill * 100)' tip`

- id: `chapter-7-exploring-data.html:block:24`
- hash: `4de42e3e`
- status: **accept**
- cause: image
- note: rush 0.2.1: new help text and generated script (ir shebang); prose to update (book-changes-plan D, ch 7)

```diff
--- 2e
+++ 2.5e
@@ -1,7 +1,24 @@
 $ rush run -n --tidyverse 'mutate(df, percent = tip / bill * 100)' tips.csv
-#!/usr/bin/env Rscript
+#!/usr/bin/env -S ir run
+#| packages:
+#|   - github::jeroenjanssens/rush@5e75a1d59384efea243a316dacf3092b36169f26
+#|   - rlang
+#|   - cli
+#|   - tibble
+#|   - readr
+#|   - tidyverse
+#|   - glue
+#|   - janitor
+
+rush::init(
+  dpi = 300L
+)
+
 library(tidyverse)
 library(glue)
-df <- janitor::clean_names(readr::read_delim("tips.csv", delim = ",", col_names
-= TRUE))
-mutate(df, percent = tip/bill * 100)
+dfs <- list()
+dfs[["tips"]] <- rush::read("tips.csv")
+df <- dfs[[1]]
+result <- mutate(df, percent = tip/bill * 100)
+
+rush::write(result)
```

## Code block 26: `$ rush plot --x bill --y tip --color size --facets '~day' tips.csv`

- id: `chapter-7-exploring-data.html:block:26`
- hash: `f3bfca45`
- status: **accept**
- cause: image
- note: rush terminal plots use devoutansi now: colored blocks instead of characters, a white canvas, and no legend

```diff
--- 2e
+++ 2.5e
@@ -1,18 +1,18 @@
 $ rush plot --x bill --y tip --color size --facets '~day' tips.csv
                       Fri                               Sat
-  10.0                                                                  * #
-   7.5                                                            *
-                                                           #            *
-   5.0          #               *                   ###  *   #  #
-            # ###  ##  ##                       #####*####+ *    **  #
-   2.5   # %###                           %  #########*#*## # #
+  10.0
+   7.5
+
+   5.0
+
+   2.5
 t                                                                          size
 i                     Sun                               Thur                6
 p 10.0                                                                      1
-   7.5                                                         =
-                    *    ** *                           #      *
-   5.0    ##    #  +#*#  +* * #      =             ##*    = = #    +*
-   2.5      ######## # *  ###   #  #            ## #####*  #
-           ## ####*  *  #+                   ###### #
+   7.5
+
+   5.0
+   2.5
+
            10    20     30     40    50       10    20     30     40    50
                                       bill
```

## Code block 33: `$ R -q -e '?ggplot2::qplot' | trim 14`

- id: `chapter-7-exploring-data.html:block:33`
- hash: `c563d84b`
- status: **accept**
- cause: image
- note: Content pass: rush no longer uses qplot; show the generated ggplot() call

```diff
--- 2e
+++ 2.5e
@@ -1,16 +1,2 @@
-$ R -q -e '?ggplot2::qplot' | trim 14
-> ?ggplot2::qplot
-qplot                 package:ggplot2                  R Documentation
-
-Quick plot
-
-Description:
-
-     ‘qplot()’ is a shortcut designed to be familiar if you're used to
-     base ‘plot()’. It's a convenient wrapper for creating a number of
-     different types of plots using a consistent calling scheme. It's
-     great for allowing you to produce plots quickly, but I highly
-     recommend learning ‘ggplot()’ as it makes it easier to create
-     complex graphics.
-
-… with 108 more lines
+$ rush plot -n --x bill --y tip tips.csv | grep 'ggplot('
+result <- ggplot(df, aes(x = bill, y = tip)) + geom_point()
```

## Code block 34: `$ rush plot --help`

- id: `chapter-7-exploring-data.html:block:34`
- hash: `1f136cdf`
- status: **accept**
- cause: image
- note: rush 0.2.1 help text

```diff
--- 2e
+++ 2.5e
@@ -3,48 +3,74 @@
 
 Usage:
-  rush plot [options] [--] [<file>|-]
+  rush plot [options] [--] [<file>...]
+
+Arguments:
+  <file>                   Data file(s) to read before plotting. The reader is
+                           chosen by extension: '.parquet'/'.pq' via
+                           nanoparquet, '.duckdb'/'.ddb' via DuckDB, everything
+                           else as delimited text. A single file is read into a
+                           data frame named 'df'; use '-' or omit to read
+                           delimited text from standard input. Multiple files
+                           are each read into a named element of a list 'dfs';
+                           combine them into 'df' yourself with the --pre
+                           option, e.g. 'df <- dplyr::bind_rows(dfs)'.
 
 Reading options:
-  -d, --delimiter <str>    Delimiter [default: ,].
-  -C, --no-clean-names     No clean names.
-  -H, --no-header          No header.
+  -d, --delimiter <str>         Delimiter (input and output) [default: ,].
+      --input-delimiter <str>   Input delimiter (overrides -d).
+  -F, --input-format <format>   Input format [default: auto].
+      --input-sheet <name|int>  Excel sheet to read.
+      --names <a,b,c>           Column names (implies no input header).
+  -C, --no-clean-names          No clean names.
+  -H, --no-header               No header (input and output).
+      --no-input-header         No input header.
+      --no-output-header        No output header.
 
 Setup options:
-  -l, --library <name>     Libraries to load.
-  -t, --tidyverse          Enter the Tidyverse.
+  -l, --library <name>          Libraries to load.
+  -t, --tidyverse               Enter the Tidyverse.
 
 Plotting options:
-      --aes <key=value>    Additional aesthetics.
-  -a, --alpha <name>       Alpha column.
-  -c, --color <name>       Color column.
-      --facets <formula>   Facet specification.
-  -f, --fill <name>        Fill column.
-  -g, --geom <geom>        Geometry [default: auto].
-      --group <name>       Group column.
-      --log <x|y|xy>       Variables to log transform.
-      --margins            Display marginal facets.
-      --post <code>        Code to run after plotting.
-      --pre <code>         Code to run before plotting.
-      --shape <name>       Shape column.
-      --size <name>        Size column.
-      --title <str>        Plot title.
-  -x, --x <name>           X column.
-      --xlab <str>         X axis label.
-  -y, --y <name>           Y column.
-      --ylab <str>         Y axis label.
-  -z, --z <name>           Z column.
+      --aes <key=value>         Additional aesthetics.
+  -a, --alpha <name>            Alpha column.
+  -c, --color <name>            Color column.
+      --facets <formula>        Facet specification.
+  -f, --fill <name>             Fill column.
+  -g, --geom <geom>             Geometry [default: auto].
+      --group <name>            Group column.
+      --log <x|y|xy>            Variables to log transform.
+      --margins                 Display marginal facets.
+      --post <code>             Code to run after plotting.
+      --pre <code>              Code to run before plotting.
+      --shape <name>            Shape column.
+      --size <name>             Size column.
+      --title <str>             Plot title.
+  -x, --x <name>                X column.
+      --xlab <str>              X axis label.
+  -y, --y <name>                Y column.
+      --ylab <str>              Y axis label.
+  -z, --z <name>                Z column.
 
 Saving options:
-      --dpi <str|int>      Plot resolution [default: 300].
-      --height <int>       Plot height.
-  -o, --output <str>       Output file.
-      --units <str>        Plot size units [default: in].
-  -w, --width <int>        Plot width.
+      --dpi <int>               Plot resolution [default: 300].
+      --head <int>              Limit output rows.
+      --height <num>            Plot height.
+  -o, --output <str>            Output file.
+  -D, --output-delimiter <str>  Output delimiter (overrides -d).
+  -O, --output-format <format>  Output format [default: auto].
+      --output-indent <int>     Indentation level (JSON, YAML) [default: 2].
+      --output-record <str>     Record element name (XML, TOML) [default: record
+].
+      --output-root <str>       Root element name (XML) [default: root].
+      --output-sheet <str>      Excel sheet name to write.
+      --units <str>             Plot size units [default: in].
+  -w, --width <num>             Plot width.
 
 General options:
-  -n, --dry-run            Only print generated script.
-  -h, --help               Show this help.
-  -q, --quiet              Be quiet.
-      --seed <int>         Seed random number generator.
-  -v, --verbose            Be verbose.
-      --version            Show version.
+  -n, --dry-run                 Only print generated script.
+  -h, --help                    Show this help.
+  -I, --no-ir                   Run with Rscript, not ir.
+  -R, --no-rush                 Inline all code (no rush dep).
+      --seed <int>              Seed random number generator.
+  -v, --verbose                 Be verbose.
+      --version                 Show version.
```

## Code block 35: `$ rush plot --x time tips.csv`

- id: `chapter-7-exploring-data.html:block:35`
- hash: `263c2a9f`
- status: **accept**
- cause: image
- note: Bar chart works again (rush 5e75a1d draws geom_bar for a discrete x); colored blocks instead of characters, like the other terminal plots

```diff
--- 2e
+++ 2.5e
@@ -1,18 +1,18 @@
 $ rush plot --x time tips.csv
-         ********************************
-         ********************************
-  150    ********************************
-         ********************************
-         ********************************
-         ********************************
-  100    ********************************
-         ********************************
-         ********************************  ********************************
-         ********************************  ********************************
-   50    ********************************  ********************************
-         ********************************  ********************************
-         ********************************  ********************************
-         ********************************  ********************************
-    0    ********************************  ********************************
+
+
+  150
+
+
+
+c 100
+o
+u
+n
+t  50
+
+
+
+    0
                       Dinner                            Lunch
                                         time
```

## Code block 37: `$ rush plot --x tip --fill time tips.csv`

- id: `chapter-7-exploring-data.html:block:37`
- hash: `05ae3861`
- status: **accept**
- cause: image
- note: rush terminal plots use devoutansi now: colored blocks instead of characters, a white canvas, and no legend

```diff
--- 2e
+++ 2.5e
@@ -1,18 +1,18 @@
 $ rush plot --x tip --fill time tips.csv
-             ===
-             ===     ===
-  40         ===     ===
-             ===     ===
-             ===     ===
-  30         ===     ===
-             ===     ===                                                 time
-           =====     ===                                                 Dinner
-  20       ==+++ === =====                                               Lunch
-           ==+++==== =====  ===                                          +
-           ==+++==== =====  ===   ===
-  10       +++++==========  ===   ===
-       ====+++++++++=+++====+++== =====
-       ==+++++++++++++++++==+++++=+++====== ======
-   0   ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-                 2.5              5.0              7.5             10.0
+
+
+  40
+
+
+  30
+c                                                                        time
+o                                                                        Dinner
+u 20                                                                     Lunch
+n
+t
+  10
+
+
+   0
+                2.5              5.0              7.5              10.0
                                      tip
```

## Code block 39: `$ rush plot --x tip --fill time --geom density tips.csv`

- id: `chapter-7-exploring-data.html:block:39`
- hash: `46790193`
- status: **accept**
- cause: image
- note: rush terminal plots use devoutansi now: colored blocks instead of characters, a white canvas, and no legend

```diff
--- 2e
+++ 2.5e
@@ -1,18 +1,18 @@
 $ rush plot --x tip --fill time --geom density tips.csv
-  0.5        @@@
-            @@+@@
-  0.4       @+++@@
-           @@++++@
-           @+++++@@  @@
-  0.3      @++++++@@@@=@@
-          @++++++++@@===@@                                               time
-          @+++++++++@@====@                                              Dinner
-  0.2    @+++++++++++@@@===@@                                            Lunch
-         @+++++++++++++@@@==@@                                           @
-        @++++++++++++++++@@@@@@@
-  0.1  @@+++++++++++++++++++++@@@@@@@
-       ++++++++++++++++++++++++++@++@@@@
-       ++++++++++++++++++++++++++++++++@@@@@@@@@@@
-  0.0  ++++++++++++++++++++++++++++++++++++++++++@@@@@@@@@@@@@@@@@@@@@@
+  0.5
+
+  0.4
+
+
+d 0.3
+e                                                                        time
+n                                                                        Dinner
+s 0.2                                                                    Lunch
+i
+t
+y 0.1
+
+
+  0.0
                  2.5              5.0              7.5              10.0
                                      tip
```

## Code block 41: `$ rush plot --x tip --y bill --color size --size day --geom path tips.`

- id: `chapter-7-exploring-data.html:block:41`
- hash: `6ae2a7bb`
- status: **accept**
- cause: image
- note: rush terminal plots use devoutansi now: colored blocks instead of characters, a white canvas, and no legend

```diff
--- 2e
+++ 2.5e
@@ -1,18 +1,18 @@
 $ rush plot --x tip --y bill --color size --size day --geom path tips.csv
-  50                                           #*               *   #####
-                         #        ==        #***            ****#####
-                 #        ###    =**+    #***          *****####
-  40              #  ##**   ####***+======         *****###
-                   #*# ###******###+#**   ======****###                    day
-        ###################*****##*+*##*****####=#                         Fri
-b 30    #    *+++########**##==****+****#######                            Sat
-i       # #** *##++####**#===*%=====####*##**#                             Sun
-l      #   #  ######***#=####==##########    **                            Thur
-l 20   # #########**#####****#####++
-       ########*########*###### #  *                                       size
-       ######################    ## *                                      5
-  10    ###########      ####      ##*
-       %%##  ##                      #
-       %
+  50
+
+
+  40
+                                                                           day
+                                                                           Fri
+b 30                                                                       Sat
+i                                                                          Sun
+l                                                                          Thur
+l 20
+                                                                           6ize
+                                                                           5
+  10
+
+
                 2.5               5.0               7.5               10.0
                                       tip
```

## Code block 43: `$ rush plot --x bill --y tip --color time tips.csv`

- id: `chapter-7-exploring-data.html:block:43`
- hash: `a3a2b5b7`
- status: **accept**
- cause: image
- note: rush terminal plots use devoutansi now: colored blocks instead of characters, a white canvas, and no legend

```diff
--- 2e
+++ 2.5e
@@ -1,18 +1,18 @@
 $ rush plot --x bill --y tip --color time tips.csv
-  10.0                                                                =
-                                                                   =
+  10.0
 
 
-   7.5                                                 =
-                                  =      =       +                =
-t                                   +     =   =                          time
-i             =                   =   =    ==    +                       Dinner
-p  5.0                         = =   = +     =+   =     =+  +     =      Lunch
-                 =     = =+==+++= =  = +=  +         =
-                   =  += =++= ======== =     =   =             =
-                  == =====+=====+=++     ===   =     ==  =   =
-   2.5        ++=++++=+=+==== ==  ===  = = ==
-              =+ ===+ + == =++        =
-        =   = =      =    =                    =
+
+   7.5
+
+t                                                                        time
+i                                                                        Dinner
+p  5.0                                                                   Lunch
+
+
+
+   2.5
+
+
                  10          20           30           40           50
                                      bill
```

## Code block 45: `$ rush plot --x bill --y tip --color time --geom smooth tips.csv`

- id: `chapter-7-exploring-data.html:block:45`
- hash: `46a6ecc3`
- status: **accept**
- cause: image
- note: rush terminal plots use devoutansi now: colored blocks instead of characters, a white canvas, and no legend

```diff
--- 2e
+++ 2.5e
@@ -1,18 +1,18 @@
 $ rush plot --x bill --y tip --color time --geom smooth tips.csv
-                                                                     ==
-                                                                   ====
-  7.5                                                            ======
-                                                               ========
-                                                     ==================
-                                             =======+++++++++======
-t 5.0                                  ====+++++++++==========           time
-i                                 ====++++++=================            Dinner
-p                           ===+++++++=============                      Lunch
-       ==              ==+++++++=====                                    =
-  2.5  ==============++++====
-       ======++++++++===
-       ==========
-       =====
-  0.0  ==
+
+
+  7.5
+
+
+
+t 5.0                                                                    time
+i                                                                        Dinner
+p                                                                        Lunch
+
+  2.5
+
+
+
+  0.0
                 10           20           30           40           50
                                      bill
```

## Code block 48: `$ rush plot --x 'factor(size)' --y bill --geom boxplot tips.csv`

- id: `chapter-7-exploring-data.html:block:48`
- hash: `053ff9fa`
- status: **accept**
- cause: image
- note: Box plot works again (miniansi 0.1.3); colored blocks instead of characters, like the other terminal plots

```diff
--- 2e
+++ 2.5e
@@ -1,17 +1,17 @@
 $ rush plot --x 'factor(size)' --y bill --geom boxplot tips.csv
-  50                               %
-                                   %           %                        %
-                                   %           %                        %
-  40                   %                       %           %            %
-                                   %       %%%%%%%%%%              %%%%%%%%%%
-                       %           %       %        %              %%%%%%%%%%
-b 30                               %       %        %  %%%%%%%%%%  %%%%%%%%%%
-i                      %      %%%%%%%%%%%  %%%%%%%%%%
-l                      %      %         %  %%%%%%%%%%
-l 20              %%%%%%%%%%  %%%%%%%%%%%      %           %
-                  %%%%%%%%%%  %%%%%%%%%%%
-                  %%%%%%%%%%       %
-  10  %%%%%%%%%%       %
-      %%%%%%%%%%
+  50
+
+
+  40
+
+
+b 30
+i
+l
+l 20
+
+
+  10
+
 
           1            2           3           4           5           6
```

## Code block 50: `$ rush plot --x 'factor(size)' --y bill --geom violin --title 'Distrib`

- id: `chapter-7-exploring-data.html:block:50`
- hash: `ff961e1c`
- status: **accept**
- cause: image
- note: rush terminal plots use devoutansi now: colored blocks instead of characters, a white canvas, and no legend

```diff
--- 2e
+++ 2.5e
@@ -2,18 +2,18 @@
 ill amount per party size' --xlab 'Party size' --ylab 'Bill (USD)' tips.csv
    Distribution of bill amount per party size
-  50                               %
-                                   %           %%                      %%
-                                   %           %%                      %%
-  40                   %           %          %%%        %%%%%%        %%
-B                      %           %          % %          %          %%%%
-i                      %          %%%         % %     %%%%%%%%%%%%    %  %%
-l 30                  %%          % %         % %%    %%%%% %%%%%%    %%%%%
-l                     %%%         % %         %  %         %%
-                     %% %        %% %%        %  %       %%%%%%
-( 20                %%  %%       %   %        %%%%
-U                   %    %%      %% %%
-S 10 %%%%%%%%%%%%   %%% %%        %%%
-D    %%%%%  %%%%%     %%%
-)       %%%%%%
+  50
+
+
+  40
+B
+i
+l 30
+l
+
+( 20
+U
+S 10
+D
+)
           1            2           3           4           5           6
                                     Party size
```

## Prose (replace): Writes out the shebang ( #!; see Chapter 4) needed for running an R sc

- id: `chapter-7-exploring-data.html:prose:aca50bd1`
- hash: `c7999c9a`
- status: **accept**
- cause: content
- note: Content pass: generated scripts run with ir and list their packages

```diff
--- 2e
+++ 2.5e
@@ -1 +1,2 @@
-Writes out the shebang ( #!; see Chapter 4) needed for running an R script from the command line.
+Writes out the shebang ( #!; see Chapter 4) needed for running the script from the command line with ir [^].
+Lists the packages that the script needs, so that ir can prepare them the first time you run it.
```

## Prose (replace): Runs the specified expression.

- id: `chapter-7-exploring-data.html:prose:cffe4724`
- hash: `0c561f4b`
- status: **accept**
- cause: content
- note: Content pass: generated scripts assign `result` and write it with rush::write()

```diff
--- 2e
+++ 2.5e
@@ -1,2 +1,2 @@
-Runs the specified expression.
-Prints the result to standard output.
+Runs the specified expression and assigns its result to result.
+Writes the result to standard output.
```

## Prose (replace): Under the hood, rush plot uses the function qplot from the ggplot2 pac

- id: `chapter-7-exploring-data.html:prose:af94394d`
- hash: `e609be3d`
- status: **accept**
- cause: content
- note: Content pass: rush plot builds a ggplot2 plot; qplot is deprecated

```diff
--- 2e
+++ 2.5e
@@ -1,2 +1,2 @@
-Under the hood, rush plot uses the function qplot from the ggplot2 package. Here’s the first part of its documentation:
-I agree with this advice; once you’re done reading this book, it’ll be worthwhile to learn ggplot2, especially if you want to upgrade any exploratory data visualizations into ones that are suitable for communication. For now, while we’re at the command line, let’s take that shortcut.
+Under the hood, rush plot constructs a ggplot2 plot: options such as --x, --y, and --color become aesthetics, and --geom becomes the geometry. With the --dry-run (or -n) option you can see the code that it generates; here I only show the line that creates the plot:
+Once you’re done reading this book, it’ll be worthwhile to learn ggplot2, especially if you want to upgrade any exploratory data visualizations into ones that are suitable for communication. The code that rush plot -n generates is a good starting point. For now, while we’re at the command line, let’s take the shortcut.
```

## 12 old anchor(s) missing

- id: `chapter-7-exploring-data.html:anchors-missing`
- hash: `af4e6f7c`
- status: **accept**
- cause: conversion
- note: Figure anchors are #fig-x instead of #fig:x (Quarto cross-references); section anchors are unchanged

```diff
fig:plot-accident-image
fig:plot-bar-image
fig:plot-boxplot-image
fig:plot-demo
fig:plot-density-image
fig:plot-histogram-image
fig:plot-labels-image
fig:plot-scatter-image
fig:plot-trend-image
fig:plot-trend-points-image
fig:screenshot-display-ansi-and-inline
fig:screenshot-display-preview-and-browser

(new-only: fig-plot-accident-image, fig-plot-accident-image-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-plot-bar-image, fig-plot-bar-image-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-plot-boxplot-image, fig-plot-boxplot-image-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-plot-demo, fig-plot-demo-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-plot-density-image, fig-plot-density-image-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-plot-histogram-image, fig-plot-histogram-image-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-plot-labels-image, fig-plot-labels-image-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-plot-scatter-image, fig-plot-scatter-image-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-plot-trend-image, fig-plot-trend-image-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-plot-trend-points-image, fig-plot-trend-points-image-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-screenshot-display-ansi-and-inline, fig-screenshot-display-ansi-and-inline-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-screenshot-display-preview-and-browser, fig-screenshot-display-preview-and-browser-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fn1, fn2, fn3, fn4, fn5, fn6, fnref1, fnref2, fnref3, fnref4, fnref5, fnref6, footnotes, title-block-header)
```

## External links differ

- id: `chapter-7-exploring-data.html:external-links`
- hash: `33ab767b`
- status: **accept**
- cause: conversion
- note: bookdown linked R function names in inline code to rdrr.io; Quarto does not (no R code is run)

```diff
--- 2e
+++ 2.5e
@@ -4 +3,0 @@
-https://rdrr.io/r/base/factor.html
```

## Footnotes differ (5 vs 6)

- id: `chapter-7-exploring-data.html:footnotes`
- hash: `01bb1b2d`
- status: **accept**
- cause: conversion
- note: Citations show the versions and years of the tools in the current image (content pass, tools.bib)

```diff
--- 2e
+++ 2.5e
@@ -1,4 +1,5 @@
-Mark Nudelman, less – Opposite of more, version 551, 2019, https://www.greenwoodsoftware.com/less.
-Groskopf, csvstat – Print Descriptive Statistics for Each Column in a CSV File.
-Janssens, rush – R One-Liners from the Shell.
-The R Foundation for Statistical Computing, R – a Language and Environment for Statistical Computing.
+Mark Nudelman, less – Opposite of more, version 668, 2024, https://www.greenwoodsoftware.com/less.
+Christopher Groskopf, csvstat – Print Descriptive Statistics for Each Column in a CSV File, version 1.1.0, 2023, https://csvkit.rtfd.org.
+Jeroen Janssens, rush – R One-Liners from the Shell, version 0.2.1.9000, 2026, https://github.com/jeroenjanssens/rush.
+The R Foundation for Statistical Computing, R – a Language and Environment for Statistical Computing, version 4.5.2, 2025, https://www.r-project.org.
+Tomasz Kalinowski, ir – Run Standalone R Scripts from Embedded Dependency Metadata, version 0.4.1, 2026, https://github.com/r-lib/ir.
```

## Image changed: images/plot-accident.png

- id: `chapter-7-exploring-data.html:image:images/plot-accident.png`
- hash: `c4db9308`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html

```diff
images/plot-accident.png: 166958 -> 159168 bytes
```

## Image changed: images/plot-bar.png

- id: `chapter-7-exploring-data.html:image:images/plot-bar.png`
- hash: `9b693966`
- status: **accept**
- cause: image
- note: Regenerated with the new image (ggplot2 4); same bar chart

```diff
images/plot-bar.png: 22375 -> 22514 bytes
```

## Image changed: images/plot-boxplot.png

- id: `chapter-7-exploring-data.html:image:images/plot-boxplot.png`
- hash: `30c76217`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html

```diff
images/plot-boxplot.png: 30168 -> 34855 bytes
```

## Image changed: images/plot-density.png

- id: `chapter-7-exploring-data.html:image:images/plot-density.png`
- hash: `a9b07e7e`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html

```diff
images/plot-density.png: 73683 -> 76902 bytes
```

## Image changed: images/plot-histogram.png

- id: `chapter-7-exploring-data.html:image:images/plot-histogram.png`
- hash: `262276a1`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html

```diff
images/plot-histogram.png: 25820 -> 31859 bytes
```

## Image changed: images/plot-labels.png

- id: `chapter-7-exploring-data.html:image:images/plot-labels.png`
- hash: `6633a019`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html

```diff
images/plot-labels.png: 69014 -> 98618 bytes
```

## Image changed: images/plot-scatter.png

- id: `chapter-7-exploring-data.html:image:images/plot-scatter.png`
- hash: `4480ff3e`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html

```diff
images/plot-scatter.png: 99677 -> 96587 bytes
```

## Image changed: images/plot-trend-points.png

- id: `chapter-7-exploring-data.html:image:images/plot-trend-points.png`
- hash: `5e67c765`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html

```diff
images/plot-trend-points.png: 122525 -> 131543 bytes
```

## Image changed: images/plot-trend.png

- id: `chapter-7-exploring-data.html:image:images/plot-trend.png`
- hash: `c919e0f1`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html

```diff
images/plot-trend.png: 62512 -> 76415 bytes
```

## Image changed: images/tips.png

- id: `chapter-7-exploring-data.html:image:images/tips.png`
- hash: `81bdbe0a`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html

```diff
images/tips.png: 120669 -> 117297 bytes
```

