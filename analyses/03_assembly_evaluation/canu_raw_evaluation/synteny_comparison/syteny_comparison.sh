

makeblastdb \
-in /home/zhanj/Genome-Analysis/analyses/03_assembly_evaluation/MUMmerplot_reference_genome/ncbi_dataset/data/GCF_009734005.1/GCF_009734005.1_ASM973400v2_genomic.fna \
-dbtype nucl \
-out ref_db



blastn \
  -query /home/zhanj/Genome-Analysis/analyses/02_genome_assembly/canu_raw_Efaecium/Efaecium_E745_Canu_raw.contigs.fasta \
  -db ref_db \
  -outfmt 6 \
  -out comparison.blast
