#!/bin/bash

# 定义变量方便修改
APP=gmall
hive=/opt/module/hive-2.3.6/bin/hive

# 如果是输入的日期按照取输入日期；如果没输入日期取当前时间的前一天
if [ -n "$1" ] ;then
    do_date=$1
else
    do_date=`date -d "-1 day" +%F`
fi

sql="
    use ${APP};
    insert overwrite table dwd_display_log 
    partition (dt='$do_date') 
    select 
        mid_id,
        user_id,
        version_code,
        version_name,
        lang,
        source,
        os,
        area,
        model,
        brand,
        sdk_version,
        gmail,
        height_width,
        app_time,
        network,
        lng,
        lat,
        get_json_object(event_json,'$.kv.action') action,
        get_json_object(event_json,'$.kv.goodsid') goodsid,
        get_json_object(event_json,'$.kv.place') place,
        get_json_object(event_json,'$.kv.extend1') extend1,
        get_json_object(event_json,'$.kv.category') category,
        server_time 
    from dwd_base_event_log 
    where dt='$do_date' and event_name='display';
    
    insert overwrite table dwd_newsdetail_log 
    partition (dt='$do_date') 
    select 
        mid_id,
        user_id,
        version_code,
        version_name,
        lang,
        source,
        os,
        area,
        model,
        brand,
        sdk_version,
        gmail,
        height_width,
        app_time,
        network,
        lng,
        lat,
        get_json_object(event_json,'$.kv.entry') entry,
        get_json_object(event_json,'$.kv.action') action,
        get_json_object(event_json,'$.kv.goodsid') goodsid,
        get_json_object(event_json,'$.kv.showtype') showtype,
        get_json_object(event_json,'$.kv.news_staytime') news_staytime,
        get_json_object(event_json,'$.kv.loading_time') loading_time,
        get_json_object(event_json,'$.kv.type1') type1,
        get_json_object(event_json,'$.kv.category') category,
        server_time 
    from dwd_base_event_log 
    where dt='$do_date' and event_name='newsdetail';
    
    insert overwrite table dwd_loading_log 
    partition (dt='$do_date') 
    select 
        mid_id,
        user_id,
        version_code,
        version_name,
        lang,
        source,
        os,
        area,
        model,
        brand,
        sdk_version,
        gmail,
        height_width,
        app_time,
        network,
        lng,
        lat,
        get_json_object(event_json,'$.kv.action') action,
        get_json_object(event_json,'$.kv.loading_time') loading_time,
        get_json_object(event_json,'$.kv.loading_way') loading_way,
        get_json_object(event_json,'$.kv.extend1') extend1,
        get_json_object(event_json,'$.kv.extend2') extend2,
        get_json_object(event_json,'$.kv.type') type,
        get_json_object(event_json,'$.kv.type1') type1,
        server_time 
    from dwd_base_event_log 
    where dt='$do_date' and event_name='loading';
    
    insert overwrite table dwd_ad_log 
    partition (dt='$do_date') 
    select 
        mid_id,
        user_id,
        version_code,
        version_name,
        lang,
        source,
        os,
        area,
        model,
        brand,
        sdk_version,
        gmail,
        height_width,
        app_time,
        network,
        lng,
        lat,
        get_json_object(event_json,'$.kv.entry') entry,
        get_json_object(event_json,'$.kv.action') action,
        get_json_object(event_json,'$.kv.contentType') contentType,
        get_json_object(event_json,'$.kv.displayMills') displayMills,
        get_json_object(event_json,'$.kv.itemId') itemId,
        get_json_object(event_json,'$.kv.activityId') activityId,
        server_time 
    from dwd_base_event_log 
    where dt='$do_date' and event_name='ad';
    
    insert overwrite table dwd_notification_log 
    partition (dt='$do_date') 
    select 
        mid_id,
        user_id,
        version_code,
        version_name,
        lang,
        source,
        os,
        area,
        model,
        brand,
        sdk_version,
        gmail,
        height_width,
        app_time,
        network,
        lng,
        lat,
        get_json_object(event_json,'$.kv.action') action,
        get_json_object(event_json,'$.kv.noti_type') noti_type,
        get_json_object(event_json,'$.kv.ap_time') ap_time,
        get_json_object(event_json,'$.kv.content') content,
        server_time 
    from dwd_base_event_log 
    where dt='$do_date' and event_name='notification';
    
    insert overwrite table dwd_active_background_log 
    partition (dt='$do_date') 
    select 
        mid_id,
        user_id,
        version_code,
        version_name,
        lang,
        source,
        os,
        area,
        model,
        brand,
        sdk_version,
        gmail,
        height_width,
        app_time,
        network,
        lng,
        lat,
        get_json_object(event_json,'$.kv.active_source') active_source,
        server_time 
    from dwd_base_event_log 
    where dt='$do_date' and event_name='active_background';
    
    insert overwrite table dwd_comment_log 
    partition (dt='$do_date') 
    select 
        mid_id,
        user_id,
        version_code,
        version_name,
        lang,
        source,
        os,
        area,
        model,
        brand,
        sdk_version,
        gmail,
        height_width,
        app_time,
        network,
        lng,
        lat,
        get_json_object(event_json,'$.kv.comment_id') comment_id,
        get_json_object(event_json,'$.kv.userid') userid,
        get_json_object(event_json,'$.kv.p_comment_id') p_comment_id,
        get_json_object(event_json,'$.kv.content') content,
        get_json_object(event_json,'$.kv.addtime') addtime,
        get_json_object(event_json,'$.kv.other_id') other_id,
        get_json_object(event_json,'$.kv.praise_count') praise_count,
        get_json_object(event_json,'$.kv.reply_count') reply_count,
        server_time 
    from dwd_base_event_log 
    where dt='$do_date' and event_name='comment';
    
    insert overwrite table dwd_favorites_log 
    partition (dt='$do_date') 
    select 
        mid_id,
        user_id,
        version_code,
        version_name,
        lang,
        source,
        os,
        area,
        model,
        brand,
        sdk_version,
        gmail,
        height_width,
        app_time,
        network,
        lng,
        lat,
        get_json_object(event_json,'$.kv.id') id,
        get_json_object(event_json,'$.kv.course_id') course_id,
        get_json_object(event_json,'$.kv.userid') userid,
        get_json_object(event_json,'$.kv.add_time') add_time,
        server_time 
    from dwd_base_event_log 
    where dt='$do_date' and event_name='favorites';
    
    insert overwrite table dwd_praise_log 
    partition (dt='$do_date') 
    select 
        mid_id,
        user_id,
        version_code,
        version_name,
        lang,
        source,
        os,
        area,
        model,
        brand,
        sdk_version,
        gmail,
        height_width,
        app_time,
        network,
        lng,
        lat,
        get_json_object(event_json,'$.kv.id') id,
        get_json_object(event_json,'$.kv.userid') userid,
        get_json_object(event_json,'$.kv.target_id') target_id,
        get_json_object(event_json,'$.kv.type') type,
        get_json_object(event_json,'$.kv.add_time') add_time,
        server_time 
    from dwd_base_event_log 
    where dt='$do_date' and event_name='praise';
    
    insert overwrite table dwd_error_log 
    partition (dt='$do_date') 
    select 
        mid_id,
        user_id,
        version_code,
        version_name,
        lang,
        source,
        os,
        area,
        model,
        brand,
        sdk_version,
        gmail,
        height_width,
        app_time,
        network,
        lng,
        lat,
        get_json_object(event_json,'$.kv.errorBrief') errorBrief,
        get_json_object(event_json,'$.kv.errorDetail') errorDetail,
        server_time 
    from dwd_base_event_log 
    where dt='$do_date' and event_name='error';
"

$hive -e "$sql"

