#!/bin/bash

# Define the path to the directory containing the .sam files
DIR="/home/brennan/RNAseqPLEASE/clean_redo/ACO"

# Iterate over .sam files in the directory
for SAM_FILE in "$DIR"/*.sam; do
    # Get the base name of the .sam file without path and extension
    BASENAME=$(basename "$SAM_FILE" .sam)
    
    # Run the samtools command
    samtools sort -@ 8 -o "$DIR/$BASENAME.bam" "$SAM_FILE"
done
