#!/bin/bash
# agecheck.sh - Check if a file is stale based on its modification time

# FILE is the target file an if it is not given as the first argument ($1),
# it defaults to /tmp/status.marker
# Example: 
# ./agecheck.sh myfile.txt   -> uses myfile.txt
# ./agecheck.sh              -> uses /tmp/status.marker
FILE=${1:-/tmp/status.marker} 

# MAX_AGE is the maximum allowed file age (in seconds)
# If not given as the second argument ($2), defaults to 300 seconds (5 minutes)
MAX_AGE=${2:-300}

# Checking if FILE exists
if [ ! -f "$FILE" ]; then
    echo "Error: File not found: $FILE"
    exit 1
fi

# Calculate current and modification times
current_time=$(date +%s)
file_mod_time=$(stat -c %Y "$FILE")
age=$((current_time - file_mod_time))

# Compare age to threshold and print result
if [ "$age" -gt "$MAX_AGE" ]; then
    echo "Stale: '$FILE' is older than $MAX_AGE seconds (age: $age)."
else
    echo "ACTIVE: '$FILE' is still fresh (age: $age)"
fi
