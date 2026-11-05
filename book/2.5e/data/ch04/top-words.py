#!/usr/bin/env python
import re
import sys

from collections import Counter
from urllib.request import urlopen

def top_words(text, n):
    with urlopen("https://raw.githubusercontent.com/stopwords-iso/stopwords-en/master/stopwords-en.txt") as f:
        stopwords = f.read().decode("utf-8").split("\n")

    words = re.findall("[a-z']{2,}", text.lower())
    words = (w for w in words if w not in stopwords)

    for word, count in Counter(words).most_common(n):
        print(f"{count:>7} {word}")


if __name__ == "__main__":
    text = sys.stdin.read()

    try:
        n = int(sys.argv[1])
    except:
        n = 10

    top_words(text, n)
