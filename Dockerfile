FROM ubuntu:15.10

MAINTAINER Sebastian Schoenherr <sebastian.schoenherr@i-med.ac.at>

#Root Dir
WORKDIR /

# Install some basic tools
RUN apt-get install sudo
RUN sudo apt-get install wget apt-transport-https software-properties-common  -y

#Install Prerequistes
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
RUN sudo add-apt-repository ppa:webupd8team/java
RUN wget http://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb -O cdh5-repository_1.0_all.deb
RUN sudo dpkg -i cdh5-repository_1.0_all.deb

# update packages
RUN sudo apt-get update -y

# Install Java v7
RUN sudo apt-get install oracle-java8-installer jsvc git maven -y

# copy scripts
ADD conf /usr/bin/
RUN sudo chmod +x /usr/bin/*

#Install latest CDH5 YARN
RUN sudo apt-get install hadoop-conf-pseudo -y
RUN sudo apt-get install spark-core spark-history-server spark-python -y
RUN sudo -u hdfs hdfs namenode -format

#Install a new user
RUN sudo useradd -ms /bin/bash cloudgene

# Credits to https://github.com/sequenceiq/hadoop-docker/blob/master/Dockerfile
#HDFS Ports
EXPOSE 50010 50020 50070 50075 50090
# History Server Port
EXPOSE 19888
#Yarn Ports
EXPOSE 8030 8031 8032 8033 8040 8042
#Yarn MapReduce Port
EXPOSE 8088
