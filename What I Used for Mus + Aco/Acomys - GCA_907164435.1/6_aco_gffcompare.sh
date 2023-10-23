#!/bin/bash

# Path to the original genome annotation
ORIGINAL_ANNOTATION="/home/brennan/ACO_GCA_907164435.1/Acomys_dimidiatus-GCA_907164435.1-2022_07-genes.gtf"

# Path to the directory with the merged file
DIR="/home/brennan/RNAseqPLEASE/clean_redo/ACO"

# Run gffcompare
gffcompare -r "$ORIGINAL_ANNOTATION" -G -o merged "$DIR/stringtie_merged.gtf"
