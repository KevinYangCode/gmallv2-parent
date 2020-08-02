#!/bin/bash
JAVA_BIN=/opt/module/jdk1.8.0_241/bin/java
PROJECT=gmallv2
APPNAME=logCollector-1.0-SNAPSHOT-jar-with-dependencies.jar

for i in hadoop101 hadoop102
do
    echo "========执行生成日志: $i==============="
    ssh $i  "source /etc/profile;java -jar /opt/module/datas/$PROJECT/$APPNAME $1 $2 >/dev/null 2>&1 &"
done

