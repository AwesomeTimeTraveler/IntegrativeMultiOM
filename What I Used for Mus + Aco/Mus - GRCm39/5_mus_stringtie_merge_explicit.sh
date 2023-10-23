#!/bin/bash

# Path to the directory with the generated files
DATA_DIR="/home/brennan/RNAseqPLEASE/clean_redo/MUS_fq"

# Here do we want the gtf originally used? Or the GFF we had to use for the first stringtie...
GTF="/home/brennan/MUS_GRCm38/GCF_000001635.26/genomic.gtf"

# Run the stringtie merge command
stringtie --merge -p 24 -G "$GTF" -o "$DATA_DIR/stringtie_merged.gtf" "$DATA_DIR/gpt_for_merge.txt"
