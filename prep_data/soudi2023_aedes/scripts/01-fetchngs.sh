#!/bin/env bash


nextflow run nf-core/fetchngs \
  -r "1.12.0" \
  -profile singularity \
  -resume \
  --input sra_runs.csv \
  --outdir results/fetchngs \
  --nf_core_pipeline viralrecon \
  --download_method sratools
