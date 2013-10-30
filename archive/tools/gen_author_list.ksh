#!/usr/local/bin/ksh

if [ "$#" -ne 1 ]
then
        echo "Usage: $0 <directory>"
        exit 1
fi

export BASEDIR=/usr/home/mena/public_html/theheronsnest/haiku
export WORKDIR=${BASEDIR}/$1
export INFILE=haiku.txt
export OUTFILE=author_list.out

rm -f ${WORKDIR}/${OUTFILE}

cd ${WORKDIR}
export TOTAL_LINES=`wc -l ${INFILE} | awk '{print $1}'`
export LINE_POINTER=0

while [ ${LINE_POINTER} -lt ${TOTAL_LINES} ]
do
  LINE_POINTER=`expr ${LINE_POINTER} + 1`
  if [ `expr ${LINE_POINTER} % 6` -eq 4 ] 
  then
    POET=`head -${LINE_POINTER} ${INFILE} | tail -1`
    LINE_POINTER=`expr ${LINE_POINTER} + 5`
    echo ${POET} >> ${OUTFILE}
  fi
done
