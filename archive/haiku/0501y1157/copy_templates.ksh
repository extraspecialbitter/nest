#!/usr/local/bin/ksh

# if [ $# != 1 ] ;
# then
#   echo "Usage copy_templates.ksh <directory>"
#   exit 1
# fi

export TOOL_DIR=.
export WORK_DIR=.

cp ${TOOL_DIR}/template_thn_issue.h1.html ${WORK_DIR}/thn_issue.h1.html
cp ${TOOL_DIR}/template_thn_issue.h2.html ${WORK_DIR}/thn_issue.h2.html
cp ${TOOL_DIR}/template_thn_issue.h3.html ${WORK_DIR}/thn_issue.h3.html
cp ${TOOL_DIR}/template_thn_issue.h4.html ${WORK_DIR}/thn_issue.h4.html
cp ${TOOL_DIR}/template_thn_issue.h5.html ${WORK_DIR}/thn_issue.h5.html

cp ${TOOL_DIR}/template_thn_issue.i1.html ${WORK_DIR}/thn_issue.i1.html
