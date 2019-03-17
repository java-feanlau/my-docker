# Start from a Java image.
FROM java:8

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y -q vim bzr gdb openssh-server less

WORKDIR /root

RUN echo 'root:root' | chpasswd
RUN mkdir -p /var/run/sshd

RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

RUN wget https://archive.apache.org/dist/kafka/0.10.0.1/kafka_2.11-0.10.0.1.tgz && \
    tar -xzf kafka_2.11-0.10.0.1.tgz

COPY start-broker.sh /root
COPY tail-server-log.sh /root

RUN chmod +x kafka_2.11-0.10.0.1/bin/kafka-server-start.sh
RUN chmod +x kafka_2.11-0.10.0.1/bin/kafka-server-stop.sh

VOLUME /opt