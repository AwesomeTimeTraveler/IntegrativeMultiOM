#!/bin/bash

# Path to the directory with the generated files
DATA_DIR="/home/brennan/RNAseqPLEASE/clean_redo/ACO"

SCRIPT="6.Stringtie --merge"
SCRIPT_NAME="6.Stringtie --merge - Smoosh all output_N.gtf together"
ERROR_LOG="$DATA_DIR/error_log_$SCRIPT.txt"
echo "Running $SCRIPT_NAME script on $DATA_DIR"
# Define a function to execute when there's an error, before the script exits.
trap 'echo "Error in $SCRIPT_NAME script at line $LINENO" >> $ERROR_LOG' ERR

# Path to the original genome annotation
GTF="./path_to_genome_directory/orginal_genome_annotation.gtf"

# Run the stringtie merge command
stringtie --merge -p 24 -G "$GTF" -o "$DATA_DIR/stringtie_merged.gtf" "$DATA_DIR/sample_lst.txt"