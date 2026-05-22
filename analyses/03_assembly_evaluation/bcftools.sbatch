#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 02:30:00
#SBATCH -J bcftools_canu_raw

module load BWA
module load SAMtools
module load BCFtools

OUTDIR=/home/zhanj/Genome-Analysis/analyses/03_assembly_evaluation/canu_raw_evaluation/bcftools_canu_raw
mkdir -p $OUTDIR

# === Input assembly ===
REF=/home/zhanj/Genome-Analysis/analyses/02_genome_assembly/canu_raw_Efaecium/Efaecium_E745_Canu_raw.contigs.fasta

# === Illumina reads ===
R1=/proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/genomics_data/Illumina/*_1_clean.fq.gz
R2=/proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/genomics_data/Illumina/*_2_clean.fq.gz

# === Index assembly ===
bwa index $REF

# === Map reads and sort ===
bwa mem $REF $R1 $R2 \
| samtools sort -o $OUTDIR/illumina_vs_canu_raw.bam

samtools index $OUTDIR/illumina_vs_canu_raw.bam

# === Variant calling ===
bcftools mpileup -Ou -f $REF $OUTDIR/illumina_vs_canu_raw.bam \
| bcftools call -mv -Oz -o $OUTDIR/canu_raw_variants.vcf.gz

bcftools index $OUTDIR/canu_raw_variants.vcf.gz

# === Count variants ===
echo "SNP count:"
bcftools view -v snps $OUTDIR/canu_raw_variants.vcf.gz | wc -l

echo "INDEL count:"
bcftools view -v indels $OUTDIR/canu_raw_variants.vcf.gz | wc -l

