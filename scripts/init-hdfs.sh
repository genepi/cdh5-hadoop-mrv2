#!/bin/bash -ex
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Use this script to initialize HDFS directory structure for various components to run. This script can be run from any node in the Hadoop cluster but should only be run once by one node only. If you are planning on using oozie, we recommend that you run this script from a node that has hive, pig, sqoop, etc. installed. Unless you are using psuedo distributed cluster, this node is most likely NOT your namenode
# Steps to be performed before running this script:
# 1. Stop the namenode and datanode services if running.
# 2. Format namenode (su -s /bin/bash hdfs hdfs namenode -format).
# 3. Start the namenode and datanode services on appropriate nodes.
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -mkdir -p /tmp'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -chmod -R 1777 /tmp'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -mkdir -p /var'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -mkdir -p /var/log'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -chmod -R 1775 /var/log'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -chown yarn:mapred /var/log'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -mkdir -p /tmp/hadoop-yarn'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -mkdir -p /tmp/hadoop-yarn/staging/history/done_intermediate'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn/staging'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -chmod -R 1777 /tmp'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -mkdir -p /var/log/hadoop-yarn/apps'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -chmod -R 1777 /var/log/hadoop-yarn/apps'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -chown yarn:mapred /var/log/hadoop-yarn/apps'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -mkdir -p /user'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -mkdir -p /user/history'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -chown mapred /user/history'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -mkdir -p /user/root'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -chmod -R 777 /user/root'
su -s /bin/bash hdfs -c '/usr/bin/hadoop fs -chown root /user/root'

# Cloudgene specific
sudo -u hdfs hadoop fs -mkdir -p /user/cloudgene
sudo -u hdfs hadoop fs -chown cloudgene /user/cloudgene



