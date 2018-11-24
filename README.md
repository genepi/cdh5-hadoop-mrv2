# Creating a Hadoop MapReduce (MRv2 aka YARN) Docker Image

This Docker image allows you to execute Hadoop jobs with MapReduce based on YARN (MRv2, the "new" MapReduce) based on the currently latest Cloudera version (CDH5).


## Pull the image

	docker pull genepi/cdh5-hadoop-mrv2:latest
	

## Run the image

	docker run -it -p 8088:8088 genepi/cdh5-hadoop-mrv2:latest start-hadoop


## Execute WordCount 

	sh /usr/bin/execute-wordcount.sh


## Connect to the MapReduce web interface

    http://<ip-address>:8088
