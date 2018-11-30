#!/bin/bash
#
LIMIT=1 #days
REPO=elasticsearch

SNAPSHOTS=`/usr/bin/curl -s -XGET "localhost:9200/_snapshot/${REPO}/_all" | /usr/bin/jq -r ".snapshots[:-${LIMIT}][].snapshot"`

for SNAPSHOT in ${SNAPSHOTS}
do
  echo "Deleting snapshot: ${SNAPSHOT}"
  /usr/bin/curl -s -XDELETE "localhost:9200/_snapshot/${REPO}/${SNAPSHOT}?pretty"
done
echo "Ok!"
exit 0
