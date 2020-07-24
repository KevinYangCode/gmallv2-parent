#!/bin/bash

# 定义变量方便修改
APP=gmall
hive=/opt/module/hive-2.3.6/bin/hive

sql="
drop table if exists ${APP}.dwd_dim_sku_info; 
create external table ${APP}.dwd_dim_sku_info ( 
    id string comment '商品 id',
    spu_id string comment 'spuid',
    price double comment '商品价格',
    sku_name string comment '商品名称',
    sku_desc string comment '商品描述',
    weight double comment '重量',
    tm_id string comment '品牌 id',
    tm_name string comment '品牌名称',
    category3_id string comment '三级分类 id',
    category2_id string comment '二级分类 id',
    category1_id string comment '一级分类 id',
    category3_name string comment '三级分类名称',
    category2_name string comment '二级分类名称',
    category1_name string comment '一级分类名称',
    spu_name string comment 'spu 名称',
    create_time string comment '创建时间' 
)
comment '商品维度表' 
partitioned by (dt string) 
stored as parquet 
location '/warehouse/gmall/dwd/dwd_dim_sku_info/' 
tblproperties('parquet.compression'='lzo');

drop table if exists ${APP}.dwd_dim_coupon_info; 
create external table ${APP}.dwd_dim_coupon_info( 
    id string comment '购物券编号',
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
    operate_time string comment '修改时间',
    expire_time string comment '过期时间' 
) 
comment '优惠券信息表' 
partitioned by (dt string) 
row format delimited fields terminated by '\t' 
stored as parquet 
location '/warehouse/gmall/dwd/dwd_dim_coupon_info/' 
tblproperties('parquet.compression'='lzo');

drop table if exists ${APP}.dwd_dim_activity_info; 
create external table ${APP}.dwd_dim_activity_info( 
    id string comment '编号',
    activity_name string comment '活动名称',
    activity_type string comment '活动类型',
    condition_amount string comment '满减金额',
    condition_num string comment '满减件数',
    benefit_amount string comment '优惠金额',
    benefit_discount string comment '优惠折扣',
    benefit_level string comment '优惠级别',
    start_time string comment '开始时间',
    end_time string comment '结束时间',
    create_time string comment '创建时间' 
) 
comment '活动信息表' 
partitioned by (dt string) 
row format delimited fields terminated by '\t' 
stored as parquet 
location '/warehouse/gmall/dwd/dwd_dim_activity_info/' 
tblproperties('parquet.compression'='lzo');

drop table if exists ${APP}.dwd_dim_base_province; 
create external table ${APP}.dwd_dim_base_province ( 
    id string comment 'id',
    province_name string comment '省市名称',
    area_code string comment '地区编码',
    iso_code string comment 'ISO 编码',
    region_id string comment '地区 id',
    region_name string comment '地区名称' 
)
comment '地区省市表' 
stored as parquet 
location '/warehouse/gmall/dwd/dwd_dim_base_province/' 
tblproperties('parquet.compression'='lzo');

drop table if exists ${APP}.dwd_dim_date_info; 
create external table ${APP}.dwd_dim_date_info( 
    date_id string comment '日',
    week_id int comment '周',
    week_day int comment '周的第几天',
    day int comment '每月的第几天',
    month int comment '第几月',
    quarter int comment '第几季度',
    year int comment '年',
    is_workday int comment '是否是周末',
    holiday_id int comment '是否是节假日' 
)
row format delimited fields terminated by '\t' 
stored as parquet 
location '/warehouse/gmall/dwd/dwd_dim_date_info/' 
tblproperties('parquet.compression'='lzo');

drop table if exists ${APP}.dwd_fact_order_detail; 
create external table ${APP}.dwd_fact_order_detail ( 
    id string comment '订单编号',
    order_id string comment '订单号',
    user_id string comment '用户 id',
    sku_id string comment 'sku 商品 id',
    sku_name string comment '商品名称',
    order_price decimal(10,2) comment '商品价格',
    sku_num bigint comment '商品数量',
    create_time string comment '创建时间',
    province_id string comment '省份 ID',
    total_amount decimal(20,2) comment '订单总金额' 
)
partitioned by (dt string) 
stored as parquet 
location '/warehouse/gmall/dwd/dwd_fact_order_detail/' 
tblproperties('parquet.compression'='lzo');

drop table if exists ${APP}.dwd_fact_payment_info; 
create external table ${APP}.dwd_fact_payment_info ( 
    id string comment '',
    out_trade_no string comment '对外业务编号',
    order_id string comment '订单编号',
    user_id string comment '用户编号',
    alipay_trade_no string comment '支付宝交易流水编号',
    payment_amount decimal(16,2) comment '支付金额',
    subject string comment '交易内容',
    payment_type string comment '支付类型',
    payment_time string comment '支付时间',
    province_id string comment '省份 ID' 
)
partitioned by (dt string) 
stored as parquet 
location '/warehouse/gmall/dwd/dwd_fact_payment_info/' 
tblproperties('parquet.compression'='lzo');

