module load MUMmer

nucmer \
  --prefix=spades_vs_ref \
  /home/zhanj/Genome-Analysis/analyses/02_genome_assembly/canu_Efaecium/assembly_evaluation/MUMmerplot/reference/ncbi_dataset/data/GCF_009734005.1/*.fna \
  ../../contigs.fasta


mummerplot \
  --png \
  --layout \
  --prefix=spades_vs_ref \
  spades_vs_ref.delta
