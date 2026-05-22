module load BUSCO

busco \
  -i /home/zhanj/Genome-Analysis/analyses/02_genome_assembly/canu_Efaecium/Efaecium_E745_Canu.contigs.fasta \
  -l bacteria_odb10 \
  -m genome \
  -o busco_canu \
  -c 1

