#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 03:00:00
#SBATCH -J rna_trimming_BH


module load Trimmomatic


RAWDIR=/home/zhanj/Genome-Analysis/data/raw_data/RNAseq/BH_raw
OUTDIR=/home/zhanj/Genome-Analysis/data/trimmed_data/BH_trimmed


for sample in ERR1797973
do
  trimmomatic PE -threads 1 \
    ${RAWDIR}/${sample}_1.fastq.gz \
    ${RAWDIR}/${sample}_2.fastq.gz \
    ${OUTDIR}/${sample}_1P.fq.gz \
    ${OUTDIR}/${sample}_1U.fq.gz \
    ${OUTDIR}/${sample}_2P.fq.gz \
    ${OUTDIR}/${sample}_2U.fq.gz \
    ILLUMINACLIP:$EBROOTTRIMMOMATIC/adapters/TruSeq3-PE.fa:2:30:10 \
    SLIDINGWINDOW:4:20 \
    MINLEN:36
done
