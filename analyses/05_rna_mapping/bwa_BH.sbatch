#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 04:00:00
#SBATCH -J bwa_BH

module load BWA
module load SAMtools

REF=/home/zhanj/Genome-Analysis/analyses/02_genome_assembly/canu_raw_Efaecium/Efaecium_E745_Canu_raw.contigs.fasta
READDIR=/home/zhanj/Genome-Analysis/data/trimmed_data/BH_trimmed
OUTDIR=/home/zhanj/Genome-Analysis/analyses/05_rna_mapping/BH

mkdir -p ${OUTDIR}

for sample in ERR1797972 ERR1797973 ERR1797974
do
  echo "Mapping ${sample}..."

  bwa mem -t 2 \
    ${REF} \
    ${READDIR}/${sample}_1P.fq.gz \
    ${READDIR}/${sample}_2P.fq.gz \
    | samtools sort -@ 2 -o ${OUTDIR}/${sample}_sorted.bam

  samtools index ${OUTDIR}/${sample}_sorted.bam

done
