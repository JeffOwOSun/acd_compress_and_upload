#!/usr/bin/zsh
#ASSUMPTION: LOCAL_DIR is a folder that's going to be compressed

TMP_DIR=/tmp/acd_compress/
LOCAL_DIR=$1
REMOTE_DIR=$2
VOLUME_SIZE=4g

BASE_NAME=$(basename $LOCAL_DIR)
REMOTE_DIR=$REMOTE_DIR/$BASE_NAME

#remove existing riles if any
rm $TMP_DIR$BASE_NAME.7z*

#===============upload a flag==================

#TODO flag for upload started
acd_cli mkdir -p $REMOTE_DIR/$BASE_NAME

#===============upload the files===============

#compress files
mkdir -p $TMP_DIR
7z a -mx0 -v$VOLUME_SIZE $TMP_DIR$(basename $LOCAL_DIR).7z $LOCAL_DIR

#upload it
acd_cli sync
acd_cli upload -max-connections 8 $TMP_DIR$(basename $LOCAL_DIR).7z* $REMOTE_DIR$(basename $LOCAL_DIR)

#remove 7z files
rm $TMP_DIR$(basename $LOCAL_DIR).7z*

#===============upload a flag==================

#TODO flag for upload stopped
