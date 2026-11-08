# chapter-9-modeling-data.html

Image: `datasciencetoolbox/dsatcl2e@sha256:470005890402401f1d3c84f8ebb5afceaf53e7c57af54f8fb06709a2727f0560`

## Code block 0: `$ cd /data/ch09`

- id: `chapter-9-modeling-data.html:block:0`
- hash: `7cd143b0`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -3,3 +3,3 @@
 $ l
 total 4.0K
--rw-r--r-- 1 dst dst 503 Dec 14 11:57 classify.cfg
+-rw-r--r-- 1 dst dst 503 Nov  8 14:57 classify.cfg
```

## Code block 10: `$ xsv select '!type' wine-scaled.csv | ➊`

- id: `chapter-9-modeling-data.html:block:10`
- hash: `4a8295f0`
- status: **accept**
- cause: image
- note: tapkee 1.4 PCA: signs of the components are flipped

```diff
--- 2e
+++ 2.5e
@@ -3,13 +3,13 @@
 > tapkee --method pca | ➌
 > tee wine-pca.txt | trim
--0.568882,3.34818
--1.19724,3.22835
--0.952507,3.23722
--1.60046,1.67243
--0.568882,3.34818
--0.556231,3.15199
--0.53894,2.28288
-1.104,2.56479
-0.231315,2.86763
--1.18363,1.81641
+0.568882,-3.34818
+1.19724,-3.22835
+0.952507,-3.23722
+1.60046,-1.67243
+0.568882,-3.34818
+0.556231,-3.15199
+0.53894,-2.28288
+-1.104,-2.56479
+-0.231315,-2.86763
+1.18363,-1.81641
 … with 6487 more lines
```

## Code block 11: `$ < wine-pca.txt header -a pc1,pc2 | ➊`

- id: `chapter-9-modeling-data.html:block:11`
- hash: `c5d49030`
- status: **accept**
- cause: image
- note: tapkee 1.4 PCA: signs of the components are flipped

```diff
--- 2e
+++ 2.5e
@@ -2,13 +2,13 @@
 > paste -d, - <(xsv select type wine-scaled.csv) | ➋
 > tee wine-pca.csv | csvlook
-│      pc1 │     pc2 │ type  │
-├──────────┼─────────┼───────┤
-│  -0.569… │  3.348… │ red   │
-│  -1.197… │  3.228… │ red   │
-│  -0.953… │  3.237… │ red   │
-│  -1.600… │  1.672… │ red   │
-│  -0.569… │  3.348… │ red   │
-│  -0.556… │  3.152… │ red   │
-│  -0.539… │  2.283… │ red   │
-│   1.104… │  2.565… │ red   │
+│     pc1 │     pc2 │ type  │
+├─────────┼─────────┼───────┤
+│  0.569… │ -3.348… │ red   │
+│  1.197… │ -3.228… │ red   │
+│  0.953… │ -3.237… │ red   │
+│  1.600… │ -1.672… │ red   │
+│  0.569… │ -3.348… │ red   │
+│  0.556… │ -3.152… │ red   │
+│  0.539… │ -2.283… │ red   │
+│ -1.104… │ -2.565… │ red   │
 … with 6489 more lines
```

## Code block 18: `$ vw \`

- id: `chapter-9-modeling-data.html:block:18`
- hash: `e7bbf22f`
- status: **accept**
- cause: image
- note: vw 9 log format (wider columns, wrapped)

```diff
--- 2e
+++ 2.5e
@@ -9,8 +9,11 @@
 > --bit_precision 25 ➑
 creating quadratic features for pairs: ::
-WARNING: any duplicate namespace interactions will be removed
+[info] Any duplicate namespace interactions will be removed
 You can use --leave_duplicate_interactions to disable this behaviour.
 using l2 regularization = 5e-06
 final_regressor = wine.model
+creating cache_file = wine.cache
+Reading datafile = wine-train.vw
+num sources = 1
 Num weight bits = 25
 learning rate = 0.5
@@ -18,26 +21,43 @@
 power_t = 0.5
 decay_learning_rate = 1
