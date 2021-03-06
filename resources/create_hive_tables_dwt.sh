#!/bin/bash

# 定义变量方便修改
APP=gmall
hive=/opt/module/hive-2.3.6/bin/hive

sql="
use ${APP};
drop table if exists dwt_uv_topic; 
create external table dwt_uv_topic ( 
    mid_id string comment '设备唯一标识',
    user_id string comment '用户标识',
    version_code string comment '程序版本号',
    version_name string comment '程序版本名',
    lang string comment '系统语言',
    source string comment '渠道号',
    os string comment '安卓系统版本',
    area string comment '区域',
    model string comment '手机型号',
    brand string comment '手机品牌',
    sdk_version string comment 'sdkVersion',
    gmail string comment 'gmail',
    height_width string comment '屏幕宽高',
    app_time string comment '客户端日志产生时的时间',
    network string comment '网络模式',
    lng string comment '经度',
    lat string comment '纬度',
    login_date_first string comment '首次活跃时间',
    login_date_last string comment '末次活跃时间',
    login_day_count bigint comment '当日活跃次数',
    login_count bigint comment '累积活跃天数' 
)
stored as parquet 
location '/warehouse/gmall/dwt/dwt_uv_topic';

drop table if exists dwt_user_topic; 
create external table dwt_user_topic ( 
    user_id string comment '用户 id',
    login_date_first string comment '首次登录时间',
    login_date_last string comment '末次登录时间',
    login_count bigint comment '累积登录天数',
    login_last_30d_count bigint comment '最近 30 日登录天数',
    order_date_first string comment '首次下单时间',
    order_date_last string comment '末次下单时间',
    order_count bigint comment '累积下单次数',
    order_amount decimal(16,2) comment '累积下单金额',
    order_last_30d_count bigint comment '最近 30 日下单次数',
    order_last_30d_amount bigint comment '最近 30 日下单金额',
    payment_date_first string comment '首次支付时间',
    payment_date_last string comment '末次支付时间',
    payment_count decimal(16,2) comment '累积支付次数',
    payment_amount decimal(16,2) comment '累积支付金额',
    payment_last_30d_count decimal(16,2) comment '最近 30 日支付次数',
    payment_last_30d_amount decimal(16,2) comment '最近 30 日支付金额' 
)
comment '用户主题宽表' 
stored as parquet 
location '/warehouse/gmall/dwt/dwt_user_topic/' 
tblproperties ('parquet.compression'='lzo');

drop table if exists dwt_sku_topic; 
create external table dwt_sku_topic ( 
    sku_id string comment 'sku_id',
    spu_id string comment 'spu_id',
    order_last_30d_count bigint comment '最近 30 日被下单次数',
    order_last_30d_num bigint comment '最近 30 日被下单件数',
    order_last_30d_amount decimal(16,2) comment '最近 30 日被下单金额',
    order_count bigint comment '累积被下单次数',
    order_num bigint comment '累积被下单件数',
    order_amount decimal(16,2) comment '累积被下单金额',
    payment_last_30d_count bigint comment '最近 30 日被支付次数',
    payment_last_30d_num bigint comment '最近 30 日被支付件数',
    payment_last_30d_amount decimal(16,2) comment '最近 30 日被支付金额',
    payment_count bigint comment '累积被支付次数',
    payment_num bigint comment '累积被支付件数',
    payment_amount decimal(16,2) comment '累积被支付金额',
    refund_last_30d_count bigint comment '最近三十日退款次数',
    refund_last_30d_num bigint comment '最近三十日退款件数',
    refund_last_30d_amount decimal(10,2) comment '最近三十日退款金额',
    refund_count bigint comment '累积退款次数',
    refund_num bigint comment '累积退款件数',
    refund_amount decimal(10,2) comment '累积退款金额',
    cart_last_30d_count bigint comment '最近 30 日被加入购物车次数',
    cart_last_30d_num bigint comment '最近 30 日被加入购物车件数',
    cart_count bigint comment '累积被加入购物车次数',
    cart_num bigint comment '累积被加入购物车件数',
    favor_last_30d_count bigint comment '最近 30 日被收藏次数',
    favor_count bigint comment '累积被收藏次数',
    appraise_last_30d_good_count bigint comment '最近 30 日好评数',
    appraise_last_30d_mid_count bigint comment '最近 30 日中评数',
    appraise_last_30d_bad_count bigint comment '最近 30 日差评数',
    appraise_last_30d_default_count bigint comment '最近 30 日默认评价数',
    appraise_good_count bigint comment '累积好评数',
    appraise_mid_count bigint comment '累积中评数',
    appraise_bad_count bigint comment '累积差评数',
    appraise_default_count bigint comment '累积默认评价数' 
)comment '商品主题宽表' 
stored as parquet 
location '/warehouse/gmall/dwt/dwt_sku_topic/' 
tblproperties ('parquet.compression'='lzo');

drop table if exists dwt_coupon_topic; 
create external table dwt_coupon_topic ( 
    coupon_id string comment '优惠券 ID',
    get_day_count bigint comment '当日领用次数',
    using_day_count bigint comment '当日使用(下单)次数',
    used_day_count bigint comment '当日使用(支付)次数',
    get_count bigint comment '累积领用次数',
    using_count bigint comment '累积使用(下单)次数',
    used_count bigint comment '累积使用(支付)次数' 
)
comment '购物券主题宽表' 
stored as parquet 
location '/warehouse/gmall/dwt/dwt_coupon_topic/' 
tblproperties ('parquet.compression'='lzo');

drop table if exists dwt_activity_topic;
create external table dwt_activity_topic( 
    id string comment '活动 id',
    activity_name string comment '活动名称',
    order_day_count bigint comment '当日日下单次数',
    payment_day_count bigint comment '当日支付次数',
    order_count bigint comment '累积下单次数',
    payment_count bigint comment '累积支付次数' 
) 
comment '活动主题宽表' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/dwt/dwt_activity_topic/' 
tblproperties ('parquet.compression'='lzo');
"

$hive -e "$sql"
