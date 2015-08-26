FROM ubuntu:14.04

MAINTAINER Sebastian Schoenherr <sebastian.schoenherr@i-med.ac.at>

#Root Dir
WORKDIR /

# Install some basic tools
RUN sudo apt-get install wget software-properties-common -y

#Install Prerequistes
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
RUN sudo add-apt-repository ppa:webupd8team/java
RUN wget http://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb -O cdh5-repository_1.0_all.deb
RUN sudo dpkg -i cdh5-repository_1.0_all.deb

# update packages
RUN sudo apt-get update -y

# Install Java v7
RUN sudo apt-get install oracle-java7-installer -y

#Install latest CDH5 YARN
RUN sudo apt-get install hadoop-conf-pseudo -y
RUN sudo -u hdfs hdfs namenode -format

#Install a new user
RUN sudo useradd -ms /bin/bash cloudgene

# copy script to start HDFS and MapReduce
COPY conf/run-hadoop.sh /usr/bin/run-hadoop.sh
RUN sudo chmod +x /usr/bin/run-hadoop.sh

# generate some HDFS directories at startup
COPY conf/init-hdfs.sh /usr/bin/init-hdfs.sh
RUN sudo chmod +x /usr/bin/init-hdfs.sh

# Use a template to calculate the amount of map and reduce tasks depending on amount of cores
COPY conf/mapred-site-template.xml /usr/bin/mapred-site-template.xml
COPY conf/adapt-mapred-config.sh /usr/bin/adapt-mapred-config.sh
RUN sudo chmod +x /usr/bin/adapt-mapred-config.sh


COPY conf/execute-wordcount.sh /usr/bin/execute-wordcount.sh
RUN sudo chmod +x /usr/bin/execute-wordcount.sh

# MapReduce (50030), HDFS (50070) and Cloudgene (8080) Port
EXPOSE 50030 50070 8080

# run the start script when launching a docker container
CMD ["/usr/bin/run-hadoop.sh"]
