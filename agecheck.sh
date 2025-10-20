#!/bin/bash
# agecheck.sh - Check if a file is stale based on its modification time

FILE=$1
MAX_AGE=$2  # in seconds

if [ ! -f "$FILE" ]; then
    echo "Error: File not found: $FILE"
    exit 1
fi

current_time=$(date +%s)
file_mod_time=$(stat -c %Y "$FILE")
age=$((current_time - file_mod_time))

if [ "$age" -gt "$MAX_AGE" ]; then
    echo "Stale: '$FILE' is older than $MAX_AGE seconds (age: $age)."
else
    echo "ACTIVE: '$FILE' is still fresh (age: $age)"
fi
