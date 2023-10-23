#!/bin/bash

# Define the path to the new directory containing the .fq files
DIR="/home/brennan/RNAseqPLEASE/clean_redo/ACO"

# Define the path to the genome index
INDEX="/home/brennan/rapid_release/genome_index_GCA_907164435.1"

# Iterate over .fq files in the directory
for FQ_FILE in "$DIR"/*.fq; do
    # Get the base name of the .fq file without path and extension
    BASENAME=$(basename "$FQ_FILE" .fq)

    # Run the hisat2 command
    hisat2 -p 8 --dta -x "$INDEX" -U "$FQ_FILE" -S "$DIR/aligned_$BASENAME.sam"
done
