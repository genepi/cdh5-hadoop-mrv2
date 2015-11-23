#!/bin/bash
# This script executes the "Hello World" of MapReduce.

# Create an input directory
sudo -u cloudgene hadoop fs -mkdir input
# Add some data to the input directory
sudo -u cloudgene hadoop fs -put /etc/hadoop/conf/*.xml input
# Execute Wordcount
sudo -u cloudgene /usr/bin/hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar wordcount input output
