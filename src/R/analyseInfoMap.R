#' ---
#' title: "Bing's TE network infomap analysis"
#' author: "Nicolas Delhomme & Bing Bai"
#' date: "`r Sys.Date()`"
#' output:
#'  html_document:
#'    toc: true
#'    number_sections: true
#' ---
#' 
#' # Setup
#' ## Environment
#' Set the working dir
setwd("/mnt/picea/projects/arabidopsis/jhanson/network/CoExp_Networks/Subset")
#' ```{r set up, echo=FALSE}
#' knitr::opts_knit$set(root.dir="/mnt/picea/projects/arabidopsis/jhanson/network/CoExp_Networks/Subset")
#' ```

#' # Process
#' Read the data
imap <- read.delim("a_ar_c_g_g3_n_p_s_t-top1-9999925.txt.final.h.txt",as.is = TRUE)

#' Check the number of cluster in the lowest granularity (the largest clusters/modules)
barplot(table(imap$C2))

#' The same zoomed in the first ~30
barplot(table(imap$C2),xlim=c(0,30))

#' The number of modules at the different level of granularity (from a depth of 1 to 4, less to more granular)
barplot(sapply(2:5,function(i){nrow(unique(imap[,2:i,drop=FALSE]))}))

#' Looking at a few top (1) clusters and the amount of members in their level 2 submodules
barplot(table(imap$C3[imap$C2 == "1"]))
barplot(table(imap$C3[imap$C2 == "3"]))
barplot(table(imap$C3[imap$C2 == "1200"]))

#' Writing to file the first module (at the highest granularity level)
write(imap[imap$C2 == "1","ID"],"cluster-1.txt")
write(imap[imap$C2 == "1" & imap$C3 == "1","ID"],"cluster-1:1.txt")

#' Fish clusters that contains a gene of interest
imap[imap$ID=="AT4G15390",]

#' # Session Info
#' ```{r session info, echo=FALSE}
#' sessionInfo()
#' ```