-creating cache_file = wine.cache
-Reading datafile = wine-train.vw
-num sources = 1
-Enabled reductions: gd, generate_interactions, nn, scorer
-average  since         example        example  current  current  current
-loss     last          counter         weight    label  predict features
-25.000000 25.000000            1            1.0   5.0000   0.0000       78
-21.514251 18.028502            2            2.0   5.0000   0.7540       78
-23.981016 26.447781            4            4.0   6.0000   1.5814       78
-21.543597 19.106179            8            8.0   7.0000   2.1586       78
-16.715053 11.886508           16           16.0   7.0000   2.8977       78
-12.412012 8.108970           32           32.0   6.0000   3.8832       78
-7.698827 2.985642           64           64.0   8.0000   4.8759       78
-4.547053 1.395279          128          128.0   7.0000   5.7022       78
-2.780491 1.013930          256          256.0   6.0000   5.9425       78
-1.797196 0.813900          512          512.0   7.0000   5.9101       78
-1.292476 0.787756         1024         1024.0   4.0000   5.8295       78
-1.026469 0.760462         2048         2048.0   6.0000   5.9139       78
-0.945076 0.945076         4096         4096.0   6.0000   6.1987       78 h
-0.792362 0.639647         8192         8192.0   6.0000   6.2091       78 h
-0.690935 0.589508        16384        16384.0   5.0000   5.5898       78 h
-0.643649 0.596364        32768        32768.0   6.0000   6.1262       78 h
+Enabled learners: gd, generate_interactions, nn, scorer-identity, count_label
+Input label = SIMPLE
+Output pred = SCALAR
+average  since         example        example        current        current  cur
+rent
+loss     last          counter         weight          label        predict feat
+ures
+36.00000 36.00000            1            1.0         6.0000         0.0000
+  78
+26.36875 16.73750            2            2.0         5.0000         0.9089
+  78
+26.33121 26.29366            4            4.0         8.0000         2.7863
+  78
+14.25945 2.187690            8            8.0         5.0000         4.4370
+  78
+8.053075 1.846701           16           16.0         6.0000         5.3988
+  78
+4.592783 1.132491           32           32.0         5.0000         5.4773
+  78
+2.699648 0.806514           64           64.0         6.0000         5.8974
+  78
+1.735030 0.770412          128          128.0         6.0000         6.0172
+  78
+1.205671 0.676313          256          256.0         6.0000         5.9917
+  78
+0.991043 0.776414          512          512.0         7.0000         5.9030
+  78
+0.912304 0.833566         1024         1024.0         7.0000         5.8460
+  78
+0.817383 0.722461         2048         2048.0         5.0000         6.0205
+  78
+0.760264 0.760264         4096         4096.0         7.0000         6.0232
+  78 h
+0.690877 0.621490         8192         8192.0         6.0000         6.0882
+  78 h
+0.664164 0.637452        16384        16384.0         6.0000         5.7553
+  78 h
+0.625118 0.586072        32768        32768.0         6.0000         5.6979
+  78 h
 
 finished run
@@ -45,6 +65,6 @@
 passes used = 10
 weighted example sum = 35270.000000
-weighted label sum = 206890.000000
-average loss = 0.585270 h
-best constant = 5.865891
+weighted label sum = 207590.000000
+average loss = 0.585933 h
+best constant = 5.885738
 total feature number = 2749380
```

## Code block 19: `$ vw \`

- id: `chapter-9-modeling-data.html:block:19`
- hash: `4b40ede1`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -7,13 +7,13 @@
 
 $ bat predictions | trim
-6.702528
-6.537283
-5.633761
-6.569905
-5.934127
-5.485150
-5.768181
-6.452881
-4.978302
-5.834136
+5.985150
+6.351532
+5.904746
+5.692382
+6.260514
+5.866639
+6.002824
+5.827528
+6.496091
+5.590842
 … with 970 more lines
```

## Code block 20: `$ paste -d, predictions <(cut -d '|' -f 1 wine-test.vw) |`

- id: `chapter-9-modeling-data.html:block:20`
- hash: `c90a5d7d`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -4,5 +4,5 @@
 > cowsay ➊
  _______________
-< MAE: 0.586385 >
+< MAE: 0.609382 >
  ---------------
         \   ^__^
