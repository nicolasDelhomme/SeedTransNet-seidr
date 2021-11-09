#!/bin/bash

set -ex
# this fails for the moment because of a SLURM issue
# proj=u2017003
proj=u2017002

# exit if user not in docker group
ALWD=`groups | grep -c docker`

if [ $ALWD -ne 1 ]; then
  echo "Your user is not part of the docker group, contact your administrator."
  exit 1
fi

if [ $# -ne 1 ]; then
  echo "We expect one argument: Anova, Aracne, CLR, GeneNet, GENIE3, Narromi, Pearson, Spearman, TIGRESS"
  exit 1
fi

in=/mnt/picea/projects/arabidopsis/jhanson/network/CoExp_Networks
PARTITION=core
CPU=1
HOST=
MEM=16G
CMD="/scripts/runNetwork.sh 20054 2060"
RM="--rm"
case "$1" in
  Aggregate)
  ;;
  Anova)
#    HOST="-w watson"
  ;;
  Aracne)
  ;;
  CLR)
  ;;
  GeneNet)  
  ;;
  GENIE3)
#    CPU=32
#    HOST="-w watson"
  ;;
  Narromi)
#    CPU=60
#    HOST="-w watson"
#    PARTITION="mpi"
#    RM=""
  ;;
  Pearson)
  ;;
  Spearman)
  ;;
  Threshold)
  ;;
  TIGRESS)
#    CPU=60
#    HOST="-w picea"
#    PARTITION="mpi"
#    RM=
  ;;
  *) exit 1;;
esac
CMD="$CMD $1"

cd $in

sbatch -A $proj -n $CPU --mem=$MEM -p $PARTITION $HOST -e $in/$1.err -o $in/$1.out \
  $UPSCb/pipeline/runDocker.sh -i bschiffthaler/seidr:ABN -c "$CMD" run -- \
  -v $in:/home/training/run $RM
