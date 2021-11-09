#' ---
#' title: "Bing's seed translational network "
#' author: "Nicolas Delhomme, Bastian Schiffthaler"
#' date: "`r Sys.Date()`"
#' output:
#'  html_document:
#'    toc: true
#'    number_sections: true
#' ---
#' # Setup
#' # Environment
#' Set the working dir
setwd("/mnt/picea/home/bbai/Git/UPSCb/projects/arabidopsis-bing-network/network/CoExp_Networks/Threshold/")
#' ```{r set up, echo=FALSE}
#' knitr::opts_knit$set(root.dir="/mnt/picea/home/bbai/Git/UPSCb/projects/arabidopsis-bing-network/network/CoExp_Networks/Threshold")
#' ```

#' Libs
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(reshape2))
suppressPackageStartupMessages(library(scales))

#' # Threshold
#' ## Assessed range
th <- read.table('thresold-H1_1000_1e-7s.out')
colnames(th) <- c("Threshold","Edges","Vertices","SFT","ACC")
th2 <- melt(th, id = "Threshold")
ggplot(th2, aes(x = Threshold, y = value, group = variable, col = variable)) +
  geom_line(lwd = 0.5) + facet_wrap(~variable, scales = "free") +
  scale_x_reverse() + theme_bw() +
  theme(text = element_text(size = 10)) +
  scale_y_continuous(labels = comma) + 
  coord_cartesian(xlim = c(0.9999, 1))

#' ## Zommed in
th <- read.table('thresold-H1_1000_1e-7s.out')
colnames(th) <- c("Threshold","Edges","Vertices","SFT","ACC")
th2 <- melt(th, id = "Threshold")
ggplot(th2, aes(x = Threshold, y = value, group = variable, col = variable)) +
  geom_line(lwd = 0.5) + facet_wrap(~variable, scales = "free") +
  scale_x_reverse() + theme_bw() +
  theme(text = element_text(size = 10)) +
  scale_y_continuous(labels = comma) + 
  coord_cartesian(xlim = c(0.99999, 1))

#' # Session Info
#' ```{r session info, echo=FALSE}
#' sessionInfo()
#' ```
