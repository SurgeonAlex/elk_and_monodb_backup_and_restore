#!/bin/bash
# initialize snapshot directory in JSON format
ADD_YOUR_NAME_REPO_HERE=elasticsearch
ADD_LOCATION_HERE=/opt/backup/elasticsearch

curl -XPUT "http://localhost:9200/_snapshot/${ADD_YOUR_NAME_REPO_HERE}" -d '{
    "type": "fs",
    "settings": {
        "location": "'${ADD_LOCATION_HERE}'",
        "compress": true
    }
}'
