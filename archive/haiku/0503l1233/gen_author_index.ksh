#!/usr/local/bin/ksh

if [ "$#" -ne 1 ]
then
        echo "Usage: $0 <directory>"
        exit 1
fi

export BASEDIR=/usr/home/mena/public_html/lowplaces/thn/haiku
export WORKDIR=${BASEDIR}/$1
export INFILE=haiku.txt
export OUTFILE=author_index.out

rm -f ${OUTFILE}

cd ${WORKDIR}
export TOTAL_LINES=`wc -l ${INFILE} | awk '{print $1}'`
export LINE_POINTER=0

while [ ${LINE_POINTER} -le ${TOTAL_LINES} ]
do
  LINE_POINTER=`expr ${LINE_POINTER} + 1`
  if [ `expr ${LINE_POINTER} % 6` -eq 4 ] 
  then
    PAGE_NUMBER=`expr ${LINE_POINTER} / 60 + 1`
    POEM_NUMBER=`expr ${LINE_POINTER} / 6 + 1`
    POEM_NUMBER=`expr ${POEM_NUMBER} % 10`
    if [ ${POEM_NUMBER} -eq 0 ]
    then
      POEM_NUMBER=10
    fi
    POET=`head -${LINE_POINTER} ${INFILE} | tail -1`
    LINE_POINTER=`expr ${LINE_POINTER} + 1`
    HOME=`head -${LINE_POINTER} ${INFILE} | tail -1`
    echo "<DT>"${POET}":&nbsp;&nbsp;<A HREF=thn_issue.h"${PAGE_NUMBER}".html#POEM"${POEM_NUMBER}">"${PAGE_NUMBER}" #"${POEM_NUMBER}"</A><DD>"${HOME}"</DT>" >> ${OUTFILE}
  fi
done