```

## Code block 22: `$ vw -d wine-train.vw -f wine2.model --quiet ➊`

- id: `chapter-9-modeling-data.html:block:22`
- hash: `f22b758c`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -5,3 +5,3 @@
 $ paste -d, predictions <(cut -d '|' -f 1 wine-test.vw) | ➌
 > awk -F, '{E+=sqrt(($1-$2)^2)} END {print "MAE: " E/NR}'
-MAE: 0.61905
+MAE: 0.651769
```

## Code block 24: `$ NUM_RED="$(< wine-red-clean.csv wc -l)" ➊`

- id: `chapter-9-modeling-data.html:block:24`
- hash: `b36188ea`
- status: **accept**
- cause: random
- note: Random shuffle

```diff
--- 2e
+++ 2.5e
@@ -10,11 +10,11 @@
 │    id │ type  │ fixed_acidity │ volatile_acidity │ citric_acid │ residual_sug…
 ├───────┼───────┼───────────────┼──────────────────┼─────────────┼─────────────…
-│     1 │ white │          7.30 │            0.300 │        0.42 │           7.…
-│     2 │ white │          6.90 │            0.210 │        0.81 │           1.…
-│     3 │ red   │          7.80 │            0.760 │        0.04 │           2.…
-│     4 │ red   │          7.90 │            0.300 │        0.68 │           8.…
-│     5 │ red   │          8.80 │            0.470 │        0.49 │           2.…
-│     6 │ white │          6.40 │            0.150 │        0.29 │           1.…
-│     7 │ white │          7.80 │            0.210 │        0.34 │          11.…
-│     8 │ white │          7.00 │            0.130 │        0.37 │          12.…
+│     1 │ white │          6.70 │            0.180 │        0.30 │           6.…
+│     2 │ red   │          9.30 │            0.390 │        0.40 │           2.…
+│     3 │ red   │          7.70 │            0.690 │        0.22 │           1.…
+│     4 │ red   │          6.60 │            0.520 │        0.04 │           2.…
+│     5 │ red   │          7.40 │            0.350 │        0.33 │           2.…
+│     6 │ red   │          9.70 │            0.530 │        0.60 │           2.…
+│     7 │ white │          6.10 │            0.280 │        0.25 │          17.…
+│     8 │ white │          5.80 │            0.300 │        0.27 │           1.…
 … with 3190 more lines
```

## Code block 28: `$ ls -1 output`

- id: `chapter-9-modeling-data.html:block:28`
- hash: `f874eb22`
- status: **accept**
- cause: image
- note: skll 5 output file names (wine_ instead of wine_features_); prose may need an update

```diff
--- 2e
+++ 2.5e
@@ -1,23 +1,23 @@
 $ ls -1 output
-wine_features_DecisionTreeClassifier.log
-wine_features_DecisionTreeClassifier.model
-wine_features_DecisionTreeClassifier_predictions.tsv
-wine_features_DecisionTreeClassifier.results
-wine_features_DecisionTreeClassifier.results.json
-wine_features_KNeighborsClassifier.log
-wine_features_KNeighborsClassifier.model
-wine_features_KNeighborsClassifier_predictions.tsv
-wine_features_KNeighborsClassifier.results
-wine_features_KNeighborsClassifier.results.json
-wine_features_LogisticRegression.log
-wine_features_LogisticRegression.model
-wine_features_LogisticRegression_predictions.tsv
-wine_features_LogisticRegression.results
-wine_features_LogisticRegression.results.json
-wine_features_RandomForestClassifier.log
-wine_features_RandomForestClassifier.model
-wine_features_RandomForestClassifier_predictions.tsv
-wine_features_RandomForestClassifier.results
-wine_features_RandomForestClassifier.results.json
 wine.log
+wine_DecisionTreeClassifier.log
+wine_DecisionTreeClassifier.model
+wine_DecisionTreeClassifier.results
+wine_DecisionTreeClassifier.results.json
+wine_DecisionTreeClassifier_predictions.tsv
+wine_KNeighborsClassifier.log
+wine_KNeighborsClassifier.model
+wine_KNeighborsClassifier.results
+wine_KNeighborsClassifier.results.json
+wine_KNeighborsClassifier_predictions.tsv
+wine_LogisticRegression.log
+wine_LogisticRegression.model
+wine_LogisticRegression.results
+wine_LogisticRegression.results.json
+wine_LogisticRegression_predictions.tsv
+wine_RandomForestClassifier.log
+wine_RandomForestClassifier.model
+wine_RandomForestClassifier.results
+wine_RandomForestClassifier.results.json
+wine_RandomForestClassifier_predictions.tsv
 wine_summary.tsv
```

