#!/usr/bin/env python

def factorial(x):
    result = 1
    for i in range(2, x + 1):
        result *= i
    return result

if __name__ == "__main__":
    import sys
    x = int(sys.argv[1])
    sys.stdout.write(f"{factorial(x)}\n")
