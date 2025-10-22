#!/bin/bash

# test_agecheck.sh - Test script for agecheck.sh

# Fresh file test
touch newFile.txt
echo "Testing with fresh file (should be ACTIVE):"
./agecheck.sh newFile.txt 600

# Old file test
touch -d "10 minutes ago" oldFile.txt
echo "Testing with stale file (should be Stale):"
./agecheck.sh oldFile.txt 300

# Missing file test
rm -f /tmp/status.marker
echo "Testing with missing file (should show error):"
./agecheck.sh

# Cleanup
rm -f newFile.txt oldFile.txt