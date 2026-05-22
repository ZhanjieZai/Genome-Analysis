#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 04:00:00
#SBATCH -J spades_Efaecium
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --mail-type=ALL

module load SPAdes


spades.py \
  -k 55 \
  -1 /proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/genomics_data/Illumina/*_1_clean.fq.gz \
  -2 /proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/genomics_data/Illumina/*_2_clean.fq.gz \
  --nanopore /proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/genomics_data/Nanopore/E745_all.fasta.gz \
  -o spades_Efaecium

