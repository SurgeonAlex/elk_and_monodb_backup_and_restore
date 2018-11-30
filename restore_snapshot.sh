#!/bin/bash
#
# READ ALL BEFORE RESTORE PROCESS!
# SETTING YOUR REPO FIRST IF YOU RESTORE ON A NEW SERVER!
# Insert your repository name in REPO variable and choice your snapshot name.
# Find SNAPSHOT_NAME - curl -s -XGET "localhost:9200/_snapshot/$REPO/_all?pretty" or use this script!
# If you use kibana, close kibana indices - curl -s -XPOST "localhost:9200/.kibana/_close", and
# retsore elasticsearch database. Open .kibana indices after restore process - curl -s -XPOST "localhost:9200/.kibana/_open"
# Administrators are divided into two categories - those who backup and those who still do not backup.
# ALL INDICES - curl -s -XGET "localhost:9200/_cat/indices?v"
# You can use two methods for restore
# the first method: determine SNAPSHOT_NAME using this script and restore process.
# the second method:
# specify the line argument on this script ./restore_snapshot.sh 20181130-050002

REPO=elasticsearch

if test $# -eq "1"; then
  SNAPSHOT_NAME=$1
  echo ${SNAPSHOT_NAME}
else
  SNAPSHOTS=`/usr/bin/curl -s -XGET "localhost:9200/_snapshot/${REPO}/_all?pretty" | /usr/bin/jq -r ".snapshots[].snapshot"`
    for SNAPSHOT in ${SNAPSHOTS}
      do
      echo "snapshotname : ${SNAPSHOT}"
    done
fi
echo "Ok!"

if [ ! -z "$SNAPSHOT_NAME" ]; then
  read -p "use _restore?wait_for_completion=true on restore (y/n)?" choice

  case "$choice" in 
  y|Y ) RESTORE=`/usr/bin/curl -s -XPOST "localhost:9200/_snapshot/${REPO}/${SNAPSHOT_NAME}/_restore?wait_for_completion=true"`;;
  n|N ) RESTORE=`/usr/bin/curl -s -XPOST "localhost:9200/_snapshot/${REPO}/${SNAPSHOT_NAME}/_restore"`;;
  * ) echo "invalid";;
  esac
else
  read -p "Press enter snapshot name: " SNAPSHOT_NAME

  if [ "$SNAPSHOT_NAME" = '' ]; then
  echo "${SNAPSHOT_NAME} is empty exit 1!"
  exit 1
  else
  read -p "use _restore?wait_for_completion=true on restore (y/n)?" choice
  case "$choice" in 
  y|Y ) RESTORE=`/usr/bin/curl -s -XPOST "localhost:9200/_snapshot/${REPO}/${SNAPSHOT_NAME}/_restore?wait_for_completion=true"`;;
  n|N ) RESTORE=`/usr/bin/curl -s -XPOST "localhost:9200/_snapshot/${REPO}/${SNAPSHOT_NAME}/_restore"`;;
  * ) echo "invalid";;
  esac
  fi
fi
echo "${RESTORE} Ok!"
exit 0
