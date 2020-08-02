#!/bin/bash

# 定义变量方便修改
APP=gmall
hive=/opt/module/hive-2.3.6/bin/hive

sql="
    use ${APP};
    drop table if exists ods_start_log;
    create external table ods_start_log (
        line string
    ) 
    partitioned by (dt string) 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_start_log';

    drop table if exists ods_event_log;
    create external table ods_event_log (
        line string
    ) 
    partitioned by (dt string) 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_event_log';

    drop table if exists ods_order_info;
    create external table ods_order_info (
        id string comment '订单号', 
        final_total_amount decimal(10,2) comment '订单金额',
        order_status string comment '订单状态', 
        user_id string comment '用户 id', 
        out_trade_no string comment '支付流水号', 
        create_time string comment '创建时间', 
        operate_time string comment '操作时间', 
        province_id string comment '省份 ID', 
        benefit_reduce_amount decimal(10,2) comment '优惠金额', 
        original_total_amount decimal(10,2) comment '原价金额', 
        feight_fee decimal(10,2) comment '运费'
    ) comment '订单表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_order_info/';

    drop table if exists ods_order_detail; 
    create external table ods_order_detail(
        id string comment '订单编号', 
        order_id string comment '订单号', 
        user_id string comment '用户 id', 
        sku_id string comment '商品 id', 
        sku_name string comment '商品名称', 
        order_price decimal(10,2) comment '商品价格', 
        sku_num bigint comment '商品数量', 
        create_time string comment '创建时间', 
        source_type string, 
        source_id bigint
    ) comment '订单详情表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_order_detail/';

    drop table if exists ods_sku_info;
    create external table ods_sku_info( 
        id string comment 'skuId', 
        spu_id string comment 'spuid', 
        price decimal(10,2) comment '价格',
        sku_name string comment '商品名称', 
        sku_desc string comment '商品描述',
        weight string comment '重量',
        tm_id string comment '品牌 id',
        category3_id string comment '品类 id',
        create_time string comment '创建时间' 
    ) comment 'SKU 商品表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
    location '/warehouse/gmall/ods/ods_sku_info/';

    drop table if exists ods_user_info; 
    create external table ods_user_info( 
        id string comment '用户 id', 
        name string comment '姓名', 
        birthday string comment '生日', 
        gender string comment '性别', 
        email string comment '邮箱', 
        user_level string comment '用户等级', 
        create_time string comment '创建时间', 
        operate_time string comment '操作时间' 
    ) comment '用户表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_user_info/';

    drop table if exists ods_base_category1; 
    create external table ods_base_category1( 
        id string comment 'id', 
        name string comment '名称' 
    ) comment '商品一级分类表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_base_category1/';

    drop table if exists ods_base_category2; 
    create external table ods_base_category2( 
        id string comment ' id', 
        name string comment '名称', 
        category1_id string comment '一级品类 id'
    ) comment '商品二级分类表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_base_category2/';

    drop table if exists ods_base_category3; 
    create external table ods_base_category3( 
        id string comment ' id', 
        name string comment '名称', 
        category2_id string comment '二级品类 id'
    ) comment '商品三级分类表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_base_category3/';

    drop table if exists ods_payment_info; 
    create external table ods_payment_info( 
        id bigint comment '编号', 
        out_trade_no string comment '对外业务编号', 
        order_id string comment '订单编号', 
        user_id string comment '用户编号', 
        alipay_trade_no string comment '支付宝交易流水编号', 
        total_amount decimal(16,2) comment '支付金额', 
        subject string comment '交易内容', 
        payment_type string comment '支付类型', 
        payment_time string comment '支付时间' 
    ) comment '支付流水表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_payment_info/';

    drop table if exists ods_base_province; 
    create external table ods_base_province ( 
        id bigint comment '编号', 
        name string comment '省份名称', 
        region_id string comment '地区 ID', 
        area_code string comment '地区编码', 
        iso_code string comment 'iso 编码' 
    ) comment '省份表' 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_base_province/';

    drop table if exists ods_base_region; 
    create external table ods_base_region ( 
        id bigint comment '编号', 
        region_name string comment '地区名称' 
    ) comment '地区表' 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_base_region/';

    drop table if exists ods_base_trademark; 
    create external table ods_base_trademark ( 
        tm_id bigint comment '编号', 
        tm_name string comment '品牌名称' 
    ) comment '品牌表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_base_trademark/';

    drop table if exists ods_order_status_log; 
    create external table ods_order_status_log ( 
        id bigint comment '编号', 
        order_id string comment '订单 ID', 
        order_status string comment '订单状态', 
        operate_time string comment '修改时间' 
    ) comment '订单状态表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_order_status_log/';

    drop table if exists ods_spu_info; 
    create external table ods_spu_info( 
        id string comment 'spuid', 
        spu_name string comment 'spu 名称', 
        category3_id string comment '品类 id', 
        tm_id string comment '品牌 id' 
    ) comment 'SPU 商品表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_spu_info/';

    drop table if exists ods_comment_info; 
    create external table ods_comment_info( 
        id string comment '编号', 
        user_id string comment '用户 ID', 
        sku_id string comment '商品 sku', 
        spu_id string comment '商品 spu', 
        order_id string comment '订单 ID', 
        appraise string comment '评价', 
        create_time string comment '评价时间'
    ) comment '商品评论表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_comment_info/';

    drop table if exists ods_order_refund_info; 
    create external table ods_order_refund_info( 
        id string comment '编号', 
        user_id string comment '用户 ID', 
        order_id string comment '订单 ID', 
        sku_id string comment '商品 ID', 
        refund_type string comment '退款类型', 
        refund_num bigint comment '退款件数', 
        refund_amount decimal(16,2) comment '退款金额', 
        refund_reason_type string comment '退款原因类型', 
        create_time string comment '退款时间' 
    ) comment '退单表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_order_refund_info/';

    drop table if exists ods_cart_info; 
    create external table ods_cart_info( 
        id string comment '编号', 
        user_id string comment '用户 id', 
        sku_id string comment 'skuid', 
        cart_price string comment '放入购物车时价格', 
        sku_num string comment '数量', 
        sku_name string comment 'sku 名称 (冗余)', 
        create_time string comment '创建时间',
        operate_time string comment '修改时间', 
        is_ordered string comment '是否已经下单', 
        order_time string comment '下单时间',
        source_type string,
        source_id bigint
    ) comment '加购表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_cart_info/';

    drop table if exists ods_favor_info; 
    create external table ods_favor_info( 
        id string comment '编号', 
        user_id string comment '用户 id', 
        sku_id string comment 'skuid',
        spu_id string comment 'spuid', 
        is_cancel string comment '是否取消', 
        create_time string comment '收藏时间', 
        cancel_time string comment '取消时间' 
    ) comment '商品收藏表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_favor_info/';

    drop table if exists ods_coupon_use; 
    create external table ods_coupon_use( 
        id string comment '编号', 
        coupon_id string comment '优惠券 ID', 
        user_id string comment 'skuid', 
        order_id string comment 'spuid',
        coupon_status string comment '优惠券状态', 
        get_time string comment '领取时间', 
        using_time string comment '使用时间(下单)', 
        used_time string comment '使用时间(支付)' 
    ) comment '优惠券领用表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_coupon_use/';

    drop table if exists ods_coupon_info; 
    create external table ods_coupon_info( 
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
    ) comment '优惠券表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_coupon_info/';

    drop table if exists ods_activity_info; 
    create external table ods_activity_info( 
        id string comment '编号', 
        activity_name string comment '活动名称', 
        activity_type string comment '活动类型', 
        start_time string comment '开始时间', 
        end_time string comment '结束时间', 
        create_time string comment '创建时间' 
    ) comment '活动表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_activity_info/';

    drop table if exists ods_activity_order; 
    create external table ods_activity_order( 
        id string comment '编号', 
        activity_id string comment '优惠券 ID', 
        order_id string comment 'skuid', 
        create_time string comment '领取时间' 
    ) comment '活动订单关联表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_activity_order/';

    drop table if exists ods_activity_rule; 
    create external table ods_activity_rule( 
        id string comment '编号', 
        activity_id string comment '活动 ID', 
        condition_amount string comment '满减金额', 
        condition_num string comment '满减件数', 
        benefit_amount string comment '优惠金额', 
        benefit_discount string comment '优惠折扣', 
        benefit_level string comment '优惠级别' 
    ) comment '优惠规则表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_activity_rule/';

    drop table if exists ods_base_dic; 
    create external table ods_base_dic(
        dic_code string comment '编号', 
        dic_name string comment '编码名称', 
        parent_code string comment '父编码', 
        create_time string comment '创建日期', 
        operate_time string comment '操作日期' 
    ) comment '编码字典表' 
    partitioned by (dt string) 
    row format delimited fields terminated by '\t' 
    stored as 
        INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
        OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
    location '/warehouse/gmall/ods/ods_base_dic/';
"

$hive -e "$sql"
