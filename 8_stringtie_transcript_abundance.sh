#!/bin/bash

# Path to the directory containing the .bam files and merged GTF
DATA_DIR="/path/to/your/new_directory"

SCRIPT="8.Stringtie (-e) - Estimate Transcript Abundance"
SCRIPT_NAME="8.Stringtie"
ERROR_LOG="$DATA_DIR/error_log_$SCRIPT.txt"
echo "Running $SCRIPT_NAME script on $DATA_DIR"
# Define a function to execute when there's an error, before the script exits.
trap 'echo "Error in $SCRIPT_NAME script at line $LINENO" >> $ERROR_LOG' ERR

# Iterate over .bam files in the directory
for BAM_FILE in "$DATA_DIR"/*.bam; do
    # Get the base name of the .bam file without path and extension
    BASENAME=$(basename "$BAM_FILE" .bam)
    
    # Run stringtie on each bam file
    stringtie -e -B -p 24 -G "$DATA_DIR/stringtie_merged.gtf" -o "$DATA_DIR/${BASENAME}_genome_abundance.gtf" "$BAM_FILE"
# Append the filename and location to the gpt_lst.txt
    echo "${BASENAME}_genome_abundance.gtf , $DATA_DIR/output_${BASENAME}.gtf" >> "$DATA_DIR/gpt_lst.txt"
done