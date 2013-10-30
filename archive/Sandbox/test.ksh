#!/usr/local/bin/ksh
ISSUE="0701"
DIR=`ls -1d ../haiku/${ISSUE}* | cut -d'/' -f3`
URL="http://www.theheronsnest.com/haiku/${DIR}"
LINE=`head -1 0701_author_index.out | tail -1`
echo $LINE
T1=`echo $LINE | cut -d'=' -f1`                
T2="=${URL}/"                                  
T3=`echo $LINE | cut -d'=' -f2 | cut -d'>' -f1`
T3="${T3}>"                                    
T4=`echo $LINE | cut -d'=' -f2 | cut -d'>' -f2-4 | cut -d'#' -f2`
T4="${ISSUE} #${T4}>"
echo "${T1}${T2}${T3}${T4}"
