#!/bin/bash

# -CONST-
NOT_ASSOCIATED_STRING="(not associated)"
CLIENT_LIST_HEADER="Station MAC"
# ---

if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "  $0 <file1.csv> [file2.csv ...]"
    echo "  $0 *.csv"
    exit 1
fi

# loop through every argument given to the script
for INPUT_FILE in "$@"; do

    # check if argument is a real file
    if [ ! -f "$INPUT_FILE" ]; then
        echo "Warning: Skipping '$INPUT_FILE', not a file." >&2
        continue
    fi

    awk -F ',' -v na_str="$NOT_ASSOCIATED_STRING" -v client_hdr="$CLIENT_LIST_HEADER" '
        # stop processing this file if we hit the client list
        $1 ~ client_hdr {
            exit
        }

        # process lines that look like a BSSID
        $1 ~ /^([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}$/ {

            bssid = $1
            essid = $(NF-1)

            gsub(/^[ ]+|[ ]+$/, "", essid)

            # apply exclusion rules
            if (essid != "" && essid != na_str) {
                print bssid "," essid
            }
        }
    ' "$INPUT_FILE"
done
