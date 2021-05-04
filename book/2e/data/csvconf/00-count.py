count = 0
with open("alice.txt") as f:
    for line in f.readlines():
        count += "alice" in line.lower()
print(count)
