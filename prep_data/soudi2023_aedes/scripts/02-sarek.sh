#!/bin/env bash

set -euo pipefail

nextflow run nf-core/sarek -resume \
  -profile "singularity" \
  -r "3.7.1" -c sarek.config \
  --input "soudi2023_sarek_samplesheet.csv" \
  --outdir "results/sarek" \
  --intervals "resources/aaegypti-AaegL5-ensembl-61.genome_intervals.bed" \
  --tools "haplotypecaller,vep" \
  --joint_germline true \
  --filter_vcfs false \
  --vep_cache "resources/vep-cache/" \
  --vep_species "aedes_aegypti_lvpagwg" \
  --vep_cache_version "61" --vep_genome "AaegL5" \
  --igenomes_ignore true \
  --bwa "resources/aaegypti-AaegL5-ensembl-61/bwa-mem/" \
  --dict "resources/aaegypti-AaegL5-ensembl-61/genome.dict" \
  --fasta "resources/aaegypti-AaegL5-ensembl-61/genome.fa" \
  --known_snps "resources/vcf-ensembl-61/aedes_aegypti_lvpagwg.snps.vcf.gz" \
  --known_snps_tbi "resources/vcf-ensembl-61/aedes_aegypti_lvpagwg.snps.vcf.gz.tbi" \
  --known_indels "resources/vcf-ensembl-61/aedes_aegypti_lvpagwg.indels.vcf.gz" \
  --known_indels_tbi "resources/vcf-ensembl-61/aedes_aegypti_lvpagwg.indels.vcf.gz.tbi"
#  --skip_tools baserecalibrator \
#  -c "genome.config" \
#  --genome "aaegypti-AaegL5-ensembl-61"
