#
# generate haiku pages for The Heron's Nest
#

# if [ $# != 1 ] ;
# then
#   echo "Usage gen_haiku_pages.sh <directory>"
#   exit 1
# fi

# BASE_DIR=/www/html/nest
BASE_DIR=/usr/www/users/mena/theheronsnest
SRC_DIR=${BASE_DIR}/haiku/$1
WORK_DIR=${BASE_DIR}/Sandbox/$1
HAIKU_FILE=${SRC_DIR}/haiku.txt
TEMP_AUTHORS=${WORK_DIR}/authors.txt
rm -rf ${WORK_DIR}
mkdir ${WORK_DIR}

MAX_LINES=`wc -l ${HAIKU_FILE} | awk '{print $1}'`
MAX_LINES=`expr $MAX_LINES + 3`
LINE_COUNT=0
LINE_INCREMENT=6

#
# extract author names from raw text file
#

while [ ${LINE_COUNT} -lt ${MAX_LINES} ]
do
  LINE_COUNT=`expr ${LINE_COUNT} + 1`
  if [ `expr ${LINE_COUNT} % ${LINE_INCREMENT}` -eq 0 ] ;
  then
    head -${LINE_COUNT} ${HAIKU_FILE} | tail -3 | head -1
  fi
done > ${TEMP_AUTHORS}

AUTHOR_LINES=`wc -l ${TEMP_AUTHORS} | awk '{print $1}'`
LINE_COUNT=0
LINE_NUMBER=0
PAGE_COUNT=1

rm -f ${WORK_DIR}/h?.out

#
# generate table of contents for each haiku page
#

while [ ${LINE_COUNT} -lt ${AUTHOR_LINES} ]
do
  LINE_NAME=0${LINE_NUMBER}
  PAGE_NUMBER=h${PAGE_COUNT}
  echo "<P><A HREF=thn_issue.${PAGE_NUMBER}.html#POEM${LINE_NAME}>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
  LINE_COUNT=`expr ${LINE_COUNT} + 1`
  LINE_NUMBER=`expr ${LINE_NUMBER} + 1`
  head -${LINE_COUNT} ${TEMP_AUTHORS} | tail -1 >> ${WORK_DIR}/${PAGE_NUMBER}.out
  echo "</A>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
  if [ `expr ${LINE_COUNT} % 10` -eq 0 ] ;
  then
    PAGE_COUNT=`expr ${PAGE_COUNT} + 1`
    LINE_NUMBER=0
  fi
done

# 
# generate HTML for the actual haiku
#

LINE_COUNT=0
LINE_NUMBER=0
PAGE_SIZE=60
PAGE_COUNT=1
HAIKU_NUMBER=0
HAIKU_LINE_NUMBER=1
HAIKU_COUNT=1
HAIKU_SIZE=6

while [ ${LINE_COUNT} -lt ${MAX_LINES} ]
do
  for HAIKU_START in 1 13 25 37 49 7 19 31 43 55
  do
    LINE_NUMBER=`expr ${LINE_NUMBER} + ${HAIKU_START}`
    PAGE_NUMBER=h${PAGE_COUNT}
    HAIKU_NUMBER=`expr ${HAIKU_START} - 1`
    HAIKU_NUMBER=`expr ${HAIKU_NUMBER} / 6`
    POEM_NAME=0${HAIKU_NUMBER}

#
# process haiku for left side of page
#

    case ${HAIKU_COUNT} in 

    1) echo "</TD>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
       echo " " >> ${WORK_DIR}/${PAGE_NUMBER}.out
       echo "<TD ALIGN=LEFT VALIGN=TOP WIDTH=380>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
       echo "<TABLE>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
       echo " " >> ${WORK_DIR}/${PAGE_NUMBER}.out
       ;;

