#!/usr/bin/env python3
from yaml import safe_load
from sys import stdout, stderr


def combine(items):
    if len(items) <= 2:
        return " and ".join(items)
    else:
        return ", ".join(items[:-1]) + ", and " + items[-1]


if __name__ == "__main__":

    stdout.write("""---
suppress-bibliography: true
---

```{r console_start, include=FALSE}
console_start()
```

```{console setup_history, include=FALSE}
 export CHAPTER="tools"
 export HISTFILE=/history/history_${CHAPTER}
 rm -f $HISTFILE
```


<!--A[appendix]
[[appendix-tools]]
A-->
# List of Command-Line Tools {-}

This is an overview of all the command-line tools discussed in this book.
This includes binary executables, interpreted scripts, and Z Shell builtins and keywords.
For each command-line tool, the following information, when available and appropriate, is provided:

- The actual command to type at the command line
- A description
- The version used in the book
- The year that version was released
- The primary author(s)
- A website to find more information
- How to obtain help
- An example usage

All command-line tools listed here are included in the Docker image.
See [Chapter 2](#chapter-2-getting-started) for instructions on how to set it up.
Please note that citing open source software is not trivial, and that some information may be missing or incorrect.

```{console, include=FALSE}
unalias csvlook
unalias parallel
```


""")

    with open("../tools.yml") as file:
        tools = safe_load(file)

    for i, (name, tool) in enumerate(sorted(tools.items(), key = lambda x: x[0].lower()), start=1):
        stderr.write(f"{i}: {name}\n")
        stdout.write(f"## {name} {{-}}\n\n")
        stdout.write(f"{tool['description']}.\n`{name}`\n")
        if tool.get("builtin", False):
            stdout.write(f"is a Z shell builtin.\n")
        if "version" in tool:
            stdout.write(f"(version {tool['version']})\n")
        if "author" in tool:
            stdout.write(f"by {combine(tool['author'])} ({tool['year']}).\n")

        if "note" in tool:
            stdout.write(f"{tool['note']}.\n")
        if "url" in tool:
            stdout.write(f"More information: {tool['url']}.\n")

        stdout.write(f"\n```{{console {name}}}\n")
        stdout.write(f"type {name}\n")
        if "help" in tool:
            if tool["help"] == "man":
                stdout.write(f"man {name}")
            elif tool["help"] == "--help":
                stdout.write(f"{name} --help")
            else:
                stdout.write(f"{tool['help']}")
            stdout.write("#!enter=FALSE\nC-C#!literal=FALSE\n")
        if "example" in tool:
            stdout.write(f"{tool['example'].strip()}\n")
        stdout.write("```\n")
        stdout.write("\n\n")
