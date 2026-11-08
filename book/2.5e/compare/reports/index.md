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

## Prose (delete): Want to learn from Jeroen in person? Through his company, Data Science

- id: `index.html:prose:0fdb7efa`
- hash: `5189b6f4`
- status: **accept**
- cause: content
- note: Decision 5 and content pass: remove the course announcement and the Data Science Workshops paragraph

```diff
--- 2e
+++ 2.5e
@@ -1,2 +0,0 @@
-Want to learn from Jeroen in person? Through his company, Data Science Workshops, Jeroen provides in-company training about data science at the command line and related topics such as Python, R, and machine learning. Visit Data Science Workshops for more information.
-Jeroen is currently working on a new course Embrace the Command Line. If you haven’t fully embraced the command line yet, then this course might be for you. The beta cohort is expected to start in Q1 2021. You can learn more about this course and tell Jeroen what you think here.
```

## Prose (replace): Jeroen Janssens is an independent data science consultant and instruct

- id: `index.html:prose:fed28160`
- hash: `e30d34ea`
- status: **accept**
- cause: intended
- note: Current bio and profiles from https://jeroenjanssens.com/about/

```diff
--- 2e
+++ 2.5e
@@ -1 +1 @@
-Jeroen Janssens is an independent data science consultant and instructor. He enjoys visualizing data, implementing machine learning models, and building solutions using Python, R, JavaScript, and Bash. Jeroen manages Data Science Workshops, a training and coaching firm that organizes open enrollment workshops, in-company courses, inspiration sessions, hackathons, and meetups. Previously, he was an assistant professor at Jheronimus Academy of Data Science and a data scientist at Elsevier in Amsterdam and various startups in New York City. Jeroen holds a PhD in machine learning from Tilburg University and an MSc in artificial intelligence from Maastricht University. He lives with his wife and two kids in Rotterdam, the Netherlands. You can find Jeroen on Twitter, GitHub, and LinkedIn.
+Jeroen Janssens, PhD, is Head of Developer Relations at Posit, PBC. His expertise lies in visualizing data, implementing machine learning models, and building solutions using Python, R, JavaScript, and Bash. He’s passionate about open source and sharing knowledge. He’s the author of Python Polars: The Definitive Guide (O’Reilly, 2025) and Data Science at the Command Line (O’Reilly, 2021). Jeroen holds a PhD in machine learning from Tilburg University and an MSc in artificial intelligence from Maastricht University. He lives with his wife and two kids in Rotterdam, the Netherlands. You can find Jeroen on Bluesky, Mastodon, LinkedIn, and GitHub.
```

## External links differ

- id: `index.html:external-links`
- hash: `37acfb3d`
- status: **accept**
- cause: intended
- note: Content pass: Data Science Workshops paragraph removed; current bio and profiles

```diff
--- 2e
+++ 2.5e
@@ -3 +2,0 @@
-https://datascienceworkshops.com
@@ -7,2 +6,3 @@
-https://datascienceworkshops.com
-https://twitter.com/jeroenhjanssens
+https://bsky.app/profile/jeroenjanssens.com
+https://fosstodon.org/@jeroenjanssens
+https://www.linkedin.com/in/jeroenjanssens
@@ -10 +9,0 @@
-https://www.linkedin.com/in/jeroenjanssens/
```

