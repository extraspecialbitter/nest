#!/bin/sh

IN=../new_addresses_070401.txt
LIS=~/.addressbook
LEN=`wc -l ${IN} | awk '{print $1}'`

K=1
while [ $K -le $LEN ];
do
  LIN=`head -${K} ${IN} | tail -1`
  CNT=`grep -c ${LIN} ${LIS}`
  if [ $CNT -eq 0 ];
  then
    echo $LIN
  fi
  K=`expr $K + 1`
done
