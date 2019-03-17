#!/bin/bash

echo "start hadoop-master container..."
docker run -itd \
                --net=hadoop \
                -p 2181:2181 \
                -p 50070:50070 \
                -p 8088:8088 \
                -p 8042:8042 \
                -p 19888:19888 \
                -v `pwd`/config/yarn-site-rm.xml:/usr/local/hadoop/etc/hadoop/yarn-site.xml \
                --net=hadoop \
                --name hadoop-master \
                --hostname hadoop-master \
                xuzh/hadoop:1.0

# get into hadoop master container
docker exec -it hadoop-master bash
