#!/bin/bash

# Path to the directory with the generated files
DIR="/home/brennan/RNAseqPLEASE/clean_redo/ACO"

# Path to the original genome annotation
ORIGINAL_ANNOTATION="/home/brennan/ACO_GCA_907164435.1/Acomys_dimidiatus-GCA_907164435.1-2022_07-genes.gtf"

# Run the stringtie merge command
stringtie --merge -p 24 -G "$ORIGINAL_ANNOTATION" -o "$DIR/stringtie_merged.gtf" "$DIR/sample_lst.txt"






