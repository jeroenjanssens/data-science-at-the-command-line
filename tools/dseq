#!/usr/bin/env bash
# dseq: generate sequence of dates relative to today.
#
# Usage: dseq LAST
#    or: dseq FIRST LAST
#    or: dseq FIRST INCREMENT LAST
#
# Example usage:
# $ dseq 1       # tomorrow
# $ dseq 0 0     # today
# $ dseq 7       # next 7 days
# $ dseq -2 0	 # day before yesterday till today
# $ dseq 1 7 365 # tomorrow and then every week for a year
#
# Author: Jeroen Janssens

seq -f "%g day" "$@" | date --file - +%F
