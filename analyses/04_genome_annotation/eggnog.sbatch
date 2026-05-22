#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mem=32G
#SBATCH -t 14:00:00
#SBATCH -J eggnog_canu

module load eggnog-mapper

emapper.py \
  -i prokka_canu/Efaecium_E745.faa \
  --output eggnog_canu \
  --output_dir eggnog_canu \
  --cpu 2 \
  --itype proteins \
  -m diamond \
  --data_dir eggnogmapper_database/snowy
