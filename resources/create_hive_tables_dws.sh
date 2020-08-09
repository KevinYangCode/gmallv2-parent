#!/bin/bash

# 定义变量方便修改
APP=gmall
hive=/opt/module/hive-2.3.6/bin/hive

sql="
use ${APP};
drop table if exists dws_uv_detail_daycount;
create external table dws_uv_detail_daycount (
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
    login_count bigint comment '活跃次数' 
)
partitioned by(dt string) 
stored as parquet 
location '/warehouse/gmall/dws/dws_uv_detail_daycount';

drop table if exists dws_user_action_daycount;
create external table dws_user_action_daycount (
    user_id string comment '用户 id',
    login_count bigint comment '登录次数',
    cart_count bigint comment '加入购物车次数',
    cart_amount double comment '加入购物车金额',
    order_count bigint comment '下单次数',
    order_amount decimal(16,2) comment '下单金额',
    payment_count bigint comment '支付次数',
    payment_amount decimal(16,2) comment '支付金额' 
) 
comment '每日用户行为' 
partitioned by (dt string) 
stored as parquet 
location '/warehouse/gmall/dws/dws_user_action_daycount/' 
tblproperties ('parquet.compression'='lzo');

drop table if exists dws_sku_action_daycount;
create external table dws_sku_action_daycount (
    sku_id string comment 'sku_id',
    order_count bigint comment '被下单次数',
    order_num bigint comment '被下单件数',
    order_amount decimal(16,2) comment '被下单金额',
    payment_count bigint comment '被支付次数',
    payment_num bigint comment '被支付件数',
    payment_amount decimal(16,2) comment '被支付金额',
    refund_count bigint comment '被退款次数',
    refund_num bigint comment '被退款件数',
    refund_amount decimal(16,2) comment '被退款金额',
    cart_count bigint comment '被加入购物车次数',
    cart_num bigint comment '被加入购物车件数',
    favor_count bigint comment '被收藏次数',
    appraise_good_count bigint comment '好评数',
    appraise_mid_count bigint comment '中评数',
    appraise_bad_count bigint comment '差评数',
    appraise_default_count bigint comment '默认评价数' 
) 
comment '每日商品行为' 
partitioned by (dt string) 
stored as parquet 
location '/warehouse/gmall/dws/dws_sku_action_daycount/' 
tblproperties ('parquet.compression'='lzo');

drop table if exists dws_coupon_use_daycount;
create external table dws_coupon_use_daycount (
    coupon_id string comment '优惠券 ID',
    coupon_name string comment '购物券名称',
    coupon_type string comment '购物券类型 1 现金券 2 折扣券 3 满减券 4 满件打折券',
    condition_amount string comment '满额数',
    condition_num string comment '满件数',
    activity_id string comment '活动编号',
    benefit_amount string comment '减金额',
    benefit_discount string comment '折扣',
    create_time string comment '创建时间',
    range_type string comment '范围类型 1、商品 2、品类 3、品牌',
    spu_id string comment '商品 id',
    tm_id string comment '品牌 id',
    category3_id string comment '品类 id',
    limit_num string comment '最多领用次数',
    get_count bigint comment '领用次数',
    using_count bigint comment '使用(下单)次数',
    used_count bigint comment '使用(支付)次数' 
) 
comment '每日优惠券统计' 
partitioned by (dt string) 
stored as parquet 
location '/warehouse/gmall/dws/dws_coupon_use_daycount/' 
tblproperties ('parquet.compression'='lzo');

drop table if exists dws_activity_info_daycount;
create external table dws_activity_info_daycount(
    id string comment '编号',
    activity_name string comment '活动名称',
    activity_type string comment '活动类型',
    start_time string comment '开始时间',
    end_time string comment '结束时间',
    create_time string comment '创建时间',
    order_count bigint comment '下单次数',
    payment_count bigint comment '支付次数' 
) 
comment '购物车信息表' 
partitioned by (dt string) 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/dws/dws_activity_info_daycount/' 
tblproperties ('parquet.compression'='lzo');

drop table if exists dws_sale_detail_daycount;
create external table dws_sale_detail_daycount (
    user_id string comment '用户 id',
    sku_id string comment '商品 id',
    user_gender string comment '用户性别',
    user_age string comment '用户年龄',
    user_level string comment '用户等级',
    order_price decimal(10,2) comment '商品价格',
    sku_name string comment '商品名称',
    sku_tm_id string comment '品牌 id',
    sku_category3_id string comment '商品三级品类 id',
    sku_category2_id string comment '商品二级品类 id',
    sku_category1_id string comment '商品一级品类 id',
    sku_category3_name string comment '商品三级品类名称',
    sku_category2_name string comment '商品二级品类名称',
    sku_category1_name string comment '商品一级品类名称',
    spu_id string comment '商品 spu',
    sku_num int comment '购买个数',
    order_count bigint comment '当日下单单数',
    order_amount decimal(16,2) comment '当日下单金额' 
) 
comment '每日购买行为' 
partitioned by (dt string) 
stored as parquet 
location '/warehouse/gmall/dws/dws_sale_detail_daycount/' 
tblproperties ('parquet.compression'='lzo');
"

$hive -e "$sql"