drop table if exists ${APP}.dwd_fact_order_refund_info; 
create external table ${APP}.dwd_fact_order_refund_info( 
    id string comment '编号',
    user_id string comment '用户 ID',
    order_id string comment '订单 ID',
    sku_id string comment '商品 ID',
    refund_type string comment '退款类型',
    refund_num bigint comment '退款件数',
    refund_amount decimal(16,2) comment '退款金额',
    refund_reason_type string comment '退款原因类型',
    create_time string comment '退款时间' 
) 
comment '退款事实表' 
partitioned by (dt string) 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/dwd/dwd_fact_order_refund_info/';

drop table if exists ${APP}.dwd_fact_comment_info; 
create external table ${APP}.dwd_fact_comment_info( 
    id string comment '编号',
    user_id string comment '用户 ID',
    sku_id string comment '商品 sku',
    spu_id string comment '商品 spu',
    order_id string comment '订单 ID',
    appraise string comment '评价',
    create_time string comment '评价时间' 
) 
comment '评价事实表' 
partitioned by (dt string) 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/dwd/dwd_fact_comment_info/';

drop table if exists ${APP}.dwd_fact_cart_info; 
create external table ${APP}.dwd_fact_cart_info( 
    id string comment '编号',
    user_id string comment '用户 id',
    sku_id string comment 'skuid',
    cart_price string comment '放入购物车时价格',
    sku_num string comment '数量',
    sku_name string comment 'sku 名称 (冗余)',
    create_time string comment '创建时间',
    operate_time string comment '修改时间',
    is_ordered string comment '是否已经下单。1 为已下单;0 为未下单',
    order_time string comment '下单时间' 
) 
comment '加购事实表' 
partitioned by (dt string) 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/dwd/dwd_fact_cart_info/';

drop table if exists ${APP}.dwd_fact_favor_info; 
create external table ${APP}.dwd_fact_favor_info( 
    id string comment '编号',
    user_id string comment '用户 id',
    sku_id string comment 'skuid',
    spu_id string comment 'spuid',
    is_cancel string comment '是否取消',
    create_time string comment '收藏时间',
    cancel_time string comment '取消时间' 
) 
comment '收藏事实表' 
partitioned by (dt string) 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/dwd/dwd_fact_favor_info/';

drop table if exists ${APP}.dwd_fact_coupon_use; 
create external table ${APP}.dwd_fact_coupon_use( 
    id string comment '编号',
    coupon_id string comment '优惠券 ID',
    user_id string comment 'userid',
    order_id string comment '订单 id',
    coupon_status string comment '优惠券状态',
    get_time string comment '领取时间',
    using_time string comment '使用时间(下单)',
    used_time string comment '使用时间(支付)' 
) 
comment '优惠券领用事实表' 
partitioned by (dt string) 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/dwd/dwd_fact_coupon_use/';

drop table if exists ${APP}.dwd_fact_order_info; 
create external table ${APP}.dwd_fact_order_info ( 
    id string comment '订单编号',
    order_status string comment '订单状态',
    user_id string comment '用户 id',
    out_trade_no string comment '支付流水号',
    create_time string comment '创建时间(未支付状态)',
    payment_time string comment '支付时间(已支付状态)',
    cancel_time string comment '取消时间(已取消状态)',
    finish_time string comment '完成时间(已完成状态)',
    refund_time string comment '退款时间(退款中状态)',
    refund_finish_time string comment '退款完成时间(退款完成状态)',
    province_id string comment '省份 ID',
    activity_id string comment '活动 ID',
    original_total_amount string comment '原价金额',
    benefit_reduce_amount string comment '优惠金额',
    feight_fee string comment '运费',
    final_total_amount decimal(10,2) comment '订单金额' 
)
partitioned by (dt string) 
stored as parquet 
location '/warehouse/gmall/dwd/dwd_fact_order_info/' 
tblproperties('parquet.compression'='lzo');

drop table if exists ${APP}.dwd_dim_user_info_his; 
create external table ${APP}.dwd_dim_user_info_his( 
    id string comment '用户 id',
    name string comment '姓名',
    birthday string comment '生日',
    gender string comment '性别',
    email string comment '邮箱',
    user_level string comment '用户等级',
    create_time string comment '创建时间',
    operate_time string comment '操作时间',
    start_date string comment '有效开始日期',
    end_date string comment '有效结束日期' 
) 
comment '订单拉链表' 
stored as parquet 
location '/warehouse/gmall/dwd/dwd_dim_user_info_his/' 
tblproperties('parquet.compression'='lzo');

drop table if exists ${APP}.dwd_dim_user_info_his_tmp; 
create external table ${APP}.dwd_dim_user_info_his_tmp( 
    id string comment '用户 id',
    name string comment '姓名',
    birthday string comment '生日',
    gender string comment '性别',
    email string comment '邮箱',
    user_level string comment '用户等级',
    create_time string comment '创建时间',
    operate_time string comment '操作时间',
    start_date string comment '有效开始日期',
    end_date string comment '有效结束日期' 
)
comment '订单拉链临时表' 
stored as parquet 
location '/warehouse/gmall/dwd/dwd_dim_user_info_his_tmp/' 
tblproperties('parquet.compression'='lzo');
"

$hive -e "$sql"

