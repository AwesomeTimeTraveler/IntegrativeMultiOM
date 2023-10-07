#!/bin/bash

# Path to the directory with the merged file
DATA_DIR="/home/brennan/RNAseqPLEASE/clean_redo/ACO"

# Path to the original genome annotation
GTF="./path_to_genome_directory/original_genome_annotation.gtf"

SCRIPT="7.GFFCompare"
SCRIPT_NAME="7.GFFCompare"
ERROR_LOG="$DATA_DIR/error_log_$SCRIPT.txt"
echo "Running $SCRIPT_NAME script on $DATA_DIR"
# Define a function to execute when there's an error, before the script exits.
trap 'echo "Error in $SCRIPT_NAME script at line $LINENO" >> $ERROR_LOG' ERR

# Run gffcompare
gffcompare -r "$GTF" -G -o "$DATA_DIR/merged" "$DATA_DIR/stringtie_merged.gtf"