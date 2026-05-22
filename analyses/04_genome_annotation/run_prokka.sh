#!/bin/bash -l

module load prokka

prokka \
  --outdir prokka_canu \
  --prefix Efaecium_E745 \
  --genus Enterococcus \
  --species faecium \
  --strain E745 \
  --usegenus \
  /home/zhanj/Genome-Analysis/analyses/02_genome_assembly/canu_raw_Efaecium/Efaecium_E745_Canu_raw.contigs.fasta

