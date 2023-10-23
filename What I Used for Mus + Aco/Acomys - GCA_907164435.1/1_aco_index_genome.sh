#!/bin/bash

# I did NOT use this script to do this, I ran it manually on the genome provided here:
# https://ftp.ensembl.org/pub/rapid-release/species/Acomys_dimidiatus/GCA_907164435.1/ensembl/genome/

#INDEX the GENOME
DIR="/home/brennan/rapid_release/GCA_907164435.1/"

hisat2-build -p 24 ${DIR} Acomys_dimidiatus-GCA_907164435.1-unmasked.fa ${DIR}genome_index
