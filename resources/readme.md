#### 本文件夹介绍

| 序号                   | 名称                          | 作用                                                         | 使用                                       | 反应机器 | 备注                                                         |
| ----------------------------- | ------------------------------------------------------------ | ------------------------------------------ | -------- | ------------------------------------------------------------ | ----------------------------- |
| 1      | get_mock_log_to_file.sh       | 模拟产生日志log文件落盘到本地                                | ./get_mock_log_to_file.sh args1 args2      | 1、2     | （两参数可不填）args1表示发送间隔时间，默认为0；args1表示一共发送多少条，默认为1000；执行文件 **logCollector-1.0-SNAPSHOT-jar-with-dependencies.jar** |
| 2            | flume-cluster1.sh             | 将本地log文件发送到 Kafka 中                                 | ./flume-cluster1.sh start/stop             | 1、2     | 执行对应文件 **file-flume-kafka.conf** |
| 3            | flume-cluster2.sh             | 将 Kafka 的log文件消息消费到 HDFS                            | ./flume-cluster2.sh start/stop             | 3        | 执行对应文件 **kafka-flume-hdfs.conf** |
| 4    | get_mock_data_to_mysql.sh     | 模拟生成业务数据存进 MySQL                                   | ./get_mock_data_to_mysql.sh                | 1        | 可以修改**application.properties** 的参数调整  ；执行文件 **gmall-mock-db-1.0-SNAPSHOT.jar** |
| 5             | mysql_to_hdfs.sh              | 将 MySQL 中业务数据写进HDFS中，并建lzo索引                   | ./mysql_to_hdfs.sh first/all 2020-07-10    | Hive，HDFS | first是为第一次操作 all每天都需要进行（就是有些表的数据是固定的，只要执行一次就OK） |
| 6    | create_hive_tables_ods.sh     | 创建 ods 层 的表                                       | ./create_hive_tables_ods.sh | Hive |    |
| 7 | create_hive_tables_dwd_log.sh | 创建 dwd 层 日志 的表 | ./create_hive_tables_dwd_log.sh | Hive |  |
| 8 | create_hive_tables_dwd_db.sh | 创建 dwd 层 业务 的表 | ./create_hive_tables_dwd_db.sh | Hive |  |
| 9 | create_hive_tables_dws.sh | 创建 dws 层 的表 | ./create_hive_tables_dws.sh | Hive |  |
| 10 | create_hive_tables_dwt.sh | 创建 dwt 层 的表 | ./create_hive_tables_dwt.sh | Hive |  |
| 11 | create_hive_tables_ads.sh | 创建 ads 层 的表 | ./create_hive_tables_ads.sh | Hive |  |
| 12     | hdfs_to_hive_ods_log.sh       | 将 hdfs 上的 日志文件 导进Hive表里，并建lzo索引              | ./hdfs_to_hive_log.sh 2020-07-10           | HDFS，Hive |                                                              |
| 13      | hdfs_to_hive_ods_db.sh        | 将 hdfs 上的 业务数据 导进Hive表里                           | ./hdfs_to_hive_log.sh first/all 2020-07-10 | HDFS，Hive | first是为第一次操作 all每天都需要进行（就是有些表的数据是固定的，只要执行一次就OK） |
| 14   | ods_to_dwd_start_log.sh       | 将 ods层 **启动日志** 数据 导进 dwd 层                      | ./ods_to_dwd_start_log.sh 2020-07-10 | Hive |                                                              |
| 15 | ods_to_dwd_base_event_log.sh  | 将 ods 层的 **行为日志** 炸裂开单条数据；存进 base_event_log 表中 | ./ods_to_dwd_base_event_log.sh 2020-07-10 | Hive | 使用到 **hivefunction-1.0-SNAPSHOT.jar** |
| 16     | ods_to_dwd_event_log.sh       | 将 base_event_log 的数据 进行分析，取出对应的数据存进对应的表 | ./ods_to_dwd_event_log.sh 2020-07-10 | Hive |                                                              |
| 17 | ods_to_dwd_db.sh | 将 ods层 业务数据 导进 dwd 层          | ./ods_to_dwd_db.sh first/all 2020-07-10 | Hive | first是为第一次操作 all每天都需要进行（就是有些表的数据是固定的，只要执行一次就OK） |
| 18            | dwd_to_dws.sh                      | 将 dwd层 业务数据 导进 dws 层            | ./dwd_to_dws.sh 2020-07-10 | Hive |                                                              |
| 19   | dws_to_dwt.sh | 将 dws层 业务数据 导进 dwt 层                   | ./dws_to_dwt.sh 2020-07-10 | Hive |                                                              |
| 20               | dwt_to_ads.sh                      | 将 dwt层 业务数据 导进 ads 层          | ./dwt_to_ads.sh 2020-07-10 | Hive |                                                              |
| 21   | hdfs_to_mysql.sh                   | 将 ads层 业务数据 导进 mysql                                 | ./hdfs_to_mysql.sh 表名 | Hive，Sqoop |                                                              |
| 22               | gmallv2.sql      | MySQL 原始的业务数据        |                                            |||
| 23 | gmallv_report.sql | 经过分析后的数据 | |||
| 24 | hadoop-lzo-0.4.21-SNAPSHOT.jar | Hadoop的**LZO**压缩jar | |||
| 25 | flume-interceptor-1.0-SNAPSHOT.jar | Flume 日志分析拦截器 | |||
| 26 | date_info.txt | 日期文件 | |||




