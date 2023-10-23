#!/bin/bash

# Define the path to the directory containing the .bam files
DATA_DIR="/home/brennan/RNAseqPLEASE/clean_redo/MUS_fq"

# Define the path to the genome index
#GTF="/home/brennan/GRCm39/GCF_000001635.27/genomic.gtf"
GTF="/home/brennan/GRCm39/GCF_000001635.27/genomic.gff"

stringtie -p 24 -G "$GTF" -o "$DATA_DIR/output_MEF1.gtf" -l "MEF1" "$DATA_DIR/MEF1.bam"
stringtie -p 24 -G "$GTF" -o "$DATA_DIR/output_MEF2.gtf" -l "MEF2" "$DATA_DIR/MEF2.bam"
stringtie -p 24 -G "$GTF" -o "$DATA_DIR/output_MEF3.gtf" -l "MEF3" "$DATA_DIR/MEF3.bam"

stringtie -p 24 -G "$GTF" -o "$DATA_DIR/output_MUSY1.gtf" -l "MUSY1" "$DATA_DIR/MUSY1.bam"
stringtie -p 24 -G "$GTF" -o "$DATA_DIR/output_MUSY2.gtf" -l "MUSY2" "$DATA_DIR/MUSY2.bam"
stringtie -p 24 -G "$GTF" -o "$DATA_DIR/output_MUSY3.gtf" -l "MUSY3" "$DATA_DIR/MUSY3.bam"
