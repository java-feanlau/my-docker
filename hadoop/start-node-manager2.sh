#!/bin/bash

echo "start hadoop-slave2 container..."
docker run -itd \
                --net=hadoop \
                -p 8044:8044 \
                -p 19890:19890 \
                -v `pwd`/config/yarn-site-nm2.xml:/usr/local/hadoop/etc/hadoop/yarn-site.xml \
                --net=hadoop \
                --name hadoop-slave2 \
                --hostname hadoop-slave2 \
                xuzh/hadoop:1.0

# get into hadoop master container
docker exec -it hadoop-slave2 bash
