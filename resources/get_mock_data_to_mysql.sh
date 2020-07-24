#!/bin/bash
JAVA_BIN=/opt/module/jdk1.8.0_241/bin/java
PROJECT=gmallv2
APPNAME=gmall-mock-db-1.0-SNAPSHOT.jar

source /etc/profile;
java -jar /opt/module/datas/$PROJECT/$APPNAME

