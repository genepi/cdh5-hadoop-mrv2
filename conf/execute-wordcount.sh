sudo -u cloudgene hadoop fs -mkdir input
sudo -u cloudgene hadoop fs -put /etc/hadoop/conf/*.xml input
sudo -u cloudgene /usr/bin/hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar wordcount input output
