#!/bin/bash

# 定义变量方便修改
APP=gmall
hive=/opt/module/hive-2.3.6/bin/hive

sql="
    use ${APP};
    drop table if exists dwd_start_log;
    create external table dwd_start_log(
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
        open_ad_type string, 
        action string, 
        loading_time string, 
        detail string, 
        extend1 string 
    )
    partitioned by (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_start_log/' 
    tblproperties('parquet.compression'='lzo');
    
    drop table if exists dwd_base_event_log; 
    create external table dwd_base_event_log( 
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
        event_name string, 
        event_json string, 
        server_time string
    ) 
    partitioned by (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_base_event_log/' 
    tblproperties('parquet.compression'='lzo');
    
    drop table if exists dwd_display_log; 
    create external table dwd_display_log( 
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
        goodsid string, 
        place string, 
        extend1 string, 
        category string, 
        server_time string 
    )
    partitioned by (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_display_log/' 
    tblproperties('parquet.compression'='lzo');
    
    drop table if exists dwd_newsdetail_log; 
    create external table dwd_newsdetail_log(
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
    partitioned by (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_newsdetail_log/' 
    tblproperties('parquet.compression'='lzo');
    
    drop table if exists dwd_loading_log; 
    create external table dwd_loading_log( 
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
    partitioned by (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_loading_log/' 
    tblproperties('parquet.compression'='lzo');
    
    drop table if exists dwd_ad_log;
    create external table dwd_ad_log( 
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
    partitioned by (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_ad_log/' 
    tblproperties('parquet.compression'='lzo');
    
    drop table if exists dwd_notification_log; 
    create external table dwd_notification_log(
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
    partitioned by (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_notification_log/' 
    tblproperties('parquet.compression'='lzo');
    
    drop table if exists dwd_active_background_log; 
    create external table dwd_active_background_log( 
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
    partitioned by (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_active_background_log/' 
    tblproperties('parquet.compression'='lzo');
    
    drop table if exists dwd_comment_log; 
    create external table dwd_comment_log( 
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
    partitioned by (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_comment_log/' 
    tblproperties('parquet.compression'='lzo');
    
    drop table if exists dwd_favorites_log; 
    create external table dwd_favorites_log( 
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
    partitioned by (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_favorites_log/' 
    tblproperties('parquet.compression'='lzo');
    
    drop table if exists dwd_praise_log; 
    create external table dwd_praise_log( 
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
    partitioned by (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_praise_log/' 
    tblproperties('parquet.compression'='lzo');
    
    drop table if exists dwd_error_log; 
    create external table dwd_error_log( 
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
    partitioned by (dt string) 
    stored as parquet 
    location '/warehouse/gmall/dwd/dwd_error_log/' 
    tblproperties('parquet.compression'='lzo');
"

$hive -e "$sql"
