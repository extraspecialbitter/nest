#!/usr/local/bin/ksh

if [ "$#" -ne 1 ]
then
        echo "Usage: $0 <directory>"
        exit 1
fi

export THN_HOME=/usr/www/users/mena/theheronsnest
export VOLUME_DIR=${THN_HOME}/haiku
export ISSUE_DIR=${VOLUME_DIR}/$1

export THIS_VOLUME=`echo $1 | cut -c1-2`
export THIS_ISSUE=`echo $1 | cut -c3-4`
export LAST_ISSUE=`expr ${THIS_ISSUE} - 1`
if [ "${LAST_ISSUE}" -eq 0 ]
then
	export LAST_VOLUME=`expr ${THIS_VOLUME} - 1`
	LAST_VOLUME=`echo 0${LAST_VOLUME}`
	LAST_ISSUE=4
else
	export LAST_VOLUME=${THIS_VOLUME}
fi
LAST_ISSUE=`echo 0${LAST_ISSUE}`
export THIS_PREFIX=${THIS_VOLUME}${THIS_ISSUE}
export LAST_PREFIX=${LAST_VOLUME}${LAST_ISSUE}

cd ${THN_HOME}
cp index.html index.${LAST_PREFIX}.html
cd ${ISSUE_DIR}
cp index.html index.${THIS_PREFIX}.html
cp index.html ${THN_HOME}
cp 404.html index.html
cd ${VOLUME_DIR}
cp index.html index.${LAST_PREFIX}.html
cd ${ISSUE_DIR}
cp contents.html ${VOLUME_DIR}/index.html
cp contents.html ${VOLUME_DIR}/thn_toc.vol${THIS_VOLUME}.html

