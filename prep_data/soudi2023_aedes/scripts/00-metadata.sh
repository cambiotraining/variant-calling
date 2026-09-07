#!/bin/env bash

# supplementary file 1 from https://doi.org/10.1186/s12864-023-09402-5
wget -O soudi2023_metadata.xlsx "https://static-content.springer.com/esm/art%3A10.1186%2Fs12864-023-09402-5/MediaObjects/12864_2023_9402_MOESM1_ESM.xlsx"

# convert to CSV - requires csvkit
# skipping the header row and adding clean header names manually
echo "sample_id,collection_site,disctrict,year,latitude,longitude,sex,sra_experiment" > soudi2023_metadata.csv
in2csv soudi2023_metadata.xlsx | tail -n +3 | csvcut -c 1,2,3,5,6,7,8,14 >> soudi2023_metadata.csv

# This metadata includes the SRA experiment IDs (SRX*), not the run IDs (SRR*)
# The SRR runs were collected from SRA to a separate file called sra_accessions.csv for fastq-dump
# We then selected 32 of the samples to download and saved in soudi2023_subset_metadata.csv
