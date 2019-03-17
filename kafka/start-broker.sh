#!/bin/bash

cd kafka_2.11-0.10.0.1 && nohup bin/kafka-server-start.sh config/server-$1.properties &
