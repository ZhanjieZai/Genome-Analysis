BiocManager::install("DESeq2")
library(DESeq2)

files <- c(
  "ERR1797972_counts.txt",
  "ERR1797973_counts.txt",
  "ERR1797974_counts.txt",
  "ERR1797969_counts.txt",
  "ERR1797970_counts.txt",
  "ERR1797971_counts.txt"
)

sampleNames <- c(
  "BH1","BH2","BH3",
  "Serum1","Serum2","Serum3"
)

countList <- lapply(files, function(f){
  read.table(f, header=FALSE, row.names=1)
})

countMatrix <- do.call(cbind, countList)

colnames(countMatrix) <- sampleNames

countMatrix <- countMatrix[!grepl("^__", rownames(countMatrix)), ]

condition <- factor(c("BH","BH","BH","Serum","Serum","Serum"))

colData <- data.frame(
  row.names = sampleNames,
  condition = condition
)

dds <- DESeqDataSetFromMatrix(
  countData = countMatrix,
  colData = colData,
  design = ~ condition
)

dds <- dds[rowSums(counts(dds)) > 10, ]

dds <- DESeq(dds)

res <- results(dds)

res <- res[order(res$pvalue), ]

head(res)

write.csv(as.data.frame(res), "DESeq2_results.csv")

sig <- res[res$padj < 0.05 & abs(res$log2FoldChange) > 1, ]
nrow(sig)

up <- sig[sig$log2FoldChange > 1, ]
down <- sig[sig$log2FoldChange < -1, ]
nrow(up)
nrow(down)

head(sig, 10)

#volcano plot
library(ggplot2)
library(ggrepel)

df <- as.data.frame(res)
df$gene <- rownames(df)

df$color <- "NotSig"
df$color[df$padj < 0.05 & df$log2FoldChange > 1] <- "Up"
df$color[df$padj < 0.05 & df$log2FoldChange < -1] <- "Down"

df$color <- factor(df$color, levels = c("Down", "NotSig", "Up"))

# top genes


top_up <- head(sig[order(sig$log2FoldChange, decreasing=TRUE), ], 10)
top_down <- head(sig[order(sig$log2FoldChange), ], 10)

top20 <- rbind(top_up, top_down)

top_genes <- rownames(top20)

# log transform
df$logP <- pmin(-log10(df$padj), 50)

ggplot(df, aes(x=log2FoldChange, y=logP, color=color)) +
  
  geom_point(size=1.4, alpha=0.6) +
  

  scale_color_manual(
    name = "Expression change",   
    values = c(
      "Down" = "#3B6FB6",     
      "NotSig" = "grey80",     
      "Up" = "#D94F4F"          
    )
  ) +
  
  theme_minimal(base_size = 14) +
  

  theme(
    legend.position = "right",
    legend.title = element_text(size=11),
    legend.text = element_text(size=10)
  ) +
  
  labs(
    title = "Volcano Plot",
    x = "log2 Fold Change",
    y = "-log10(adjusted p-value)"
  ) +
  
  geom_vline(xintercept=c(-1,1), linetype="dashed") +
  geom_hline(yintercept=-log10(0.05), linetype="dashed") +
  
  geom_text_repel(
    data=subset(df, gene %in% top_genes),
    aes(label=gene),
    size=3,
    max.overlaps = 100,
    show.legend = FALSE 
  )


#Heatmap

library(pheatmap)

# top 20 gene

mat <- counts(dds, normalized=TRUE)[top_genes, ]


mat_scaled <- t(scale(t(mat)))


annotation_col <- data.frame(
  condition = colData$condition
)

rownames(annotation_col) <- colnames(mat_scaled)

# heatmap
pheatmap(
  mat_scaled,
  annotation_col = annotation_col,
  show_rownames = TRUE,
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  fontsize_row = 8,
  main = "Top 20 Differentially Expressed Genes"
)



eggnog <- read.delim("eggnog_canu.emapper.annotations", comment.char="#", header=FALSE)

colnames(eggnog)[c(1,7)] <- c("gene","COG")

deg_cog <- eggnog[eggnog$gene %in% rownames(sig), ]

table(unlist(strsplit(deg_cog$COG, "")))




prokka <- read.delim("Efaecium_E745.tsv")

top_up <- head(sig[order(sig$log2FoldChange, decreasing=TRUE), ], 10)
top_down <- head(sig[order(sig$log2FoldChange), ], 10)

top20 <- rbind(top_up, top_down)

top_with_anno <- merge(
  as.data.frame(top20),
  prokka,
  by.x="row.names",
  by.y="locus_tag"
)

top_with_anno[, c("Row.names","log2FoldChange","product")]

