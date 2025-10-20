# Bash File Age Calculator (`agecheck.sh`)

## Overview
This project is part of the **CyberCafe learning sprint (Sprint 3)**.  
Its goal is to teach **Bash scripting** by creating a small, useful tool that checks how old a file is and reports whether it’s **“fresh”** or **“expired.”**

This script helps Bash learners understand:
- How to read **file metadata** (modification time)
- How to use **timestamps and arithmetic**
- How to write **conditional logic**
- How to create a **self-contained Bash utility**

---

## What the Script Does
`agecheck.sh` checks the **age** of a file based on its **last modification time**.

- If the file is **older** than the allowed time (`MAX_AGE`),  
  → it prints: `EXPIRED`
- If the file is **younger**,  
  → it prints: `Fresh`
- If the file **doesn’t exist**,  
  → it automatically **creates** it so you can track it later.

---

## How It Works

```bash
#!/bin/bash
FILE=${1:-/tmp/status.marker}  # Use first argument or default file
MAX_AGE=${2:-300}              # Use second argument or default 300 sec
```

| **Argument** | **Purpose**          | **Example**                          |
| ------------ | -------------------- | ------------------------------------ |
| `$1`         | File path to check   | `./agecheck.sh myfile.txt`           |
| `$2`         | Max age (in seconds) | `./agecheck.sh myfile.txt 600`       |
| *(None)*     | Uses defaults        | `/tmp/status.marker` and 300 seconds |

- If no arguments are provided, the script automatically checks /tmp/status.marker and treats 300 seconds (5 minutes) as the expiration threshold.

---

## How It Calculates File Age

### Get current time
`current_time=$(date +%s)`
→ Gives seconds since 1970 (Unix epoch)

### Get file’s modification time
`file_mtime=$(stat -c %Y "$FILE")`
→ %Y outputs the file’s “last modified” time in seconds

### Compute age
`age=$(( current_time - file_mtime ))`

### Compare and print
```bash
if [ "$age" -gt "$MAX_AGE" ]; then
    echo "EXPIRED"
else
    echo "Fresh"
fi
```
## Example Usage
### Example 1 – Default (no arguments)
`./agecheck.sh`
### Output
```bash
Checking file: /tmp/status.marker
Fresh: '/tmp/status.marker' is 12 seconds old (threshold: 300).
```
### Example 2 – Check a specific file
`./agecheck.sh notes.log 600`
### Output
`EXPIRED: 'notes.log' is 720 seconds old (threshold: 600).`

### Example 3 – Simulate an older file
```bash
touch -d "10 minutes ago" old.txt
./agecheck.sh old.txt 300
```
### Output
`EXPIRED: 'old.txt' is 600 seconds old (threshold: 300).`
