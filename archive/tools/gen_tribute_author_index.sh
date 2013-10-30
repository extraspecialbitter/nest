#!/bin/bash

export BASEDIR=../haiku
export WORKDIR=${BASEDIR}/0902Y1837
export INFILE=tribute_authors.out
export OUTFILE=tribute_index.out

cd ${WORKDIR}
rm -f ${OUTFILE}

export TOTAL_LINES=`wc -l ${INFILE} | awk '{print $1}'`
export LINE_POINTER=1

while [ ${LINE_POINTER} -lt ${TOTAL_LINES} ]
do
    LINE=`head -${LINE_POINTER} ${INFILE} | tail -1`
    POET=`echo ${LINE} | cut -d'>' -f3 | cut -d'<' -f1`
    PAGE=`echo ${LINE} | cut -d':' -f1`
    PAGENUM=`echo ${PAGE} | cut -c12-12`
    POEM=`echo ${LINE} | cut -d'=' -f2 | cut -d'>' -f1`
    POEMNUM=`echo ${POEM} | cut -c6-7`
    echo "<dt>${POET}:&nbsp;&nbsp;<a href=${PAGE}${POEM}>${PAGENUM} ${POEMNUM}</a><dd>City, State</dt>"
    LINE_POINTER=`expr ${LINE_POINTER} + 1`
done >> ${OUTFILE}
