#!/bin/bash
# Setting up HDFS and MapReduce at startup!

# start the HDFS Service generate all necessary directories
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do sudo service $x start ; done
sudo /usr/bin/init-hdfs.sh

# adapt MapReduce configuration. this needs some thinking. old parameters are not there anymore
# http://blog.cloudera.com/blog/2013/11/migrating-to-mapreduce-2-on-yarn-for-operators/
#sudo /usr/bin/adapt-mapred-config.sh

sudo -u hdfs hadoop fs -ls -R /
sudo service hadoop-yarn-resourcemanager start
sudo service hadoop-yarn-nodemanager start
sudo service hadoop-mapreduce-historyserver start

export HADOOP_MAPRED_HOME=/usr/lib/hadoop-mapreduce

# end with command line
/bin/bash
