## 开始

## resources文件夹


| 名称                          | 作用                                                         | 使用                                       | 操作机器 | 备注                                                         |
| ----------------------------- | ------------------------------------------------------------ | ------------------------------------------ | -------- | ------------------------------------------------------------ |
| get_mock_log_to_file.sh       | 模拟产生日志log文件落盘到本地                                | ./get_mock_log_to_file.sh                  | 1、2     |                                                              |
| flume-cluster1.sh             | 将本地log文件发送到 Kafka 中                                 | ./flume-cluster1.sh start/stop             | 1、2     |                                                              |
| flume-cluster2.sh             | 将 Kafka 的log文件消息消费到 HDFS                            | ./flume-cluster2.sh start/stop             | 3        |                                                              |
| get_mock_data_to_mysql.sh     | 模拟生成业务数据存进 MySQL                                   | ./get_mock_data_to_mysql.sh                | 1        | 可以修改application.properties 的参数调整                    |
| mysql_to_hdfs.sh              | 将 MySQL 中业务数据写进HDFS中，并建lzo索引                   | ./mysql_to_hdfs.sh first/all 2020-07-10    | 1        | first是为第一次操作 all每天都需要进行（就是有些表的数据是固定的，只要执行一次就OK） |
| create_hive_tables_ods.sh     | 创建 ods 层 所用到的表                                       | ./create_hive_tables.sh ods_log/ods_info   | 1、2、3  | ods_log是ODS层 用户行为数据表 / ods_info是ODS层 业务数据表   |
| hdfs_to_hive_ods_log.sh       | 将 hdfs 上的 日志文件 导进Hive表里，并建lzo索引              | ./hdfs_to_hive_log.sh 2020-07-11           |          |                                                              |
| hdfs_to_hive_ods_db.sh        | 将 hdfs 上的 业务数据 导进Hive表里                           | ./hdfs_to_hive_log.sh first/all 2020-07-11 |          | first是为第一次操作 all每天都需要进行（就是有些表的数据是固定的，只要执行一次就OK） |
| create_hive_tables_dwd_log.sh | 创建 dwd 层 日志数据 所用到的表                              |                                            |          |                                                              |
| ods_to_dwd_start_log.sh       | 将 ods层 start_log 数据 导进 dwd 层                          |                                            |          |                                                              |
| ods_to_dwd_base_event_log.sh  | 将 ods 层的行为日志 炸裂开单条数据；存进 base_event_log 表中 |                                            |          |                                                              |
| ods_to_dwd_event_log.sh       | 将 base_event_log 的数据 进行分析，取出对应的数据存进对应的表 |                                            |          |                                                              |
| create_hive_tables_dwd_db.sh  | 创建 dwd 层 业务数据 所用到的表                              |                                            |          |                                                              |
| ods_to_dwd_db.sh              | 将 ods层 业务数据 导进 dwd 层                                |                                            |          |                                                              |
| create_hive_tables_dws.sh     | 创建 dws 层 所用到的表                                       |                                            |          |                                                              |
| dwd_to_dws.sh                 | 将 dwd层 业务数据 导进 dws 层                                |                                            |          |                                                              |
| create_hive_tables_dwt.sh     | 创建 dwt 层 所用到的表                                       |                                            |          |                                                              |
| dws_to_dwt.sh                 | 将 dws层 业务数据 导进 dwt 层                                |                                            |




