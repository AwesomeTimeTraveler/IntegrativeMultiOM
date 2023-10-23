#!/bin/bash

# Define the path to the DATA_DIRectory containing the .bam files
DATA_DIR="/home/brennan/RNAseqPLEASE/clean_redo/MUS_fq"

# Define the path to the genome gtf
GTF="/home/brennan/MUS_GRCm39/GCF_000001635.27/genomic.gtf"

# Create or overwrite the sample_lst.txt file
echo "" > "$DATA_DIR/gpt_for_merge.txt"

# Iterate over .bam files in the DATA_DIRectory
for BAM_FILE in "$DATA_DIR"/*.bam; do
    # Get the base name of the .bam file without path and extension
    BASENAME=$(basename "$BAM_FILE" .bam)
    
    # Run the stringtie command
    stringtie -p 24 -G "$GTF" -o "$DATA_DIR/stringtie_output_$BASENAME.gtf" -l "$BASENAME" "$BAM_FILE"
    
    # Append the filename and location to the sample_lst.txt
    #    "output_$BASENAME.gtf , ... "
    echo "$DATA_DIR/stringtie_output_$BASENAME.gtf" >> "$DATA_DIR/gpt_for_merge.txt"
done
