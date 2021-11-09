library(geneNetworkR)
library(IRanges)

# read the filtered vst data
setwd("/mnt/picea/projects/arabidopsis/jhanson/network")

# sample
samples <- na.omit(unlist(read.delim(file = "all stages TE data.txt",header = FALSE,nrows = 1,as.is = TRUE)[1,,drop=TRUE]))

# metadata
# Anova is very unflexible, we need the SampleName as integer values, sorted from 1 to x
# and the replicate sorted accordingly from 1 to x by SampleName
metadata <- data.frame(SampleName=as.integer(factor(samples,levels = unique(samples))),
                       ReplicateNumber=unlist(lapply(lapply(runLength(Rle(samples)),":",1),rev)),
                       row.names=make.unique(samples))

# data
mat <- read.delim(file = "all stages TE data.txt",row.names=1)

# reorder the data
stopifnot(identical(rownames(metadata),colnames(mat)))

# create the object
sexp <- instantiate(metadata=metadata,exp.mat=mat)

# save it
dir.create("analysis",showWarnings = FALSE)
save(sexp,file="analysis/seidr-network.rda")

# Prepare the directory for running the tools
dir.create("CoExp_Networks",showWarnings = FALSE)
sexp <- prepare(folder="CoExp_Networks",
                sexp)

# Get the data set up and print the command lines
# Anova
run(sexp,"Anova")

# Aracne
run(sexp,"Aracne")

# CLR
run(sexp,"CLR")

# GeneNet
# not run here; check the docker bschiffthaler/seidr:ABN

# GENIE3
# not run here; check the docker bschiffthaler/seidr:ABN

# Narromi
run(sexp,"Narromi")

# Pearson
run(sexp,"Pearson")

# Spearman
run(sexp,"Spearman")

# TIGRESS - bastian implementation using GLMs
run(sexp,"TIGLM")
