# rocketmq-4.1.0-incubating

## name server
新建name server镜像
```
cd namesrv
docker build -t rocketmq/namesrv .
```

运行name server, 替换配置文件，缩小Xmx内存，容器内存512m
```
docker run -d -m 512m -p 9876:9876 -v /Users/helechen/IdeaProjects/my-docker/rocketmq-4.1.0-incubating/namesrv/runserver.sh:/opt/rocketmq-4.1.0-incubating/bin/runserver.sh --name rmqnamesrv rocketmq/namesrv
```

确认运行OK
```
docker ps
docker top a6954dce5621
PID                 USER                TIME                COMMAND
4772                root                0:00                /bin/sh -c cd ${ROCKETMQ_HOME}/bin && export JAVA_OPT=" -Duser.home=/opt" && sh mqnamesrv
4791                root                0:00                sh mqnamesrv
4792                root                0:00                sh /opt/rocketmq-4.1.0-incubating/bin/runserver.sh org.apache.rocketmq.namesrv.NamesrvStartup
4794                root                0:01                /usr/lib/jvm/java-8-openjdk-amd64/bin/java -Duser.home=/opt -server -Xms768m -Xmx768m -XX:PermSize=128m -XX:MaxPermSize=320m -XX:+UseConcMarkSweepGC -XX:+UseCMSCompactAtFullCollection -XX:CMSInitiatingOccupancyFraction=70 -XX:+CMSParallelRemarkEnabled -XX:SoftRefLRUPolicyMSPerMB=0 -XX:+CMSClassUnloadingEnabled -XX:SurvivorRatio=8 -XX:+DisableExplicitGC -XX:-UseParNewGC -verbose:gc -Xloggc:/dev/shm/rmq_srv_gc.log -XX:+PrintGCDetails -XX:-OmitStackTraceInFastThrow -XX:-UseLargePages -Djava.ext.dirs=/opt/rocketmq-4.1.0-incubating/bin/../lib -cp .:/opt/rocketmq-4.1.0-incubating/bin/../conf: org.apache.rocketmq.namesrv.NamesrvStartup
```

退出运行
```
docker stop a6954dce5621
docker rm a6954dce5621
```

进去container
```
docker exec -it a6954dce5621 /bin/bash
```

## broker

新建broker镜像
```
cd broker
docker build -t rocketmq/broker .
```

运行broker-a-m，也就是broker group a的master, 替换配置文件conf，缩小Xmx内存
```
docker run -d --link=rmqnamesrv -p 10909:10909 -p 10911:10911 -v /Users/helechen/IdeaProjects/my-docker/rocketmq-4.1.0-incubating/broker/runserver.sh:/opt/rocketmq-4.1.0-incubating/bin/runserver.sh \
  -v /Users/helechen/IdeaProjects/my-docker/rocketmq-4.1.0-incubating/broker/runbroker.sh:/opt/rocketmq-4.1.0-incubating/bin/runbroker.sh \
  -v /Users/helechen/IdeaProjects/my-docker/rocketmq-4.1.0-incubating/broker/broker-a-m.conf:/opt/rocketmq-4.1.0-incubating/conf/broker.conf \
  --name rmqbroker-a-m rocketmq/broker
```

运行broker-a-s，也就是broker group a的slave, 替换配置文件conf，缩小Xmx内存
```
docker run -d --link=rmqnamesrv -p 10910:10910 -p 10912:10912 -v /Users/helechen/IdeaProjects/my-docker/rocketmq-4.1.0-incubating/broker/runserver.sh:/opt/rocketmq-4.1.0-incubating/bin/runserver.sh \
  -v /Users/helechen/IdeaProjects/my-docker/rocketmq-4.1.0-incubating/broker/runbroker.sh:/opt/rocketmq-4.1.0-incubating/bin/runbroker.sh \
  -v /Users/helechen/IdeaProjects/my-docker/rocketmq-4.1.0-incubating/broker/broker-a-s.conf:/opt/rocketmq-4.1.0-incubating/conf/broker.conf \
  --name rmqbroker-a-s rocketmq/broker
```

## mqadmin

