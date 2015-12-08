#!/bin/sh
TMP_DIR=/tmp/acd_compress/
LOCAL_DIR=$1
REMOTE_DIR=$2
VOLUME_SIZE=4000m

#remove existing riles if any
rm $TMP_DIR$(basename $LOCAL_DIR).7z*

#compress files
mkdir -p $TMP_DIR
7z a -mx0 -v$VOLUME_SIZE $TMP_DIR$(basename $LOCAL_DIR).7z $LOCAL_DIR

#upload it
acd_cli sync
acd_cli upload $TMP_DIR$(basename $LOCAL_DIR).7z* $REMOTE_DIR

#remove 7z files
rm $TMP_DIR$(basename $LOCAL_DIR).7z*