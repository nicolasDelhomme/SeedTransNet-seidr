library(GeneNet)
library(data.table)
setwd("/mnt/picea/projects/arabidopsis/jhanson/network/CoExp_Networks")
dat <- fread("Data/transposed-scaled-data.txt")
colnames(dat) <- scan("Data/genes.txt",what="character")
out <- "GeneNet/el.txt"
pcor.dyn = ggm.estimate.pcor(as.matrix(dat), method = "dynamic")
write.table(abs(pcor.dyn), file = out, col.names = FALSE, row.names = FALSE, quote = FALSE, sep = '\t')
