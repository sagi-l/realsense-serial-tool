#!/bin/bash

# Run RealSense enumeration and extract only the main Serial Number (not ASIC)
SERIAL=$(rs-enumerate-devices 2>/dev/null \
    | grep -i "^\s*Serial Number" \
    | awk -F':' '{print $2}' \
    | sed 's/ //g')

if [ -z "$SERIAL" ]; then
    echo "No RealSense devices detected"
    exit 1
fi

echo "$SERIAL"
exit 0
