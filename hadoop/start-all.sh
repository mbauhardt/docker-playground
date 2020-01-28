# start ssh server
/etc/init.d/ssh start
 
# format namenode
$HADOOP_HOME/bin/hdfs namenode -format
 
# start hadoop
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh
$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh start historyserver


$HADOOP_HOME/bin/hadoop fs -mkdir -p /tmp
$HADOOP_HOME/bin/hadoop fs -mkdir -p /user/hive/warehouse
$HADOOP_HOME/bin/hadoop fs -chmod -R 777 /tmp
$HADOOP_HOME/bin/hadoop fs -chmod -R 777 /user/hive/warehouse
$HIVE_HOME/bin/schematool -dbType derby -initSchema
$HIVE_HOME/bin/hiveserver2 &
sleep 10
$HIVE_HOME/bin/beeline -u jdbc:hive2://localhost:10000/default -i create-tables.hql


echo -e "#####################\n"
echo -e "\nHadoop started! Run example job by executing 'bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar pi 3 10'"
echo -e "Hive Server 2 is started as well."


tail -f /dev/null

