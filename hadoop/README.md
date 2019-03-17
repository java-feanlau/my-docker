## Run Hadoop Cluster within Docker Containers

- Blog: [Run Hadoop Cluster in Docker Update](http://kiwenlau.com/2016/06/26/hadoop-cluster-docker-update-english/)
- 博客: [基于Docker搭建Hadoop集群之升级版](http://kiwenlau.com/2016/06/12/160612-hadoop-cluster-docker-update/)


![alt tag](https://raw.githubusercontent.com/kiwenlau/hadoop-cluster-docker/master/hadoop-cluster-docker.png)

**!!! Note that only hadoop-slave1 will be run in this forked project.**

### Nodes Hadoop Cluster

##### 1. create hadoop network

```
docker network create --driver=bridge hadoop
```

##### 2. Create image locally

```
docker build -t xuzh/hadoop:1.0 .
```

you can check by running:
```
$ docker images
```

##### 4. start docker container and login to hadoop-master

```
cd hadoop-cluster-docker
./start-resource-manager.sh
```

##### 5. start hadoop

```
./start-hadoop.sh
```

##### 6. start job history server

```
./start-historyserver.sh
```

##### 7. configure /etc/hosts

add the following to /etc/hosts
```
127.0.0.1       hadoop-master
```

##### 8. visit hadoop yarn resource manager

```
http://hadoop-master:8088
```

If you can open the page, then everything is done.

##### 9. stop

```
docker stop <CONTAINER_ID>
or
docker rm -f <CONTAINER_ID>
```

##### 10. zookeeper
安装：
```
wget http://mirror.bit.edu.cn/apache/zookeeper/stable/zookeeper-3.4.13.tar.gz && \
    tar -xzf zookeeper-3.4.13.tar.gz && \
    mv zookeeper-3.4.13/conf/zoo_sample.cfg  zookeeper-3.4.13/conf/zoo.cfg && \
    zookeeper-3.4.13/bin/zkServer.sh start
```

验证：
```
bin/zkCli.sh -server hadoop-master:2181
```