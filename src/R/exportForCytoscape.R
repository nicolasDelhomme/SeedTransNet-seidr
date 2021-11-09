#' ---
#' title: "Bing's TE network format conversion"
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
setwd("/mnt/picea/projects/arabidopsis/jhanson/network/CoExp_Networks/Aggregate")
#' ```{r set up, echo=FALSE}
#' knitr::opts_knit$set(root.dir="/mnt/picea/projects/arabidopsis/jhanson/network/CoExp_Networks/Aggregate")
#' ```

#' Libraries
suppressPackageStartupMessages(library(igraph))

#' # Process
#' Read the data
mat <- read.delim("a_ar_c_g_g3_n_p_s_t-top1-9999925.txt",header=FALSE)

#' Create the undirected graph
sel <- mat[,4]=="Undirected"
u.graf <- graph.edgelist(as.matrix(mat[sel,1:2]),directed = FALSE)
u.graf <- set_edge_attr(u.graf,name="rank",value=mat[sel,3])
u.graf <- set_edge_attr(u.graf,name="scores",value=mat[sel,5])

#' Create the directed graph
d.graf <- graph.edgelist(as.matrix(mat[!sel,1:2]),directed = TRUE)
d.graf <- set_edge_attr(d.graf,name="rank",value=mat[!sel,3])
d.graf <- set_edge_attr(d.graf,name="scores",value=mat[!sel,5])

#' Combine the graphs
graf <- d.graf+as.directed(u.graf,mode="mutual")

#' Just display the graph info
clusters(graf)

#' # Export
write_graph(graf,file="a_ar_c_g_g3_n_p_s_t-top1-9999925.graphml",format="graphml")

#' # Session Info
#' ```{r session info, echo=FALSE}
#' sessionInfo()
#' ```