#
# process haiku for right side of page
#

    6) echo " " >> ${WORK_DIR}/${PAGE_NUMBER}.out
       echo "</TABLE></TD>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
       echo " " >> ${WORK_DIR}/${PAGE_NUMBER}.out
       echo "<TD ALIGN=LEFT VALIGN=TOP WIDTH=380>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
       echo "<TABLE><TR ALIGN=LEFT VALIGN=TOP>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
       echo "<TD><FONT SIZE=-2>&nbsp;</FONT></TD>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
       echo "</TR>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
       echo " " >> ${WORK_DIR}/${PAGE_NUMBER}.out
       echo "<TR ALIGN=RIGHT VALIGN=TOP>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
       echo "<TD>&nbsp;</TD>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
       echo "</TR>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
       ;;
    esac

#
# for each haiku
#

    echo "<TR ALIGN=LEFT VALIGN=TOP>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
    echo "<TD><A NAME=POEM${POEM_NAME}></A>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
    echo "<P><FONT SIZE=+1>" >> ${WORK_DIR}/${PAGE_NUMBER}.out
    echo " " >> ${WORK_DIR}/${PAGE_NUMBER}.out

    while [ ${HAIKU_LINE_NUMBER} -le ${HAIKU_SIZE} ]
    do
      case ${HAIKU_LINE_NUMBER} in
        1|2) head -${LINE_NUMBER} ${HAIKU_FILE} | tail -1 >> ${WORK_DIR}/${PAGE_NUMBER}.out 
             echo "<BR>" >> ${WORK_DIR}/${PAGE_NUMBER}.out 
             LINE_NUMBER=`expr $LINE_NUMBER + 1` 
             HAIKU_LINE_NUMBER=`expr $HAIKU_LINE_NUMBER + 1` 
             LINE_COUNT=`expr ${LINE_COUNT} + 1`
             ;;
        3)   head -${LINE_NUMBER} ${HAIKU_FILE} | tail -1 >> ${WORK_DIR}/${PAGE_NUMBER}.out 
             echo "</FONT></TD></TR>" >> ${WORK_DIR}/${PAGE_NUMBER}.out 
             LINE_NUMBER=`expr $LINE_NUMBER + 1` 
             HAIKU_LINE_NUMBER=`expr $HAIKU_LINE_NUMBER + 1` 
             LINE_COUNT=`expr ${LINE_COUNT} + 1`
             ;;
        4)   echo "<TR ALIGN=RIGHT VALIGN=TOP><TD>" >> ${WORK_DIR}/${PAGE_NUMBER}.out 
             head -${LINE_NUMBER} ${HAIKU_FILE} | tail -1 >> ${WORK_DIR}/${PAGE_NUMBER}.out 
             echo "<P>&nbsp;</TD></TR>" >> ${WORK_DIR}/${PAGE_NUMBER}.out 
             LINE_NUMBER=`expr $LINE_NUMBER + 1` 
             HAIKU_LINE_NUMBER=`expr $HAIKU_LINE_NUMBER + 1` 
             LINE_COUNT=`expr ${LINE_COUNT} + 1`
             ;;
        5|6) LINE_NUMBER=`expr $LINE_NUMBER + 1` 
             HAIKU_LINE_NUMBER=`expr $HAIKU_LINE_NUMBER + 1` 
             LINE_COUNT=`expr ${LINE_COUNT} + 1`
             ;;
      esac
    done
    HAIKU_LINE_NUMBER=1
    if [ `expr ${LINE_COUNT} % ${PAGE_SIZE}` -eq 0 ] ;
    then
      HAIKU_COUNT=1
      PAGE_COUNT=`expr ${PAGE_COUNT} + 1`
    else
      HAIKU_COUNT=`expr ${HAIKU_COUNT} + 1`
    fi
    LINE_NUMBER=`expr ${LINE_COUNT} / ${PAGE_SIZE}`
    LINE_NUMBER=`expr ${LINE_NUMBER} \* ${PAGE_SIZE}`
  done
done
