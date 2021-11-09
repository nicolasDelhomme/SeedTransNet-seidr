#' ---
#' title: "Gopher example"
#' author: "Nicolas Delhomme"
#' date: "`r Sys.Date()`"
#' output:
#'  html_document:
#'    toc: true
#'    number_sections: true
#' ---
#' # Setup
#' Source the helper
source("~/Git/UPSCb/src/R/gopher.R")

#' # Run
#' 
#' You can check the source code in "~/Git/UPSCb/src/R/gopher.R"
#' 
#' genes is the list of gene of interest
#' 
#' background is the population in which to look for an enrichment, typically
#' every expressed genes in an experiment
#' 
#' task can be one of 'all', 'go', 'kegg', 'pfam'
test <- gopher(
  genes=c("AT2G21770","AT2G25540,AT4G18780","AT4G32410","AT4G39350","AT5G05170",
  "AT5G09870","AT5G17420","AT5G44030","AT5G64740"),
  background=NULL,
  task="go",port=11000)

#' # Results
#' 
#' mpat, mt, napt and nt are the value used for the computation of the 
#' parent-child relationship. 
#' 
#' padj is the Benjamini-Hochberg multiple correction
#' of the pval. 
#' 
#' namespace is the "root": Biological Process, Cellular Component
#' or Molecular function. 
#' 
#' id is the GO ID and def is the definition of the GO ID
#' 
str(test$GO)

#' # Session Info
#' ```{r session info, echo=FALSE}
#' sessionInfo()
#' ```
