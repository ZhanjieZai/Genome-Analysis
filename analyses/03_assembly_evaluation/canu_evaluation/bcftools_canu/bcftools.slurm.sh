#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 02:30:00
#SBATCH -J bcftools_canu

module load BWA
module load SAMtools
module load BCFtools

# === Input assembly ===
REF=/home/zhanj/Genome-Analysis/analyses/02_genome_assembly/canu_Efaecium/Efaecium_E745_Canu.contigs.fasta

# === Illumina reads ===
R1=/proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/genomics_data/Illumina/*_1_clean.fq.gz
R2=/proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/genomics_data/Illumina/*_2_clean.fq.gz

# === Index assembly ===
bwa index $REF

# === Map reads and sort ===
bwa mem $REF $R1 $R2 \
| samtools sort -o illumina_vs_canu.bam

samtools index illumina_vs_canu.bam

# === Variant calling ===
bcftools mpileup -Ou -f $REF illumina_vs_canu.bam \
| bcftools call -mv -Oz -o canu_variants.vcf.gz

bcftools index canu_variants.vcf.gz

# === Count variants ===
echo "SNP count:"
bcftools view -v snps canu_variants.vcf.gz | wc -l

echo "INDEL count:"
bcftools view -v indels canu_variants.vcf.gz | wc -l
