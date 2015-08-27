#!/bin/bash

# start HDFS and generate directories
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do sudo service $x start ; done
sudo /usr/bin/init-hdfs.sh

sudo service hadoop-yarn-resourcemanager start
sudo service hadoop-yarn-nodemanager start
sudo service hadoop-mapreduce-historyserver start

export HADOOP_MAPRED_HOME=/usr/lib/hadoop-mapreduce

# end with command line
/bin/bash
