#!/bin/bash

# Path to the directory with the generated files
DIR="/home/brennan/RNAseqPLEASE/clean_redo/ACO"

stringtie -e -B -p 24 -G "$DIR/stringtie_merged.gtf" -o "$DIR/AEF1_genome_abundance.gtf" "$DIR/aligned_AEF1.bam"
stringtie -e -B -p 24 -G "$DIR/stringtie_merged.gtf" -o "$DIR/AEF2_genome_abundance.gtf" "$DIR/aligned_AEF2.bam"
stringtie -e -B -p 24 -G "$DIR/stringtie_merged.gtf" -o "$DIR/AEF3_genome_abundance.gtf" "$DIR/aligned_AEF3.bam"
stringtie -e -B -p 24 -G "$DIR/stringtie_merged.gtf" -o "$DIR/SMA1_genome_abundance.gtf" "$DIR/aligned_SMA1.bam"
stringtie -e -B -p 24 -G "$DIR/stringtie_merged.gtf" -o "$DIR/SMA5_genome_abundance.gtf" "$DIR/aligned_SMA5.bam"
stringtie -e -B -p 24 -G "$DIR/stringtie_merged.gtf" -o "$DIR/SMA6_genome_abundance.gtf" "$DIR/aligned_SMA6.bam"
