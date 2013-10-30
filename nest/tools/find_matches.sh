#!/bin/sh

IN=../new_addresses_070402.txt
LIS=~/.addressbook
LEN=`wc -l ${IN} | awk '{print $1}'`

K=1
while [ $K -le $LEN ];
do
  LIN=`head -${K} ${IN} | tail -1`
  grep ${LIN} ${LIS}
  K=`expr $K + 1`
done
