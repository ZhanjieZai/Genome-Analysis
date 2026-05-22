#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 06:00:00
#SBATCH -J htseq_Serum

module load HTSeq

BAMDIR=/home/zhanj/Genome-Analysis/analyses/05_rna_mapping/Serum
OUTDIR=/home/zhanj/Genome-Analysis/analyses/06_gene_counting/Serum
GFF=/home/zhanj/Genome-Analysis/analyses/04_genome_annotation/prokka_canu/Efaecium_E745.clean.gff

mkdir -p ${OUTDIR}

for sample in ERR1797969 ERR1797970 ERR1797971
do

  htseq-count \
    -f bam \
    -r pos \
    -s no \
    -i ID \
    -t CDS \
    ${BAMDIR}/${sample}_sorted.bam \
    ${GFF} \
    > ${OUTDIR}/${sample}_counts.txt

done
