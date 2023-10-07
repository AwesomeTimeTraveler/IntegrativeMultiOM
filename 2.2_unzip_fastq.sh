#!/bin/bash

# Define the path to the directory containing the subfolders
DIR="/home/brennan/___"

# Define the path to the new directory where you want to save the unzipped files
DATA_DIR="/home/brennan/RNAseqPLEASE/___"

# Check if the new directory exists. If not, create it.
[ -d "$DATA_DIR" ] || mkdir "$DATA_DIR"

# Iterate over subfolders
for SUBFOLDER in "$DIR"/*; do
    if [ -d "$SUBFOLDER" ]; then
        # Iterate over gz files in the subfolder
        for GZ_FILE in "$SUBFOLDER"/*.fq.gz; do
            # Get the base name of the gz file without path and extension
            BASENAME=$(basename "$GZ_FILE" .fq.gz)
            # Decompress the file into the new directory
            gunzip -c "$GZ_FILE" > "$DATA_DIR/$BASENAME.fq"
        done
    fi
done
