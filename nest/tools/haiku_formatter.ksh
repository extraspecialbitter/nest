#!/usr/local/bin/ksh

if [ "$#" -ne 1 ]
then
        echo "Usage: $0 <directory>"
        exit 1
fi

export BASEDIR=/usr/home/mena/public_html/theheronsnest/haiku
export WORKDIR=${BASEDIR}/$1
export INFILE=haiku.txt
export OUTFILE1=formatted_haiku.out
export OUTFILE2=author_list.out

rm -f ${WORKDIR}/${OUTFILE1}
rm -f ${WORKDIR}/${OUTFILE2}

cd ${WORKDIR}
export TOTAL_LINES=`wc -l ${INFILE} | awk '{print $1}'`
export LINE_POINTER=0

while [ ${LINE_POINTER} -lt ${TOTAL_LINES} ]
do
  LINE_POINTER=`expr ${LINE_POINTER} + 1`
  if [ `expr ${LINE_POINTER} % 6` -eq 1 ] 
  then
    PAGE_NUMBER=`expr ${LINE_POINTER} / 60 + 1`
    POEM_NUMBER=`expr ${LINE_POINTER} / 6 + 1` 
    POEM_NUMBER=`expr ${POEM_NUMBER} % 10`     
    if [ ${POEM_NUMBER} -eq 0 ]                
    then                                       
      POEM_NUMBER=10                           
    fi                                         
    L=`head -${LINE_POINTER} ${INFILE} | tail -1`
    L1=`echo "<TR ALIGN=LEFT VALIGN=TOP><TD><P><FONT SIZE=+1>${L}<br>"`
    LINE_POINTER=`expr ${LINE_POINTER} + 1`
    L=`head -${LINE_POINTER} ${INFILE} | tail -1`
    L2=`echo "${L}<br>"`
    LINE_POINTER=`expr ${LINE_POINTER} + 1`
    L=`head -${LINE_POINTER} ${INFILE} | tail -1`
    L3=`echo "${L}</FONT></TD></TR>"`
    LINE_POINTER=`expr ${LINE_POINTER} + 1`
    L=`head -${LINE_POINTER} ${INFILE} | tail -1`
    POET=`echo "<TR ALIGN=RIGHT VALIGN=TOP><TD>${L}<P>&nbsp;</TD></TR>"`
    echo "${L1} ${L2} ${L3} ${POET}" >> ${OUTFILE1}
    POET=`echo "<p><a href=#POEM"${POEM_NUMBER}">"${L}"</a>"`
    echo "${POET}" >> ${OUTFILE2}
    if [ ${POEM_NUMBER} -eq 10 ]                
    then
      echo " " >> ${OUTFILE1}
      echo " " >> ${OUTFILE2}
    fi
    LINE_POINTER=`expr ${LINE_POINTER} + 2`
  fi
done
