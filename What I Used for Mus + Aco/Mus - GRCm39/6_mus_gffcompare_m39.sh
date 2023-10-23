#!/bin/bash

# Define the path to the genome index
GTF="/home/brennan/MUS_GRCm39/GCF_000001635.27/genomic.gtf"

# Path to the directory with the merged file
DATA_DIR="/home/brennan/RNAseqPLEASE/clean_redo/MUS_fq"

# Run gffcompare
gffcompare -r "$GTF" -G -o "$DATA_DIR/gffcompare" "$DATA_DIR/stringtie_merged.gtf"