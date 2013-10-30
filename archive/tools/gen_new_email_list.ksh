#!/bin/ksh

export DIR="/usr/home/mena/public_html/theheronsnest"
export FILE=${DIR}/email_addresses.txt
export TOTAL_LINES=`wc -l ${FILE} | awk '{print $1}'`
export LINE_COUNT=0

# echo ${TOTAL_LINES}

while [ ${LINE_COUNT} -le ${TOTAL_LINES} ]
do
  TAIL_COUNT=`expr ${TOTAL_LINES} - ${LINE_COUNT}`
  LINE_COUNT=`expr ${LINE_COUNT} + 1`
  LINE=`tail -${TAIL_COUNT} ${FILE} | head -1`
  NUMBER="h${LINE_COUNT}"
  echo "${NUMBER}\t\t${LINE}"
done
