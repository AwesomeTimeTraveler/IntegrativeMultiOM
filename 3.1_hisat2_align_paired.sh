#!/bin/bash

# Directory containing the RNAseq data
DATA_DIR="/home/brennan/RNAseqPLEASE/clean_redo/ACO"

SCRIPT="Hisat2_align"
SCRIPT_NAME="Hisat2 align (-x) to paired end reads, _1.gz and _2.gz"
ERROR_LOG="$DATA_DIR/error_log_$SCRIPT.txt"

# Path to the hisat2 genome index
HISAT2_INDEX="/home/brennan/ ACO_GENOME_AND_INDEX "

echo "Running $SCRIPT_NAME script on $DIR"
# Define a function to execute when there's an error, before the script exits.
trap 'echo "Error in $SCRIPT_NAME script at line $LINENO" >> $ERROR_LOG' ERR

# Extract unique sample names
SAMPLES=$(ls "$DATA_DIR" | grep "_1.fq" | sed 's/_1.fq//g')

for SAMPLE in $SAMPLES; do
	hisat2 -p 24 --dta -x "$HISAT2_INDEX" -1 "$DATA_DIR/${SAMPLE}_1.fq" -2 "$DATA_DIR/${SAMPLE}_2.fq" -S "$DATA_DIR/aligned_${SAMPLE}.sam"
done