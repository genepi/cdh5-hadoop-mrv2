#!/bin/bash
# This script executes a grep command with MapReduce.

# Create an input directory
sudo -u cloudgene hadoop fs -mkdir input
# Add some data to the input directory
sudo -u cloudgene hadoop fs -put /etc/hadoop/conf/*.xml input
# Execute Wordcount
$ hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar grep input output23 'dfs[a-z.]+'
