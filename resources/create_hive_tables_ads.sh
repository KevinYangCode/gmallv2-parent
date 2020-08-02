#!/bin/bash

# 定义变量方便修改
APP=gmall
hive=/opt/module/hive-2.3.6/bin/hive

sql="
use ${APP};
drop table if exists ads_uv_count; 
create external table ads_uv_count( 
    dt string comment '统计日期', 
    day_count bigint comment '当日用户数量', 
    wk_count bigint comment '当周用户数量', 
    mn_count bigint comment '当月用户数量', 
    is_weekend string comment 'Y,N 是否是周末,用于得到本周最终结果',
    is_monthend string comment 'Y,N 是否是月末,用于得到本月最终结果' 
) 
comment '活跃设备数' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_uv_count/';

drop table if exists ads_new_mid_count; 
create external table ads_new_mid_count ( 
    create_date string comment '创建时间', 
    new_mid_count BIGINT comment '新增设备数量' 
) 
comment '每日新增设备信息数量' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_new_mid_count/';

drop table if exists ads_silent_count; 
create external table ads_silent_count(
    dt string comment '统计日期', 
    silent_count bigint comment '沉默设备数' 
)
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_silent_count';

drop table if exists ads_back_count; 
create external table ads_back_count( 
    dt string comment '统计日期', 
    wk_dt string comment '统计日期所在周', 
    wastage_count bigint comment '回流设备数' 
)
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_back_count';

drop table if exists ads_wastage_count; 
create external table ads_wastage_count( 
    dt string comment '统计日期', 
    wastage_count bigint comment '流失设备数' 
)
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_wastage_count';

drop table if exists ads_user_retention_day_rate; 
create external table ads_user_retention_day_rate ( 
    stat_date string comment '统计日期', 
    create_date string comment '设备新增日期', 
    retention_day int comment '截止当前日期留存天数', 
    retention_count bigint comment '留存数量', 
    new_mid_count bigint comment '设备新增数量', 
    retention_ratio decimal(10,2) comment '留存率' 
) 
comment '每日用户留存情况' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_user_retention_day_rate/';

drop table if exists ads_continuity_wk_count; 
create external table ads_continuity_wk_count( 
    dt string comment '统计日期,一般用结束周周日日期,如果每天计算一次,可用当天日期',
    wk_dt string comment '持续时间', 
    continuity_count bigint comment '活跃次数' 
)
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_continuity_wk_count';

drop table if exists ads_continuity_uv_count; 
create external table ads_continuity_uv_count( 
    dt string comment '统计日期', 
    wk_dt string comment '最近 7 天日期', 
    continuity_count bigint 
) 
comment '连续活跃设备数' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_continuity_uv_count';

drop table if exists ads_user_topic; 
create external table ads_user_topic( 
    dt string comment '统计日期', 
    day_users string comment '活跃会员数', 
    day_new_users string comment '新增会员数', 
    day_new_payment_users string comment '新增消费会员数', 
    payment_users string comment '总付费会员数', 
    users string comment '总会员数', 
    day_users2users decimal(10,2) comment '会员活跃率', 
    payment_users2users decimal(10,2) comment '会员付费率', 
    day_new_users2users decimal(10,2) comment '会员新鲜度' 
) 
comment '会员主题信息表' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_user_topic';

drop table if exists ads_user_action_convert_day; 
create external table ads_user_action_convert_day( 
    dt string comment '统计日期', 
    total_visitor_m_count bigint comment '总访问人数', 
    cart_u_count bigint comment '加入购物车的人数', 
    visitor2cart_convert_ratio decimal(10,2) comment '访问到加入购物车转化率', 
    order_u_count bigint comment '下单人数', 
    cart2order_convert_ratio decimal(10,2) comment '加入购物车到下单转化率', 
    payment_u_count bigint comment '支付人数', 
    order2payment_convert_ratio decimal(10,2) comment '下单到支付的转化率' 
) 
comment '用户行为漏斗分析' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_user_action_convert_day/';

drop table if exists ads_product_info; 
create external table ads_product_info( 
    dt string comment '统计日期', 
    sku_num string comment 'sku 个数', 
    spu_num string comment 'spu 个数' 
) 
comment '商品个数信息' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_product_info';

drop table if exists ads_product_sale_topN; 
create external table ads_product_sale_topN( 
    dt string comment '统计日期', 
    sku_id string comment '商品 ID', 
    payment_amount bigint comment '销量' 
) 
comment '商品个数信息' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_product_sale_topN';

drop table if exists ads_product_favor_topN; 
create external table ads_product_favor_topN( 
    dt string comment '统计日期', 
    sku_id string comment '商品 ID', 
    favor_count bigint comment '收藏量' 
) 
comment '商品收藏 TopN' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_product_favor_topN';

drop table if exists ads_product_cart_topN; 
create external table ads_product_cart_topN( 
    dt string comment '统计日期', 
    sku_id string comment '商品 ID', 
    cart_num bigint comment '加入购物车数量' 
) 
comment '商品加入购物车 TopN' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_product_cart_topN';

drop table if exists ads_product_refund_topN; 
create external table ads_product_refund_topN( 
    dt string comment '统计日期', 
    sku_id string comment '商品 ID', 
    refund_ratio decimal(10,2) comment '退款率' 
) 
comment '商品退款率 TopN' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_product_refund_topN';

drop table if exists ads_appraise_bad_topN; 
create external table ads_appraise_bad_topN( 
    dt string comment '统计日期', 
    sku_id string comment '商品 ID', 
    appraise_bad_ratio decimal(10,2) comment '差评率' 
) 
comment '商品差评率 TopN' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_appraise_bad_topN';

drop table if exists ads_order_daycount; 
create external table ads_order_daycount( 
    dt string comment '统计日期', 
    order_count bigint comment '单日下单笔数', 
    order_amount bigint comment '单日下单金额', 
    order_users bigint comment '单日下单用户数' 
) 
comment '每日订单总计表' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_order_daycount';

drop table if exists ads_payment_daycount; 
create external table ads_payment_daycount( 
    dt string comment '统计日期', 
    order_count bigint comment '单日支付笔数', 
    order_amount decimal(10,2) comment '单日支付金额', 
    payment_user_count bigint comment '单日支付人数', 
    payment_sku_count bigint comment '单日支付商品数', 
    payment_avg_time double comment '下单到支付的平均时长，取分钟数' 
) 
comment '每日订单总计表' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_payment_daycount';

drop table ads_sale_tm_category1_stat_mn; 
create external table ads_sale_tm_category1_stat_mn ( 
    tm_id string comment '品牌 id', 
    category1_id string comment '1 级品类 id ', 
    category1_name string comment '1 级品类名称 ', 
    buycount bigint comment '购买人数', 
    buy_twice_last bigint comment '两次以上购买人数', 
    buy_twice_last_ratio decimal(10,2) comment '单次复购率', 
    buy_3times_last bigint comment '三次以上购买人数', 
    buy_3times_last_ratio decimal(10,2) comment '多次复购率', 
    stat_mn string comment '统计月份', 
    stat_date string comment '统计日期' 
) 
comment '复购率统计' 
row format delimited fields terminated by '\t' 
location '/warehouse/gmall/ads/ads_sale_tm_category1_stat_mn/';
"

$hive -e "$sql"

