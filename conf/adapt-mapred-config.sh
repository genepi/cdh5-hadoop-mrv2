# calculates the amount of processors and sets the map and reduce tasks accordingly
line=$(($(grep -c ^processor /proc/cpuinfo)-1))
sed s/AMOUNT/$line/ /usr/bin/mapred-site-template.xml > /etc/hadoop/conf.pseudo/mapred-site.xml


