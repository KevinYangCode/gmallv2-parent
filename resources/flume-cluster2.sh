#!/bin/bash
MODULE=/opt/module/flume-1.7.0

case $1 in
"start"){
    for i in hadoop103
    do
        echo "=================       $i正在启动Flume       ==============="
        ssh kevin@$i "source /etc/profile;nohup $MODULE/bin/flume-ng agent -n a1 -c conf/ -f $MODULE/jobs/kafka-flume-hdfs.conf -Dflume.root.logger=INFO,LOGFILE >$MODULE/logs/flume-cluster2.log 2>&1 &"
    done	
};;

"stop"){
    for i in hadoop103
    do
        echo "=================       $i停止采集 Flume      ==============="
	ssh $i "ps -ef | grep kafka-flume-hdfs.conf | grep -v grep | awk '{print \$2}' | xargs kill -9"
    done
};;
esac
