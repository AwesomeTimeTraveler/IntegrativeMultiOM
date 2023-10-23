#!/bin/bash

# Define the path to the new directory containing the .fq files
DATA_DIR="/home/brennan/RNAseqPLEASE/clean_redo/MUS_fq"
OUTPUT_DIR="$DATA_DIR"  # The directory where SAM files will be saved

# Define the path to the genome index
HISAT2_INDEX="/home/brennan/GRCm39/GCF_000001635.27/genome-index"

hisat2 -p 24 --dta -x "$HISAT2_INDEX" -1 "$DATA_DIR/MEF1_1.fq" -2 "$DATA_DIR/MEF1_2.fq" -S "$OUTPUT_DIR/aligned_MEF1.sam"
hisat2 -p 24 --dta -x "$HISAT2_INDEX" -1 "$DATA_DIR/MEF2_1.fq" -2 "$DATA_DIR/MEF2_2.fq" -S "$OUTPUT_DIR/aligned_MEF2.sam"
hisat2 -p 24 --dta -x "$HISAT2_INDEX" -1 "$DATA_DIR/MEF3_1.fq" -2 "$DATA_DIR/MEF3_2.fq" -S "$OUTPUT_DIR/aligned_MEF3.sam"

hisat2 -p 24 --dta -x "$HISAT2_INDEX" -1 "$DATA_DIR/MUSY1_1.fq" -2 "$DATA_DIR/MUSY1_2.fq" -S "$OUTPUT_DIR/aligned_MUSY1.sam"
hisat2 -p 24 --dta -x "$HISAT2_INDEX" -1 "$DATA_DIR/MUSY2_1.fq" -2 "$DATA_DIR/MUSY2_2.fq" -S "$OUTPUT_DIR/aligned_MUSY2.sam"
hisat2 -p 24 --dta -x "$HISAT2_INDEX" -1 "$DATA_DIR/MUSY3_1.fq" -2 "$DATA_DIR/MUSY3_2.fq" -S "$OUTPUT_DIR/aligned_MUSY3.sam"
