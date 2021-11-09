#!/bin/bash

set -e

# usage
usage(){
  echo >&2 \
  "
  "
 exit 1
}

# fetch the argument
if [ $# -ne 3 ]; then
	usage
fi

# parse the arguments
# uid
if [ $1 -lt 1000 ]; then
	echo "Can run as a system user"
	usage
fi

# gid
if [ $2 -lt 1000 ]; then
        echo "Can run as a system group"
        usage
fi

# change the user id and gid
usermod -u $1 training
groupmod -g $2 training

# tool
case "$3" in
  Aggregate)
    CMD="mkdir -p Aggregate; seidr aggregate -o Aggregate/a_ar_c_g_g3_n_p_s_t-top1.eb Anova/anova.eb Aracne/aracne.eb CLR/clr.eb GeneNet/genenet.eb  GENIE3/genie3.eb Narromi/narromi.eb Pearson/pearson.eb Spearman/Spearman.eb TIGLM/tigress.eb"
    ;;
  Anova)
    #CMD="anova Anova/NetworkE 1 36143 Data/genes.txt"
    CMD="seidr import -i Anova/NetworkE_el.tsv -g Data/genes.txt -r -o Anova/anova.eb"
  ;;
  Aracne)
    #CMD="aracne2 -i Data/aracne.txt && mv Data/aracne_k0.164.adj Aracne"
    CMD="seidr import -a -i Aracne/aracne_k0.238.adj -g Data/genes.txt -r -o Aracne/aracne.eb"
    ;;
  CLR)
    #CMD="clr 6 Data/data.txt CLR/mi.output.txt 36143 127 0 36143 7 3 && clr 2 CRL/mi.output.txt 36143 CLR/clr.output.txt 1"
    CMD="seidr import -l -i CLR/clr.output.txt -g Data/genes.txt -r -o CLR/clr.eb"
  ;;
  GeneNet)
    #CMD="mkdir -p GeneNet && Rscript /scripts/GeneNet.R GeneNet ../Data/transposed-scaled-data.txt"
    CMD="seidr import -m -r -i GeneNet/el.txt -g Data/genes.txt -o GeneNet/genenet.eb"
  ;;
  GENIE3)
    #CMD="mkdir -p GENIE3/tmp && cd GENIE3 && Rscript /scripts/GENIE3_simple.R ../Data/transposed-data.txt genie.tsv 32 && cat tmp/* > genie3_el.txt"
    CMD="seidr import -i GENIE3/genie3_el.txt -g Data/genes.txt -r -o GENIE3/genie3.eb"
  ;;
  Narromi)
    #CMD="cd Narromi && mpirun.openmpi narromi -i ../Data/transposed-data.txt -g ../Data/genes.txt && cat tmp/* | cut -f 1,2,4 > narr_el.txt"
    CMD="seidr import -i Narromi/narr_el.txt -g Data/genes.txt -o Narromi/narromi.eb"
  ;;
  Pearson)
    #CMD="correlation -a -i Data/transposed-scaled-data.txt -m pearson -o Pearson/edgelist.tsv"
    CMD="seidr import -l -i Pearson/edgelist.tsv -g Data/genes.txt -r -o Pearson/pearson.eb"
  ;;
  Spearman)
    #CMD="correlation -a -i Data/transposed-data.txt -m spearman -o Spearman/edgelist.tsv"
    CMD="seidr import -l -i Spearman/edgelist.tsv -g Data/genes.txt -r -o Spearman/Spearman.eb"
  ;;
  Threshold)
    CMD="mkdir -p Threshold;seidr threshold -i Aggregate/a_ar_c_g_g3_n_p_s_t-top1.eb -L 0.9999 -H 1 -s 0.0000001 -d > Threshold/thresold-H1_1000_1e-7s.out"
  ;;
  TIGRESS)
    #CMD="cd TIGLM && mpirun.openmpi tigress -i ../Data/transposed-scaled-data.txt -g ../Data/genes.txt && cat tmp/* > tg_el.txt"
    CMD="seidr import -i TIGLM/edgelist.tsv -g Data/genes.txt -r -o TIGLM/tigress.eb"
  ;;
  *) exit 1;;
esac

# execute
su -c "$CMD" training
