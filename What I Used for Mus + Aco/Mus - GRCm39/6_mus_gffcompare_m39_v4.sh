#!/bin/bash

# Define the path to the genome index
GTF="/home/brennan/GRCm39/GCF_000001635.27/genomic.gtf"

# Path to the directory with the merged file
DATA_DIR="/home/brennan/RNAseqPLEASE/clean_redo/MUS_fq"

# Run gffcompare
gffcompare -r "$GTF" -G -o gff_merged "$DATA_DIR/stringtie_merged.gtf"

gffcompare -r /home/brennan/GRCm39/GCF_000001635.27/genomic.gtf  -G -o gff_merged /home/brennan/RNAseqPLEASE/clean_redo/MUS_fq/stringtie_merged.gtf
