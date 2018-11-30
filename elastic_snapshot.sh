#!/bin/bash
SNAPSHOT=`/bin/date +%Y%m%d-%H%M%S`

/usr/bin/curl -XPUT "localhost:9200/_snapshot/elasticsearch/${SNAPSHOT}"