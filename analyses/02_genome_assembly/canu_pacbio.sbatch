#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 4
#SBATCH -t 06:00:00
#SBATCH -J canu_Efaecium
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --mail-type=ALL

module load canu/2.3-GCCcore-13.3.0-Java-17

RAW_READS=~/Genome-Analysis/data/raw_data/pacbio/*.fastq.gz
OUTDIR=./canu_raw_Efaecium
PREFIX=Efaecium_E745_Canu_raw

canu \
  -p ${PREFIX} \
  -d ${OUTDIR} \
  genomeSize=2.8m \
  -pacbio-raw ${RAW_READS} \
  bamOutput=false \
  gridOptions="-A uppmax2026-1-61" \
  corMemory=16 \
  corThreads=4 \
  gridOptions="-A uppmax2026-1-61 -t 02:00:00"
