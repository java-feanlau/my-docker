#!/bin/bash

echo "start hadoop-slave1 container..."
docker run -itd \
                --net=hadoop \
                -p 8043:8043 \
                -p 19889:19889 \
                -v `pwd`/config/yarn-site-nm1.xml:/usr/local/hadoop/etc/hadoop/yarn-site.xml \
                --net=hadoop \
                --name hadoop-slave1 \
                --hostname hadoop-slave1 \
                xuzh/hadoop:1.0

# get into hadoop master container
docker exec -it hadoop-slave1 bash