## Code block 29: `$ < output/wine_summary.tsv csvsql --query "SELECT learner_name, accur`

- id: `chapter-9-modeling-data.html:block:29`
- hash: `c33948a1`
- status: **accept**
- cause: random
- note: Model accuracies (random train/test split, newer scikit-learn)

```diff
--- 2e
+++ 2.5e
@@ -3,6 +3,6 @@
 │ learner_name           │ accuracy  │
 ├────────────────────────┼───────────┤
-│ RandomForestClassifier │ 0.9921875 │
-│ LogisticRegression     │ 0.990625  │
-│ KNeighborsClassifier   │ 0.9890625 │
-│ DecisionTreeClassifier │ 0.984375  │
+│ RandomForestClassifier │ 0.990625  │
+│ LogisticRegression     │ 0.9890625 │
+│ KNeighborsClassifier   │ 0.9796875 │
+│ DecisionTreeClassifier │ 0.975     │
```

## Code block 30: `$ jq -r '.[] | "\(.learner_name):\n\(.result_table)\n"' output/*.json`

- id: `chapter-9-modeling-data.html:block:30`
- hash: `253c1b8e`
- status: **accept**
- cause: time
- note: Timestamps, dates, sizes, or durations of this render

```diff
--- 2e
+++ 2.5e
@@ -4,7 +4,7 @@
 |       |   red |   white |   Precision |   Recall |   F-measure |
 +=======+=======+=========+=============+==========+=============+
-|   red | [313] |       7 |       0.991 |    0.978 |       0.984 |
+|   red | [300] |       8 |       0.974 |    0.974 |       0.974 |
 +-------+-------+---------+-------------+----------+-------------+
-| white |     3 |   [317] |       0.978 |    0.991 |       0.984 |
+| white |     8 |   [324] |       0.976 |    0.976 |       0.976 |
 +-------+-------+---------+-------------+----------+-------------+
 (row = reference; column = predicted)
@@ -14,7 +14,7 @@
 |       |   red |   white |   Precision |   Recall |   F-measure |
 +=======+=======+=========+=============+==========+=============+
-|   red | [314] |       6 |       0.997 |    0.981 |       0.989 |
+|   red | [302] |       6 |       0.977 |    0.981 |       0.979 |
 +-------+-------+---------+-------------+----------+-------------+
-| white |     1 |   [319] |       0.982 |    0.997 |       0.989 |
+| white |     7 |   [325] |       0.982 |    0.979 |       0.980 |
 +-------+-------+---------+-------------+----------+-------------+
 (row = reference; column = predicted)
@@ -24,7 +24,7 @@
 |       |   red |   white |   Precision |   Recall |   F-measure |
 +=======+=======+=========+=============+==========+=============+
-|   red | [315] |       5 |       0.997 |    0.984 |       0.991 |
+|   red | [304] |       4 |       0.990 |    0.987 |       0.989 |
 +-------+-------+---------+-------------+----------+-------------+
-| white |     1 |   [319] |       0.985 |    0.997 |       0.991 |
+| white |     3 |   [329] |       0.988 |    0.991 |       0.989 |
 +-------+-------+---------+-------------+----------+-------------+
 (row = reference; column = predicted)
@@ -34,7 +34,7 @@
 |       |   red |   white |   Precision |   Recall |   F-measure |
 +=======+=======+=========+=============+==========+=============+
-|   red | [315] |       5 |       1.000 |    0.984 |       0.992 |
+|   red | [302] |       6 |       1.000 |    0.981 |       0.990 |
 +-------+-------+---------+-------------+----------+-------------+
-| white |     0 |   [320] |       0.985 |    1.000 |       0.992 |
+| white |     0 |   [332] |       0.982 |    1.000 |       0.991 |
 +-------+-------+---------+-------------+----------+-------------+
 (row = reference; column = predicted)
```