[命令](http://jameswxx.iteye.com/blog/2091971)
[official commands](http://rocketmq.apache.org/docs/rmq-deployment/)

- clusterList
```
sh mqadmin clusterList -n 'localhost:9876'
#Cluster Name     #Broker Name            #BID  #Addr                  #Version                #InTPS(LOAD)       #OutTPS(LOAD) #PCWait(ms) #Hour #SPACE
DefaultCluster    broker-a                0     localhost:10911        V4_1_0_SNAPSHOT          0.00(0,0ms)         0.00(0,0ms)          0 422436.95 0.0151
DefaultCluster    broker-a                1     localhost:10912        V4_1_0_SNAPSHOT          0.00(0,0ms)         0.00(0,0ms)          0 422436.95 -1.0000
```

- brokerStatus
```
sh mqadmin brokerStatus -n 'localhost:9876' -c DefaultCluster
localhost:10911          bootTimestamp                   : 1520772974542
localhost:10911          brokerVersion                   : 232
localhost:10911          brokerVersionDesc               : V4_1_0_SNAPSHOT
localhost:10911          commitLogDirCapacity            : Total : 59.0 GiB, Free : 58.1 GiB.
....
```

- topicList
```
sh mqadmin topicList -n 'localhost:9876'
BenchmarkTest
OFFSET_MOVED_EVENT
TopicTest
broker-a
TBW102
SELF_TEST_TOPIC
DefaultCluster
```

- topicClusterList
```
sh mqadmin topicClusterList -n 'localhost:9876' -t TopicTest
DefaultCluster
```

- updateTopic
```
sh mqadmin updateTopic -n 'localhost:9876' -c DefaultCluster -t TopicTest
```

- topicRoute
```
sh mqadmin topicRoute -n 'localhost:9876' -t TopicTest
{
	"brokerDatas":[
		{
			"brokerAddrs":{0:"localhost:10911",1:"localhost:10912"
			},
			"brokerName":"broker-a",
			"cluster":"DefaultCluster"
		}
	],
	"filterServerTable":{},
	"queueDatas":[
		{
			"brokerName":"broker-a",
			"perm":6,
			"readQueueNums":4,
			"topicSynFlag":0,
			"writeQueueNums":4
		}
	]
}
```

- topicStatus
```
h mqadmin topicStatus -n 'localhost:9876' -t TopicTest
#Broker Name                      #QID  #Min Offset           #Max Offset             #Last Updated
broker-a                          0     0                     680                     2018-03-11 20:58:30,695
broker-a                          1     0                     680                     2018-03-11 20:57:47,598
broker-a                          2     0                     678                     2018-03-11 20:57:47,599
broker-a                          3     0                     680                     2018-03-11 20:57:47,600
```

- consumerProgress
```
sh mqadmin consumerProgress -n 'localhost:9876'
#Group                            #Count  #Version                 #Type  #Model          #TPS     #Diff Total
please_rename_unique_group_name_  1       V4_1_0_SNAPSHOT          PUSH   CLUSTERING      0        0
```

- consumerStatus
```
sh mqadmin consumerStatus -n 'localhost:9876'  -g please_rename_unique_group_name_4
001  192.168.1.104@14365                      V4_1_0_SNAPSHOT      1520774098587/192.168.1.104@14365

Same subscription in the same group of consumer

Rebalance OK
```

- queryMsgById
```
sh mqadmin queryMsgById -n 'localhost:9876' -i 7F00000100002A9F00000000000735FA
OffsetID:            7F00000100002A9F00000000000735FA
OffsetID:            7F00000100002A9F00000000000735FA
Topic:               TopicTest
Tags:                [TagA]
Keys:                [null]
Queue ID:            1
Queue Offset:        657
CommitLog Offset:    472570
Reconsume Times:     0
Born Timestamp:      2018-03-11 20:57:47,471
Store Timestamp:     2018-03-11 20:57:47,472
Born Host:           172.17.0.1:47300
Store Host:          127.0.0.1:10911
System Flag:         0
Properties:          {UNIQ_KEY=C0A80168378C4617C26437FF22CF038D, WAIT=true, TAGS=TagA}
Message Body Path:   /tmp/rocketmq/msgbodys/C0A80168378C4617C26437FF22CF038D


MessageTrack [consumerGroup=please_rename_unique_group_name_4, trackType=NOT_CONSUME_YET, exceptionDesc=null]
```