#!/bin/bash -l

module load BUSCO

busco \
  -i /home/zhanj/Genome-Analysis/analyses/02_genome_assembly/canu_raw_Efaecium/Efaecium_E745_Canu_raw.contigs.fasta \
  -l bacteria_odb10 \
  -m genome \
  -o canu_raw_evaluation/busco_results \
  -c 1
