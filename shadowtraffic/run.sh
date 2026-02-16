#!/usr/bin/env bash

set ver=1.14.5

docker run \
       --env-file "$(pwd)/license.env" \
       --net=host \
       -v "$(pwd)/root.json:/home/root.json" \
       -v "$(pwd)/data:/home/data" \
       -v "$(pwd)/connections:/home/connections" \
       -v "$(pwd)/generators:/home/generators" \
       shadowtraffic/shadowtraffic:$ver \
       --config /home/root.json
       
# Dry-run mode : --stdout --sample 10 