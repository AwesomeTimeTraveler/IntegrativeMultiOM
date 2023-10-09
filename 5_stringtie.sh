#!/bin/bash

# Define the path to the directory containing the .bam files
DATA_DIR="/home/brennan/RNAseqPLEASE/clean_redo/ACO"

# Define the path to the genome gtf
GTF="/home/brennan/ACO_GCA_ .gtf"

SCRIPT="5.Stringtie"
SCRIPT_NAME="5.Stringtie - map .bam to original .gtf"
ERROR_LOG="$DATA_DIR/error_log_$SCRIPT.txt"
echo "Running $SCRIPT_NAME script on $DATA_DIR"
# Define a function to execute when there's an error, before the script exits.
trap 'echo "Error in $SCRIPT_NAME script at line $LINENO" >> $ERROR_LOG' ERR

# Create or overwrite the sample_lst.txt file
echo "" > "$DATA_DIR/sample_lst.txt"

# Iterate over .bam files in the directory
for BAM_FILE in "$DATA_DIR"/*.bam; do
    # Get the base name of the .bam file without path and extension
    BASENAME=$(basename "$BAM_FILE" .bam)
    
    # Run the stringtie command
    stringtie -p 24 -G "$GTF" -o "$DATA_DIR/output_$BASENAME.gtf" -l "$BASENAME" "$BAM_FILE"
    
    # Append the location to the sample_lst.txt
    echo "$DATA_DIR/output_$BASENAME.gtf" >> "$DATA_DIR/sample_lst.txt"
done
