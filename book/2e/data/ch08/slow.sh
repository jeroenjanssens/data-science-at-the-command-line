#!/bin/bash
echo "Starting job $1" | ts
duration=$((1+RANDOM%5))
sleep $duration
echo "Job $1 took ${duration} seconds" | ts
