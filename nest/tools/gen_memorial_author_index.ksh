#!/usr/local/bin/ksh

export BASEDIR=/usr/home/mena/public_html/theheronsnest/haiku
export WORKDIR=${BASEDIR}/0701e1917
export INFILE=memorial.txt
export OUTFILE=tribute_author_index.out

rm -f ${OUTFILE}

cd ${WORKDIR}
export TOTAL_LINES=`wc -l ${INFILE} | awk '{print $1}'`
export LINE_POINTER=0

while [ ${LINE_POINTER} -le ${TOTAL_LINES} ]
do
  LINE_POINTER=`expr ${LINE_POINTER} + 1`
  if [ `expr ${LINE_POINTER} % 6` -eq 4 ] 
  then
    PAGE_NUMBER=3
    POEM_NUMBER=`expr ${LINE_POINTER} / 6 + 1`
    POET=`head -${LINE_POINTER} ${INFILE} | tail -1`
    LINE_POINTER=`expr ${LINE_POINTER} + 1`
    HOME=`head -${LINE_POINTER} ${INFILE} | tail -1`
    echo "<DT>"${POET}":&nbsp;&nbsp;<A HREF=thn_issue.t3.html#POEM"${POEM_NUMBER}">"${PAGE_NUMBER}" #"${POEM_NUMBER}"</A><DD>"${HOME}"</DT>" >> ${OUTFILE}
  fi
done
