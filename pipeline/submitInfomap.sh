#!/bin/bash

input=/mnt/picea/projects/arabidopsis/jhanson/network/CoExp_Networks/Aggregate/a_ar_c_g_g3_n_p_s_t-top1-9999925.txt 
outdir=/mnt/picea/projects/arabidopsis/jhanson/network/CoExp_Networks/Subset

if [ ! -d $outdir ]; then
  mkdir $outdir
fi

bash $UPSCb/pipeline/runPrepInfomap.sh $input $outdir
