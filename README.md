# Genome and Transcriptome Analysis of *Enterococcus faecium*

This project analyzes genome sequencing and RNA-seq data of Enterococcus faecium, including genome assembly, annotation, and differential expression analysis.

## Workflow

Raw sequencing reads

→ Quality control

→ Genome assembly (Canu/SPAdes)

→ Assembly evaluation (QUAST/BUSCO)

→ Annotation (Prokka)

→ RNA-seq analysis (DESeq2)

## Tools

- Quality control: FastQC, Trimmomatic
- Genome assembly: Canu, SPAdes
- Assembly evaluation: QUAST, BUSCO
- Comparative genomics: MUMmer, BLAST, Artemis Comparison Tool
- Genome annotation: Prokka, eggNOG-mapper, DIAMOND
- RNA-seq analysis: DESeq2

Environment: Linux, UPPMAX HPC, Bash, R

## Detailed analysis report and workflow description are available in the Wiki:

https://github.com/ZhanjieZai/Genome-Analysis/wiki/Method-and-Results
