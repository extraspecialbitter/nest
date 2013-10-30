#!/bin/ksh

RESULT="../Sandbox/07_master_author_index.out"

for i in `ls -1d ../Sandbox/07??_author_index.out`
do
  ISSUE=`echo $i | cut -d'_' -f1` 
  echo $ISSUE
  DIR=`ls -1d ../haiku/${ISSUE}* | cut -d'/' -f3`
  echo $DIR
done
