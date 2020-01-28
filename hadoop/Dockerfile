FROM openjdk:8

ARG HADOOP_VERSION=2.6.0
ARG HIVE_VERSION=1.1.0

ENV HADOOP_HOME /opt/hadoop
ENV HIVE_HOME /opt/hive
ENV JAVA_HOME /usr/local/openjdk-8
ENV HADOOP_USER_CLASSPATH_FIRST true

RUN set -ex && \
  apt-get update && \
  apt-get install -y bash curl ssh pdsh

RUN mkdir -p /opt
WORKDIR /opt
ADD https://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz /opt
ADD https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz /opt
RUN tar -xzf hadoop-$HADOOP_VERSION.tar.gz && \
  ln -s /opt/hadoop-$HADOOP_VERSION /opt/hadoop
RUN tar -xzf apache-hive-$HIVE_VERSION-bin.tar.gz && \
  ln -s /opt/apache-hive-$HIVE_VERSION-bin /opt/hive


ADD conf/hadoop/*-site.xml $HADOOP_HOME/etc/hadoop/
ADD conf/ssh/config /root/.ssh/config

# create ssh keys
RUN \
  ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
  chmod 0600 ~/.ssh/authorized_keys


RUN echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
RUN echo "export HADOOP_USER_CLASSPATH_FIRST=true" >> ~/.bashrc
RUN echo "export HADOOP_USER_CLASSPATH_FIRST=true" >> $HIVE_HOME/conf/hive-env.sh
RUN echo "PATH=$PATH:$HADOOP_HOME/bin" >> ~/.bashrc
RUN echo "PATH=$PATH:$HIVE_HOME/bin" >> ~/.bashrc

ADD start-all.sh start-all.sh
ADD resources/hive/create-tables.hql create-tables.hql

EXPOSE 8090 9000 8032 8030 10000 10001

CMD bash start-all.sh

