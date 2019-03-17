FROM ubuntu:16.04

MAINTAINER xu <xuzh1002@gmail.com>

WORKDIR /root

RUN apt-get update && apt-get install -y openssh-server openjdk-8-jdk wget net-tools less vim iputils-ping netcat unzip

# install hadoop 2.7.2
RUN wget http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz && \
    tar -xzf hadoop-2.7.7.tar.gz && \
    mv hadoop-2.7.7 /usr/local/hadoop && \
    rm hadoop-2.7.7.tar.gz

# install flink 1.7.2
RUN wget http://mirror.bit.edu.cn/apache/flink/flink-1.7.2/flink-1.7.2-bin-hadoop27-scala_2.12.tgz && \
    tar -xzf flink-1.7.2-bin-hadoop27-scala_2.12.tgz

RUN wget http://mirror.bit.edu.cn/apache/zookeeper/stable/zookeeper-3.4.13.tar.gz && \
    tar -xzf zookeeper-3.4.13.tar.gz

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 
ENV HADOOP_HOME=/usr/local/hadoop 
ENV HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN mkdir -p ~/hdfs/namenode && \ 
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/start-dfs.sh ~/start-dfs.sh && \
    mv /tmp/start-yarn.sh ~/start-yarn.sh && \
    mv /tmp/stop-yarn.sh ~/stop-yarn.sh && \
    mv /tmp/start-zookeeper.sh ~/start-zookeeper.sh && \
    mv /tmp/start-historyserver.sh ~/start-historyserver.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh && \
    mv /tmp/zoo.cfg  ~/zookeeper-3.4.13/conf/zoo.cfg

RUN chmod +x ~/start-hadoop.sh && \
    chmod +x ~/start-dfs.sh && \
    chmod +x ~/start-yarn.sh && \
    chmod +x ~/stop-yarn.sh && \
    chmod +x ~/start-zookeeper.sh && \
    chmod +x ~/start-historyserver.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh && \
    chmod +x $HADOOP_HOME/sbin/mr-jobhistory-daemon.sh

# format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format
#RUN /usr/local/hadoop/bin/hdfs dfs -mkdir /user/root/output

CMD [ "sh", "-c", "service ssh start; bash"]