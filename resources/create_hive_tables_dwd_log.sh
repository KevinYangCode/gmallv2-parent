#!/bin/bash

# 定义变量方便修改
APP=gmall
hive=/opt/module/hive-2.3.6/bin/hive

sql="
    drop table if exists ${APP}.dwd_newsdetail_log; 
    CREATE EXTERNAL TABLE ${APP}.dwd_newsdetail_log(
        mid_id string, 
        user_id string, 
        version_code string, 
        version_name string, 
        lang string, 
        source string, 
        os string, 
        area string, 
        model string, 
        brand string, 
        sdk_version string, 
        gmail string, 
        height_width string, 
        app_time string,
        network string, 
        lng string, 
        lat string, 
        entry string, 
        action string, 
        goodsid string, 
        showtype string, 
        news_staytime string,
        loading_time string, 
        type1 string, 
        category string, 
        server_time string
    ) 
    PARTITIONED BY (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_newsdetail_log/' 
    TBLPROPERTIES('parquet.compression'='lzo');
    
    drop table if exists ${APP}.dwd_loading_log; 
    CREATE EXTERNAL TABLE ${APP}.dwd_loading_log( 
        mid_id string, 
        user_id string, 
        version_code string, 
        version_name string, 
        lang string, 
        source string, 
        os string, 
        area string,
        model string, 
        brand string, 
        sdk_version string, 
        gmail string, 
        height_width string, 
        app_time string, 
        network string, 
        lng string, 
        lat string, 
        action string, 
        loading_time string, 
        loading_way string, 
        extend1 string, 
        extend2 string, 
        type string, 
        type1 string, 
        server_time string
    ) 
    PARTITIONED BY (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_loading_log/' 
    TBLPROPERTIES('parquet.compression'='lzo');
    
    drop table if exists ${APP}.dwd_ad_log;
    CREATE EXTERNAL TABLE ${APP}.dwd_ad_log( 
        mid_id string, 
        user_id string, 
        version_code string, 
        version_name string, 
        lang string, 
        source string, 
        os string, 
        area string, 
        model string, 
        brand string, 
        sdk_version string, 
        gmail string, 
        height_width string, 
        app_time string, 
        network string, 
        lng string, 
        lat string, 
        entry string, 
        action string, 
        contentType string, 
        displayMills string, 
        itemId string, 
        activityId string, 
        server_time string
    ) 
    PARTITIONED BY (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_ad_log/' 
    TBLPROPERTIES('parquet.compression'='lzo');
    
    drop table if exists ${APP}.dwd_notification_log; 
    CREATE EXTERNAL TABLE ${APP}.dwd_notification_log(
        mid_id string, 
        user_id string,
        version_code string, 
        version_name string, 
        lang string, 
        source string, 
        os string, 
        area string, 
        model string, 
        brand string, 
        sdk_version string, 
        gmail string, 
        height_width string, 
        app_time string, 
        network string, 
        lng string, 
        lat string, 
        action string, 
        noti_type string, 
        ap_time string, 
        content string, 
        server_time string 
    ) 
    PARTITIONED BY (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_notification_log/' 
    TBLPROPERTIES('parquet.compression'='lzo');
    
    drop table if exists ${APP}.dwd_active_background_log; 
    CREATE EXTERNAL TABLE ${APP}.dwd_active_background_log( 
        mid_id string, 
        user_id string, 
        version_code string, 
        version_name string, 
        lang string, 
        source string, 
        os string, 
        area string, 
        model string, 
        brand string, 
        sdk_version string, 
        gmail string, 
        height_width string, 
        app_time string, 
        network string, 
        lng string, 
        lat string, 
        active_source string, 
        server_time string 
    ) 
    PARTITIONED BY (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_active_background_log/' 
    TBLPROPERTIES('parquet.compression'='lzo');
    
    drop table if exists ${APP}.dwd_comment_log; 
    CREATE EXTERNAL TABLE ${APP}.dwd_comment_log( 
        mid_id string, 
        user_id string, 
        version_code string, 
        version_name string, 
        lang string, 
        source string, 
        os string, 
        area string, 
        model string, 
        brand string, 
        sdk_version string, 
        gmail string, 
        height_width string, 
        app_time string, 
        network string, 
        lng string, 
        lat string, 
        comment_id int, 
        userid int, 
        p_comment_id int, 
        content string, 
        addtime string, 
        other_id int, 
        praise_count int, 
        reply_count int, 
        server_time string 
    )
    PARTITIONED BY (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_comment_log/' 
    TBLPROPERTIES('parquet.compression'='lzo');
    
    drop table if exists ${APP}.dwd_favorites_log; 
    CREATE EXTERNAL TABLE ${APP}.dwd_favorites_log( 
        mid_id string, 
        user_id string, 
        version_code string, 
        version_name string, 
        lang string, 
        source string, 
        os string, 
        area string, 
        model string, 
        brand string, 
        sdk_version string, 
        gmail string, 
        height_width string, 
        app_time string, 
        network string, 
        lng string, 
        lat string, 
        id int, 
        course_id int, 
        userid int, 
        add_time string,
        server_time string 
    )
    PARTITIONED BY (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_favorites_log/' 
    TBLPROPERTIES('parquet.compression'='lzo');
    
    drop table if exists ${APP}.dwd_praise_log; 
    CREATE EXTERNAL TABLE ${APP}.dwd_praise_log( 
        mid_id string, 
        user_id string, 
        version_code string, 
        version_name string, 
        lang string, 
        source string, 
        os string, 
        area string, 
        model string, 
        brand string, 
        sdk_version string,
        gmail string, 
        height_width string,
        app_time string, 
        network string, 
        lng string, 
        lat string, 
        id string, 
        userid string, 
        target_id string, 
        type string, 
        add_time string, 
        server_time string 
    )
    PARTITIONED BY (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_praise_log/' 
    TBLPROPERTIES('parquet.compression'='lzo');
    
    drop table if exists ${APP}.dwd_error_log; 
    CREATE EXTERNAL TABLE ${APP}.dwd_error_log( 
        mid_id string, 
        user_id string, 
        version_code string, 
        version_name string,
        lang string, 
        source string, 
        os string, 
        area string, 
        model string, 
        brand string, 
        sdk_version string, 
        gmail string, 
        height_width string, 
        app_time string, 
        network string, 
        lng string, 
        lat string, 
        errorBrief string, 
        errorDetail string, 
        server_time string
    ) 
    PARTITIONED BY (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_error_log/' 
    TBLPROPERTIES('parquet.compression'='lzo');
"

$hive -e "$sql"

