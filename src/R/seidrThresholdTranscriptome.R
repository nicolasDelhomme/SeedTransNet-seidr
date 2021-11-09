#' ---
#' title: "Bing's seed transcription network "
#' author: "Nicolas Delhomme, Bing Bai"
#' date: "`r Sys.Date()`"
#' output:
#'  html_document:
#'    toc: true
#'    number_sections: true
#' ---
#' # Setup
#' # Environment
#' Set the working dir
setwd("/mnt/picea/home/bbai/Git/UPSCb/projects/arabidopsis-bing-network/network/transcriptome_networks/aggregate")
#' ```{r set up, echo=FALSE}
#' knitr::opts_knit$set(root.dir="/mnt/picea/home/bbai/Git/UPSCb/projects/arabidopsis-bing-network/network/transcriptome_networks/aggregate")
#' ```

#' Libs
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(reshape2))
suppressPackageStartupMessages(library(scales))

#' # Threshold
#' ## Assessed range
th <- read.table('threshold.txt')
colnames(th) <- c("Threshold","Edges","Vertices","SFT","ACC")
th2 <- melt(th, id = "Threshold")
ggplot(th2, aes(x = Threshold, y = value, group = variable, col = variable)) +
  geom_line(lwd = 0.5) + facet_wrap(~variable, scales = "free") +
  scale_x_reverse() + theme_bw() +
  theme(text = element_text(size = 10)) +
  scale_y_continuous(labels = comma) + 
  coord_cartesian(xlim = c(0.9999, 1))

#' ## Zommed in
th <- read.table('threshold.txt')
colnames(th) <- c("Threshold","Edges","Vertices","SFT","ACC")
th2 <- melt(th, id = "Threshold")
ggplot(th2, aes(x = Threshold, y = value, group = variable, col = variable)) +
  geom_line(lwd = 0.5) + facet_wrap(~variable, scales = "free") +
  scale_x_reverse() + theme_bw() +
  theme(text = element_text(size = 10)) +
  scale_y_continuous(labels = comma) + 
  coord_cartesian(xlim = c(0.999975, 1))

#' # Session Info
#' ```{r session info, echo=FALSE}
#' sessionInfo()
#' ```
