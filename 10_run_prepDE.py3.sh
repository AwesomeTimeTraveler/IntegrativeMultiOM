#!/bin/bash

SCRIPT_NAME="Run_prepDE.py3"
DATA_DIR="/home/brennan/RNAseqPLEASE/ACO"  # current directory
ERROR_LOG="$DATA_DIR/error_log.txt"

echo "Running $SCRIPT_NAME script on $DATA_DIR"

# Define a function to execute when there's an error, before the script exits.
trap 'echo "Error in $SCRIPT_NAME script at line $LINENO" >> $ERROR_LOG' ERR

# The main logic of your script
/home/brennan/RNAseqPLEASE/prepDE.py3 -i sample_lst.txt || exit 1

echo "$SCRIPT_NAME completed successfully"