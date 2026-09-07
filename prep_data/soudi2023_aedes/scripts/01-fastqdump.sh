#!/bin/bash
#SBATCH -A HELARIUTTA-SL2-CPU
#SBATCH -D /home/hm533/rds/rds-bioinfo-training-Wvut5whigiI/variant-calling/temp/prep_data/soudi2023_aedes
#SBATCH -o logs/01-fastqdump_%a.log
#SBATCH -p sapphire
#SBATCH -c 8
#SBATCH -t 08:00:00
#SBATCH -a 1-41

set -euo pipefail

eval "$(conda shell.bash hook)"
source $CONDA_PREFIX/etc/profile.d/mamba.sh
mamba activate sra

# fetch current SRA id
# sra=$(cut -d "," -f 2 sra_accessions.csv | head -n $SLURM_ARRAY_TASK_ID | tail -n 1)
sra=$(head -n $SLURM_ARRAY_TASK_ID sra_runs_remaining.csv | tail -n 1)

# prefetch
prefetch --max-size 100G ${sra}

# validate
vdb-validate ${sra}

# convert
fasterq-dump --threads $SLURM_CPUS_PER_TASK --outdir reads/ ${sra}

# gzip
cd reads/
pigz --best --no-name --processes $SLURM_CPUS_PER_TASK ${sra}*.fastq

#for i in $(ls ${sra}*.fastq)
#do
#  gzip ${i}
#done

