#!/bin/bash

# This script sorts camera serial numbers from the smallest to the largest.

echo "Enter each RealSense serial number, one per line."
echo "Press CTRL+D when finished."
echo

# Read serials
SERIALS=$(cat)

if [ -z "$SERIALS" ]; then
    echo "No serial numbers entered."
    exit 1
fi

SORTED=$(echo "$SERIALS" | sort -n)

echo
echo "Installation order:"
COUNT=1
echo "$SORTED" | while read S; do
    echo "Camera $COUNT → $S"
    COUNT=$((COUNT + 1))
done
