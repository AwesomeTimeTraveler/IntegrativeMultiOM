#!/bin/bash

# Define the path to the directory containing the .bam files
DIR="/home/brennan/RNAseqPLEASE/clean_redo/ACO"

# Define the path to the genome gtf
GTF="/home/brennan/ACO_GCA_907164435.1/Acomys_dimidiatus-GCA_907164435.1-2022_07-genes.gtf"

# Create or overwrite the sample_lst.txt file
echo "" > "$DIR/sample_lst.txt"

# Iterate over .bam files in the directory
for BAM_FILE in "$DIR"/*.bam; do
    # Get the base name of the .bam file without path and extension
    BASENAME=$(basename "$BAM_FILE" .bam)
    
    # Run the stringtie command
    stringtie -p 24 -G "$GTF" -o "$DIR/output_$BASENAME.gtf" -l "$BASENAME" "$BAM_FILE"
    
    # Append the filename and location to the sample_lst.txt
    echo "output_$BASENAME.gtf , $DIR/output_$BASENAME.gtf" >> "$DIR/sample_lst.txt"
done
