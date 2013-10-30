#!/bin/bash

# global initializations

OUT="10_master_author_index.out"
rm -f ${OUT}

# do for each issue

for INFILE in `ls -1d 10??_author_index.out`
do
  ISSUE=`echo $INFILE | cut -d'_' -f1` 
  DIR=`ls -1d ../haiku/${ISSUE}* | cut -d'/' -f3`
  URL="http://www.theheronsnest.com/haiku/${DIR}"

  export TOTAL_LINES=`wc -l ${INFILE} | awk '{print $1}'`
  export LINE_POINTER=0                                  
                                                       
# do for each line

  while [ ${LINE_POINTER} -lt ${TOTAL_LINES} ]           
  do                                                     
    LINE_POINTER=`expr ${LINE_POINTER} + 1`              
    LINE=`head -${LINE_POINTER} $INFILE | tail -1`
    T1=`echo $LINE | cut -d'=' -f1`
    T2="=${URL}/"
    T3=`echo $LINE | cut -d'=' -f2 | cut -d'>' -f1`
    T3="${T3}>"
    P=`echo $LINE | cut -d'>' -f5 | cut -d'#' -f1`
    T4=`echo $LINE | cut -d'=' -f2 | cut -d'>' -f2-4 | cut -d'#' -f2`
    T4="${ISSUE} ${P}#${T4}>"      
    echo "${T1}${T2}${T3}${T4}" >> ${OUT}
  done
done
