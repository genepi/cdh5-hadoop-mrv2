FROM ubuntu:14.04

MAINTAINER Sebastian Schoenherr <sebastian.schoenherr@i-med.ac.at>

#Root Dir
WORKDIR /

# Install some basic tools
RUN sudo apt-get install wget software-properties-common  -y

#Install Prerequistes
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
RUN sudo add-apt-repository ppa:webupd8team/java
RUN wget http://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb -O cdh5-repository_1.0_all.deb
RUN sudo dpkg -i cdh5-repository_1.0_all.deb

# update packages
RUN sudo apt-get update -y
RUN sudo apt-get install jsvc -y
# Install Java v7
RUN sudo apt-get install oracle-java7-installer -y

#Install latest CDH5 YARN
RUN sudo apt-get install hadoop-conf-pseudo -y
RUN sudo -u hdfs hdfs namenode -format

#Install a new user
RUN sudo useradd -ms /bin/bash cloudgene

# copy script to start HDFS and MapReduce
COPY conf/run-hadoop-initial.sh /usr/bin/run-hadoop-initial.sh
RUN sudo chmod +x /usr/bin/run-hadoop-initial.sh

# generate some HDFS directories at startup
COPY conf/init-hdfs.sh /usr/bin/init-hdfs.sh
RUN sudo chmod +x /usr/bin/init-hdfs.sh

# Use a template to calculate the amount of map and reduce tasks depending on amount of cores
COPY conf/mapred-site-template.xml /usr/bin/mapred-site-template.xml
COPY conf/adapt-mapred-config.sh /usr/bin/adapt-mapred-config.sh
RUN sudo chmod +x /usr/bin/adapt-mapred-config.sh

COPY conf/execute-wordcount.sh /usr/bin/execute-wordcount.sh
RUN sudo chmod +x /usr/bin/execute-wordcount.sh

# Credits to https://github.com/sequenceiq/hadoop-docker/blob/master/Dockerfile
#HDFS Ports
EXPOSE 50010 50020 50070 50075 50090
# History Server Port
EXPOSE 19888
#Yarn Ports
EXPOSE 8030 8031 8032 8033 8040 8042
#Yarn MapReduce Port
EXPOSE 8088
