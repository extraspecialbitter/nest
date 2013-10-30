#!/bin/ksh

TARGET="author_index.out"
HERE=`pwd`

cd ../haiku
for i in `find 07* -name ${TARGET} -print`
do
  ISSUE=`echo $i | cut -c1-4`
  cp -p ${i} "${HERE}/${ISSUE}_${TARGET}"
done
