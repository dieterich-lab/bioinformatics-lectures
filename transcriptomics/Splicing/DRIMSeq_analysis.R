#!/usr/bin/env Rscript

### imports

# We use rtracklayer this lib to load and handle GTF files and stringr to make string operations easier 

library(rtracklayer)
library(stringr)
library(tximport)
library(DRIMSeq)
library(openxlsx)

# Creates tx2gene, a object the holds the mapping between genes and transcripts

gtf.path <- '/biodb/genomes/homo_sapiens/GRCh38_96/GRCh38.96.gtf'
gtf <- rtracklayer::import(gtf.path)

# Here we load the Salmon results using tximport

tx2gene <- as.data.frame(gtf)[, c('gene_id', 'transcript_id', 'gene_name', 'transcript_name')]

files <- Sys.glob('local/salmon/*/quant.sf')

names(files) <- str_split(files, '/', simplify = TRUE)[, 3]

txi <- tximport(
  files,
  type = "salmon",
  countsFromAbundance = "scaledTPM",
  txOut = TRUE
)

cts <- txi$counts
rownames(cts) <- str_split(rownames(cts), '\\.', simplify = TRUE)[, 1]
head(cts[rowSums(cts) > 1, ])

# For this analysis we use DRIMSeq

matching <- intersect(rownames(cts), tx2gene$transcript_id)
gene_ids <- setNames(tx2gene$gene_id, tx2gene$transcript_id)
counts <- base::data.frame(
  gene_id = gene_ids[matching],
  feature_id = matching,
  cts[matching, ]
)

# Now we write the experimental design matrix

samples <- base::data.frame(sample_id =  make.names(colnames(cts)))
samples$condition <- str_split(samples$sample_id, '_', simplify = TRUE)[, 1]
# make sure we are testing for EGF vs PBS
samples$condition <- factor(samples$condition, levels=c("PBS", "EGF"))
samples

# Next cell filter transcripts that have a low abundance

d <- dmDSdata(counts = counts, samples = samples)
d <- dmFilter(
  d,
  min_feature_expr = 30,
  min_feature_prop = 0.3,
  min_samps_gene_expr = 2,
  min_gene_expr = 50
)

# Number of genes
length(d@counts)
# Number of transcripts
sum(lengths(d@counts))

design_full <- model.matrix(~condition, data = samples(d))
d <- dmPrecision(d, design = design_full, prec_subset=0.001)

d <- dmFit(d, design = design_full, verbose = 1)
d <- dmTest(d, coef = "conditionEGF", verbose = 1)

# To build a results table, we run the results function. 
# Generate a single p-value per gene, which tests whether there is any differential transcript usage within the gene...

res <-  dplyr::filter(results(d), adj_pvalue < 0.05)
res <- dplyr::arrange(res, adj_pvalue)

# ... or a single p-value per transcript, which tests whether the proportions for this transcript changed within the gene

res.txp <- dplyr::filter(results(d, level="feature"), adj_pvalue < 0.05)
res.txp <- dplyr::arrange(res.txp, adj_pvalue)

# change NA to 1 if any 

no.na <- function(x) ifelse(is.na(x), 1, x)
res$pvalue <- no.na(res$pvalue)
res.txp$pvalue <- no.na(res.txp$pvalue)

# Plot the estimated proportions for one of the significant genes, where we can see evidence of switching

# idx <- which(res$adj_pvalue < 0.05)[1]
# res[idx,]

dir.create("local/dtu")
png(file="local/dtu/example.png", width=600, height=350)
# plotProportions(d, res$gene_id[idx], "condition")
plotProportions(d, "ENSG00000151366", "condition")
dev.off()

wb <- createWorkbook()
addWorksheet(wb, sheetName="conditionEGF")
writeDataTable(wb, sheet=1, x=res)
addWorksheet(wb, sheetName="conditionEGF.txp")
writeDataTable(wb, sheet=2, x=res.txp)
saveWorkbook(wb, "local/dtu/conditionEGF.xlsx", overwrite = TRUE)
    
