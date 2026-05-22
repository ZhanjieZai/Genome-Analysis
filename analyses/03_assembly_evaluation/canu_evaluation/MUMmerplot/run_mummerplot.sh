
#!/bin/bash

nucmer --prefix=Efaecium ./reference/ncbi_dataset/data/GCF_009734005.1/GCF_009734005.1_ASM973400v2_genomic.fna ../../Efaecium_E745_Canu.contigs.fasta

mummerplot --png --layout --prefix=Efaecium Efaecium.delta
