#!/bin/bash
#SBATCH -A HELARIUTTA-SL2-CPU
#SBATCH -D /home/hm533/rds/rds-bioinfo-training-Wvut5whigiI/variant-calling/temp/prep_data/soudi2023_aedes
#SBATCH -o logs/00-resources.log
#SBATCH -p sapphire
#SBATCH -c 8
#SBATCH -t 12:00:00

eval "$(conda shell.bash hook)"
source $CONDA_PREFIX/etc/profile.d/mamba.sh
mamba activate bcftools

# download VCF of known SNPs from ENSEMBL
mkdir resources/vcf-ensembl-61
cd resources/vcf-ensembl-61

#wget "http://ftp.ensemblgenomes.org/pub/metazoa/release-61/vcf/aedes_aegypti_lvpagwg/aedes_aegypti_lvpagwg.vcf.gz"
#wget "http://ftp.ensemblgenomes.org/pub/metazoa/release-61/vcf/aedes_aegypti_lvpagwg/aedes_aegypti_lvpagwg.vcf.gz.csi"

# separate SNPs and Indels
#picard SplitVcfs \
#  --REFERENCE_SEQUENCE ../aaegypti-AaegL5-ensembl-61/genome.fa \
#  --SEQUENCE_DICTIONARY ../aaegypti-AaegL5-ensembl-61/genome.dict \
#  --INPUT aedes_aegypti_lvpagwg.vcf.gz \
#  --SNP_OUTPUT aedes_aegypti_lvpagwg.snps.vcf.gz \
#  --INDEL_OUTPUT aedes_aegypti_lvpagwg.indels.gz

bcftools view -v snps aedes_aegypti_lvpagwg.vcf.gz -Oz -o aedes_aegypti_lvpagwg.snps.vcf.gz
bcftools index --tbi aedes_aegypti_lvpagwg.snps.vcf.gz
bcftools view -v indels aedes_aegypti_lvpagwg.vcf.gz -Oz -o aedes_aegypti_lvpagwg.indels.vcf.gz
bcftools index --tbi aedes_aegypti_lvpagwg.indels.vcf.gz