## 3 old anchor(s) missing

- id: `chapter-9-modeling-data.html:anchors-missing`
- hash: `454312f5`
- status: **accept**
- cause: conversion
- note: Figure anchors are #fig-x instead of #fig:x (Quarto cross-references); section anchors are unchanged

```diff
fig:unnamed-chunk-10
fig:unnamed-chunk-12
fig:unnamed-chunk-20

(new-only: fig-plot-wine-alchohol-vs-quality, fig-plot-wine-alchohol-vs-quality-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-plot-wine-quality, fig-plot-wine-quality-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-wine-pca, fig-wine-pca-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-wine-regression, fig-wine-regression-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fig-wine-tsne, fig-wine-tsne-caption-0ceaefa1-69ba-4598-a22c-09a6ac19f8ca, fn1, fn10, fn2, fn3, fn4, fn5, fn6, fn7, fn8, fn9, fnref1, fnref10, fnref2, fnref3, fnref4, fnref5, fnref6, fnref7, fnref8, fnref9, footnotes, title-block-header)
```

## External links differ

- id: `chapter-9-modeling-data.html:external-links`
- hash: `c45f50f3`
- status: **accept**
- cause: conversion
- note: bookdown linked R function names in inline code to rdrr.io; Quarto does not (no R code is run)

```diff
--- 2e
+++ 2.5e
@@ -3,2 +2,0 @@
-https://rdrr.io/r/base/scale.html
-https://rdrr.io/r/base/scale.html
```

## Figures differ

- id: `chapter-9-modeling-data.html:figures`
- hash: `6a2e93fe`
- status: **accept**
- cause: conversion
- note: All five figures are numbered now; in 2e the two with an underscore in their label were not recognized (raw "(#fig:...)" caption) and the others were 9.1-9.3

```diff
--- 2e
+++ 2.5e
@@ -1,5 +1,5 @@
-(#fig:plot_wine_quality)Comparing the quality of red and white wines using a density plot
-(#fig:plot_wine_alchohol_vs_quality)Relationship between the alcohol contents of wine and its quality
-Figure 9.1: Linear dimensionality reduction with PCA
-Figure 9.2: Non-linear dimensionality reduction with t-SNE
-Figure 9.3: Regression with Vowpal Wabbit
+Figure 9.1: Comparing the quality of red and white wines using a density plot
+Figure 9.2: Relationship between the alcohol contents of wine and its quality
+Figure 9.3: Linear dimensionality reduction with PCA
+Figure 9.4: Non-linear dimensionality reduction with t-SNE
+Figure 9.5: Regression with Vowpal Wabbit
```

## Image changed: images/wine-alcohol-vs-quality.png

- id: `chapter-9-modeling-data.html:image:images/wine-alcohol-vs-quality.png`
- hash: `a4063ae6`
- status: **accept**
- cause: image
- note: Regenerated with the new image (ggplot2 4, mgcv GAM smoother); same curves

```diff
images/wine-alcohol-vs-quality.png: 78014 -> 93476 bytes
```

## Image changed: images/wine-pca.png

- id: `chapter-9-modeling-data.html:image:images/wine-pca.png`
- hash: `bd280931`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html; PCA components have flipped signs (tapkee 1.4)

```diff
images/wine-pca.png: 48891 -> 126028 bytes
```

## Image changed: images/wine-quality.png

- id: `chapter-9-modeling-data.html:image:images/wine-quality.png`
- hash: `c3c2961d`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html

```diff
images/wine-quality.png: 103752 -> 102062 bytes
```

## Image changed: images/wine-regression.png

- id: `chapter-9-modeling-data.html:image:images/wine-regression.png`
- hash: `a9b838a8`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html

```diff
images/wine-regression.png: 91514 -> 196141 bytes
```

## Image changed: images/wine-tsne.png

- id: `chapter-9-modeling-data.html:image:images/wine-tsne.png`
- hash: `e5191443`
- status: **accept**
- cause: image
- note: Regenerated with the new image (R 4.5, ggplot2 4, tapkee 1.4); reviewed in compare/reports/images.html

```diff
images/wine-tsne.png: 97096 -> 375769 bytes
```

