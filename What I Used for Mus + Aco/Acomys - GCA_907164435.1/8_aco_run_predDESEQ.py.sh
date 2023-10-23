#!/bin/bash

SCRIPT_NAME="Download and Run"
DIR="/home/brennan/RNAseqPLEASE/clean_redo/ACO"  # current directory
ERROR_LOG="$DIR/error_log.txt"

echo "Running $SCRIPT_NAME script on $DIR"

# Define a function to execute when there's an error, before the script exits.
trap 'echo "Error in $SCRIPT_NAME script at line $LINENO" >> $ERROR_LOG' ERR

# The main logic of your script
chmod +x prepDE.py3
./prepDE.py3 -i "$DIR/gtf_lst.txt" || exit 1

echo "$SCRIPT_NAME completed successfully"
