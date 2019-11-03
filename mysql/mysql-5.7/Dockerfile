FROM ubuntu:16.04

WORKDIR /root

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y -q vim bzr git gdb openssh-server netcat unzip wget openjdk-8-jdk net-tools less iputils-ping

RUN echo 'root:root' | chpasswd
RUN mkdir -p /var/run/sshd

RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

RUN DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install mysql-server-5.7

RUN /etc/init.d/mysql start \
    && sleep 5 \
    && mysql -u root -e " \
      SET PASSWORD = PASSWORD('mysql'); \
      UPDATE mysql.user SET authentication_string = PASSWORD('mysql') WHERE user = 'root'; \
      GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'mysql' WITH GRANT OPTION; \
      GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' IDENTIFIED BY 'repl'; \
      GRANT ALL ON *.* TO 'mysql'@'%' IDENTIFIED BY 'mysql'" \
    && /etc/init.d/mysql stop

CMD /etc/init.d/mysql start && tail -f /var/log/mysql/error.log

EXPOSE 22 3307

VOLUME /opt