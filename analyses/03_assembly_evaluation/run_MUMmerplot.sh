#!/bin/bash -l

module load MUMmer

REF=/home/zhanj/Genome-Analysis/analyses/03_assembly_evaluation/MUMmerplot_reference_genome/ncbi_dataset/data/GCF_009734005.1/GCF_009734005.1_ASM973400v2_genomic.fna
QUERY=/home/zhanj/Genome-Analysis/analyses/02_genome_assembly/canu_raw_Efaecium/Efaecium_E745_Canu_raw.contigs.fasta

OUTDIR=canu_raw_evaluation/MUMmerplot
PREFIX=${OUTDIR}/canu_raw_vs_ref

mkdir -p ${OUTDIR}

nucmer \
  --prefix=${PREFIX} \
  ${REF} \
  ${QUERY}

mummerplot \
  --png \
  --layout \
  --prefix=${PREFIX} \
  ${PREFIX}.delta

