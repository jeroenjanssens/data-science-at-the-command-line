"""
random-sample: Output lines from stdin to stdout with a given probability,
for a given duration, and with a given delay between lines.

Example usage: seq 100 | random-sample -r 20% -d 1000

Dependency: Python 2.7

Author: http://jeroenjanssens.com
"""
import argparse
from datetime import timedelta
from random import random
import sys
from time import time, sleep


INVALID_RATE = ('Invalid rate. Please specify a rate between 0 and 1 '
                'using either 0.33, 33%, 1/3 notation.')


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-W', '--weeks', type=float, default=0,
                        help='Duration of sampling in weeks')
    parser.add_argument('-D', '--days', type=float, default=0,
                        help='Duration of sampling in days')
    parser.add_argument('-H', '--hours', type=float, default=0,
                        help='Duration of sampling in hours')
    parser.add_argument('-m', '--minutes', type=float, default=0,
                        help='Duration of sampling in minutes')
    parser.add_argument('-s', '--seconds', type=float, default=0,
                        help='Duration of sampling in seconds')
    parser.add_argument('-t', '--milliseconds', type=float, default=0,
                        help='Duration of sampling in milliseconds')
    parser.add_argument('-u', '--microseconds', type=float, default=0,
                        help='Duration of sampling in microseconds')
    parser.add_argument('-r', '--rate', default='100%',
                        help=('Rate between 0 and 1 using either '
                              '0.33, 33%, 1/3 notation.'))
    parser.add_argument('-d', '--delay', default=0, type=int,
                        help=('Time in milliseconds between each '
                              'line of output'))
    args = parser.parse_args()

    try:
        delay = (float(args.delay) / 1000.0)
    except ValueError:
        parser.error('Invalid delay. Please specify a delay in ms.')

    try:
        duration = timedelta(
            weeks=args.weeks,
            days=args.days,
            hours=args.hours,
            minutes=args.minutes,
            seconds=args.seconds,
            milliseconds=args.milliseconds,
            microseconds=args.microseconds
        ).total_seconds()
    except:
        parser.error('Invalid duration.')

    try:
        if '%' in args.rate:
            rate = float(args.rate[:-1]) / 100.0
        elif '/' in args.rate:
            a, b = map(float, args.rate.split('/')[:2])
            rate = a / (1.0*b)
        else:
            rate = float(args.rate)
    except ValueError:
        parser.error(INVALID_RATE)

    if rate <= 0 or rate > 1:
        parser.error(INVALID_RATE)

    start = time()
    try:
        while True:
            line = sys.stdin.readline()
            if not line:
                return
            if random() <= rate:
                sys.stdout.write(line)
                sys.stdout.flush()
                now = time()
                if duration and (now-start) > duration:
                    return
                sleep(delay)
    except:
        pass

if __name__ == '__main__':
    exit(main())
