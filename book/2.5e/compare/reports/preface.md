# preface.html

Image: `datasciencetoolbox/dsatcl2e@sha256:ac2e2f4327e2873ff504d7e72cc8f1fa8abb9701698a123b2539ad3157ce9302`

## Prose (insert): Since this book was published, the Docker image has been updated to a 

- id: `preface.html:prose:e4f2956c`
- hash: `beac290f`
- status: **accept**
- cause: content
- note: Content pass: note about the updated Docker image and the :20210628 tag

```diff
--- 2e
+++ 2.5e
@@ -0,0 +1 @@
+Since this book was published, the Docker image has been updated to a newer version of Ubuntu and newer versions of the command-line tools. It also runs natively on ARM-based computers, such as Macs with Apple Silicon. All the commands in this book still work, but some output may look slightly different, for example version numbers, help texts, and the order of files. This website shows the output of the current image. If you want the exact environment that was used for the printed book, run docker pull datasciencetoolbox/dsatcl2e:20210628 and use that tag in all docker run commands.
```

