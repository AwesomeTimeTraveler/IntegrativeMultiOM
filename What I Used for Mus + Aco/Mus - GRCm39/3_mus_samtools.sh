#!/bin/bash

# Define the path to the directory containing the .sam files
DATA_DIR="/home/brennan/RNAseqPLEASE/clean_redo/MUS_fq"

# Run the samtools command
samtools sort -@ 24 -o "$DATA_DIR/MEF1.bam" "$DATA_DIR/aligned_MEF1.sam"
samtools sort -@ 24 -o "$DATA_DIR/MEF2.bam" "$DATA_DIR/aligned_MEF2.sam"
samtools sort -@ 24 -o "$DATA_DIR/MEF3.bam" "$DATA_DIR/aligned_MEF3.sam"

samtools sort -@ 24 -o "$DATA_DIR/MUSY1.bam" "$DATA_DIR/aligned_MUSY1.sam"
samtools sort -@ 24 -o "$DATA_DIR/MUSY2.bam" "$DATA_DIR/aligned_MUSY2.sam"
samtools sort -@ 24 -o "$DATA_DIR/MUSY3.bam" "$DATA_DIR/aligned_MUSY3.sam"
