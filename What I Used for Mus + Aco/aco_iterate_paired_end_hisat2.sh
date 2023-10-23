#!/bin/bash

# Define the path to the new directory containing the .fq files
DATA_DIR="/home/brennan/RNAseqPLEASE/clean_redo/ACO"
OUTPUT_DIR="$DATA_DIR"

# Define the path to the genome index
HISAT2_INDEX="/home/brennan/ACO_GCA_907164435.1/genome_index"

# Extract unique sample names
SAMPLES=$(ls "$DATA_DIR" | grep "_1.fq" | sed 's/_1.fq//g')

# Process each sample
for SAMPLE in $SAMPLES; do
	# Paired-end alignment using hisat2
	hisat2 -p -24 --dta -x "$HISAT2_INDEX" -1 "$DATA_DIR/${SAMPLE}_1.fq" -2 "$DATA_DIR/${SAMPLE}_2.fq" -S "$OUTPUT_DIR/aligned_${SAMPLE}.sam"
done
