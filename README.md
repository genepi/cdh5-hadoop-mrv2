## Creating a Docker Image for Cloudera's distribution of Hadoop MapReduce (MRv2 aka YARN)

This Docker image allows you to execute Hadoop jobs with MapReduce based on YARN (MRv2, the "new" MapReduce) based on the currently latest Cloudera version (CDH5).


# Pull the image

	docker pull seppinho/cdh5-hadoop-mrv2:latest
	

# Run the image

	docker run -it -p 8088:8088 seppinho/cdh5-hadoop-mrv2:latest run-hadoop-initial.sh


# Give it a try and execute WordCount inside the started Docker container

	sh /usr/bin/execute-wordcount.sh


# Connect to the MapReduce web interface from your local OS to see the status of your executed job

    http://localhost:8088
