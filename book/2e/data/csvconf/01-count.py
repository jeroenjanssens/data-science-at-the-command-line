from sys import argv

count = 0
with open("alice.txt") as f:
    for line in f.readlines():
        count += argv[1] in line.lower()
print(count)