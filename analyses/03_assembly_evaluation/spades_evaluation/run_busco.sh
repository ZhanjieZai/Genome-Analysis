
module load BUSCO

busco \
  -i ../contigs.fasta \
  -l bacteria_odb10 \
  -m genome \
  -o busco_spades \
  -c 1
