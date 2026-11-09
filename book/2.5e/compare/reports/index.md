# index.html

Image: `datasciencetoolbox/dsatcl2e@sha256:9cd9b96f9e1b3a286a103fef60b0c6129cae316735486f496571ddd1293ad4e1`

## Prose (insert): Data Science at the Command Line, 2e

- id: `index.html:prose:68cbdac3`
- hash: `96704b11`
- status: **accept**
- cause: conversion
- note: Quarto title block shows title and subtitle (bs4_book showed them as hand-written divs)

```diff
--- 2e
+++ 2.5e
@@ -0,0 +1,2 @@
+Data Science at the Command Line, 2e
+Obtain, Scrub, Explore, and Model Data with Unix Power Tools
```

## Prose (replace): Want to learn from Jeroen in person? Through his company, Data Science

- id: `index.html:prose:e30a535c`
- hash: `346d5d1a`
- status: **accept**
- cause: content
- note: Decision 5 and content pass: remove the course announcement and the Data Science Workshops paragraph; new paragraph that explains edition 2.5, with the date of the last update (compare.py replaces the date with DATE)

```diff
--- 2e
+++ 2.5e
@@ -1,2 +1 @@
-Want to learn from Jeroen in person? Through his company, Data Science Workshops, Jeroen provides in-company training about data science at the command line and related topics such as Python, R, and machine learning. Visit Data Science Workshops for more information.
-Jeroen is currently working on a new course Embrace the Command Line. If you haven’t fully embraced the command line yet, then this course might be for you. The beta cohort is expected to start in Q1 2021. You can learn more about this course and tell Jeroen what you think here.
+This website is edition 2.5 and was last updated on DATE. The text is that of the second edition, with small updates where tools or websites have changed since 2021. All the code has been run again with the current version of the Docker image, so the output you see here is the output you get when you follow along today. The website is now made with Quarto and quarto-term instead of bookdown. The printed book shows the output of the original Docker image, which is still available as datasciencetoolbox/dsatcl2e:20210628.
```

## Prose (replace): Jeroen Janssens is an independent data science consultant and instruct

- id: `index.html:prose:d81a8dfa`
- hash: `ec2ab285`
- status: **accept**
- cause: intended
- note: Current bio and profiles from https://jeroenjanssens.com/about/, plus a link to jeroenjanssens.com

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Jeroen Janssens is an independent data science consultant and instructor. He enjoys visualizing data, implementing machine learning models, and building solutions using Python, R, JavaScript, and Bash. Jeroen manages Data Science Workshops, a training and coaching firm that organizes open enrollment workshops, in-company courses, inspiration sessions, hackathons, and meetups. Previously, he was an assistant professor at Jheronimus Academy of Data Science and a data scientist at Elsevier in Amsterdam and various startups in New York City. Jeroen holds a PhD in machine learning from Tilburg University and an MSc in artificial intelligence from Maastricht University. He lives with his wife and two kids in Rotterdam, the Netherlands. You can find Jeroen on Twitter, GitHub, and LinkedIn.
+Jeroen Janssens, PhD, is Head of Developer Relations at Posit, PBC. His expertise lies in visualizing data, implementing machine learning models, and building solutions using Python, R, JavaScript, and Bash. He’s passionate about open source and sharing knowledge. He’s the author of Python Polars: The Definitive Guide (O’Reilly, 2025) and Data Science at the Command Line (O’Reilly, 2021). Jeroen holds a PhD in machine learning from Tilburg University and an MSc in artificial intelligence from Maastricht University. He lives with his wife and two kids in Rotterdam, the Netherlands. You can find Jeroen at jeroenjanssens.com and on Bluesky, Mastodon, LinkedIn, and GitHub.
```

## External links differ

- id: `index.html:external-links`
- hash: `c3dd0142`
- status: **accept**
- cause: intended
- note: Content pass: Data Science Workshops paragraph removed; current bio and profiles; links to jeroenjanssens.com, Quarto, and quarto-term

```diff
--- 2e
+++ 2.5e
@@ -0,0 +1,2 @@
+https://jeroenjanssens.com
+https://jeroenjanssens.com
@@ -3 +5,2 @@
-https://datascienceworkshops.com
+https://quarto.org
+https://quarto-term.jeroenjanssens.com
@@ -7,2 +10,4 @@
-https://datascienceworkshops.com
-https://twitter.com/jeroenhjanssens
+https://jeroenjanssens.com
+https://bsky.app/profile/jeroenjanssens.com
+https://fosstodon.org/@jeroenjanssens
+https://www.linkedin.com/in/jeroenjanssens
@@ -10 +14,0 @@
-https://www.linkedin.com/in/jeroenjanssens/
```

