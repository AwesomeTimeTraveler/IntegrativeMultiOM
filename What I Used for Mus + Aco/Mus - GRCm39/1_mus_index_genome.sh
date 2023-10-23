#!/bin/bash

#INDEX the GENOME
DIR="/home/brennan/MUS_GRCm39/GCF_000001635.27/"

hisat2-build -p 24 ${DIR}GCF_000001635.27_GRCm39_genomic.fna ${DIR}genome_index
