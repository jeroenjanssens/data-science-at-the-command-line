#!/usr/bin/env python

from subprocess import run
from sys import argv

if __name__ == "__main__":

    _, filename, pattern = argv

    with open(filename) as f:
        alice = f.read()

    words = "\n".join(alice.split())

    grep = run(["grep", "-i", pattern],
               input = words,
               capture_output=True,
               text=True)

    print(len(grep.stdout.strip().split("\n")))
