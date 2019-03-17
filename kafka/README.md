# MySQL

注意：kafka依赖的mq在hadoop-master这个image上。

## build docker image
```
cd kafka
docker build -t kafka:0.10.0.1 .
```

## run broker-N
```
docker run -itd \
      --net=hadoop \
      -p 9093:9093 \
      -p 9094:9094 \
      -p 9095:9095 \
      -p 9096:9096 \
      -v /Users/xu/IdeaProjects/my-docker/kafka/server-1.properties:/root/kafka_2.11-0.10.0.1/config/server-1.properties \
      -v /Users/xu/IdeaProjects/my-docker/kafka/server-2.properties:/root/kafka_2.11-0.10.0.1/config/server-2.properties \
      -v /Users/xu/IdeaProjects/my-docker/kafka/server-3.properties:/root/kafka_2.11-0.10.0.1/config/server-3.properties \
      -v /Users/xu/IdeaProjects/my-docker/kafka/server-4.properties:/root/kafka_2.11-0.10.0.1/config/server-4.properties \
      --name kafka-broker \
      --hostname kafka-broker \
      kafka:0.10.0.1
```

## go into container
```
docker exec -it kafka-broker /bin/bash
```

### start/stop container
可以保留数据现场
```
docker stop kafka-broker
docker start kafka-broker
```

## commands
```
sh start-broker.sh 1
sh start-broker.sh 2
sh start-broker.sh 3
sh start-broker.sh 4

sh tail-server-log.sh
```

## kafka-examples

[https://github.com/neoremind/kafka-example](https://github.com/neoremind/kafka-example)

create topic
```
bin/kafka-topics.sh --create --zookeeper hadoop-master:2181 --replication-factor 3 --partitions 3 --topic my-flink-test
```

check topic
```
bin/kafka-topics.sh --describe --zookeeper hadoop-master:2181 --topic my-flink-test
```

publish some messages
```
bin/kafka-console-producer.sh --broker-list localhost:9093 --topic my-flink-test
```