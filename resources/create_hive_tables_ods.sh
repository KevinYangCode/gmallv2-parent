#!/bin/bash

# 定义变量方便修改
APP=gmall
hive=/opt/module/hive-2.3.6/bin/hive

create_ods_action_log(){
    echo "======== 创建 ODS层 用户行为数据表 =============="
    sql="
        drop table if exists ${APP}.ods_start_log;
        create external table ${APP}.ods_start_log (
            line string
        ) 
        PARTITIONED BY (dt string) 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        LOCATION '/warehouse/gmall/ods/ods_start_log';

        drop table if exists ${APP}.ods_event_log;
        create external table ${APP}.ods_event_log (
            line string
        ) 
        PARTITIONED BY (dt string) 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        LOCATION '/warehouse/gmall/ods/ods_event_log';
    "
    $hive -e "$sql"
}

create_ods_service_info(){
    echo "========= 创建 ODS层 业务数据表 =============="
    sql="
        drop table if exists ${APP}.ods_order_info;
        create external table ${APP}.ods_order_info (
            id string COMMENT '订单号', 
            final_total_amount decimal(10,2) COMMENT '订单金额',
            order_status string COMMENT '订单状态', 
            user_id string COMMENT '用户 id', 
            out_trade_no string COMMENT '支付流水号', 
            create_time string COMMENT '创建时间', 
            operate_time string COMMENT '操作时间', 
            province_id string COMMENT '省份 ID', 
            benefit_reduce_amount decimal(10,2) COMMENT '优惠金额', 
            original_total_amount decimal(10,2) COMMENT '原价金额', 
            feight_fee decimal(10,2) COMMENT '运费'
        ) COMMENT '订单表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_order_info/';

        drop table if exists ${APP}.ods_order_detail; 
        create external table ${APP}.ods_order_detail(
            id string COMMENT '订单编号', 
            order_id string COMMENT '订单号', 
            user_id string COMMENT '用户 id', 
            sku_id string COMMENT '商品 id', 
            sku_name string COMMENT '商品名称', 
            order_price decimal(10,2) COMMENT '商品价格', 
            sku_num bigint COMMENT '商品数量', 
            create_time string COMMENT '创建时间', 
            source_type string, 
            source_id bigint
        ) COMMENT '订单详情表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_order_detail/';

        drop table if exists ${APP}.ods_sku_info;
        create external table ${APP}.ods_sku_info( 
            id string COMMENT 'skuId', 
            spu_id string COMMENT 'spuid', 
            price decimal(10,2) COMMENT '价格',
            sku_name string COMMENT '商品名称', 
            sku_desc string COMMENT '商品描述',
            weight string COMMENT '重量',
            tm_id string COMMENT '品牌 id',
            category3_id string COMMENT '品类 id',
            create_time string COMMENT '创建时间' 
        ) COMMENT 'SKU 商品表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
        location '/warehouse/gmall/ods/ods_sku_info/';

        drop table if exists ${APP}.ods_user_info; 
        create external table ${APP}.ods_user_info( 
            id string COMMENT '用户 id', 
            name string COMMENT '姓名', 
            birthday string COMMENT '生日', 
            gender string COMMENT '性别', 
            email string COMMENT '邮箱', 
            user_level string COMMENT '用户等级', 
            create_time string COMMENT '创建时间', 
            operate_time string COMMENT '操作时间' 
        ) COMMENT '用户表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_user_info/';

        drop table if exists ${APP}.ods_base_category1; 
        create external table ${APP}.ods_base_category1( 
            id string COMMENT 'id', 
            name string COMMENT '名称' 
        ) COMMENT '商品一级分类表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_base_category1/';

        drop table if exists ${APP}.ods_base_category2; 
        create external table ${APP}.ods_base_category2( 
            id string COMMENT ' id', 
            name string COMMENT '名称', 
            category1_id string COMMENT '一级品类 id'
        ) COMMENT '商品二级分类表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_base_category2/';

        drop table if exists ${APP}.ods_base_category3; 
        create external table ${APP}.ods_base_category3( 
            id string COMMENT ' id', 
            name string COMMENT '名称', 
            category2_id string COMMENT '二级品类 id'
        ) COMMENT '商品三级分类表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_base_category3/';

        drop table if exists ${APP}.ods_payment_info; 
        create external table ${APP}.ods_payment_info( 
            id bigint COMMENT '编号', 
            out_trade_no string COMMENT '对外业务编号', 
            order_id string COMMENT '订单编号', 
            user_id string COMMENT '用户编号', 
            alipay_trade_no string COMMENT '支付宝交易流水编号', 
            total_amount decimal(16,2) COMMENT '支付金额', 
            subject string COMMENT '交易内容', 
            payment_type string COMMENT '支付类型', 
            payment_time string COMMENT '支付时间' 
        ) COMMENT '支付流水表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_payment_info/';

        drop table if exists ${APP}.ods_base_province; 
        create external table ${APP}.ods_base_province ( 
            id bigint COMMENT '编号', 
            name string COMMENT '省份名称', 
            region_id string COMMENT '地区 ID', 
            area_code string COMMENT '地区编码', 
            iso_code string COMMENT 'iso 编码' 
        ) COMMENT '省份表' 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_base_province/';

        drop table if exists ${APP}.ods_base_region; 
        create external table ${APP}.ods_base_region ( 
            id bigint COMMENT '编号', 
            region_name string COMMENT '地区名称' 
        ) COMMENT '地区表' 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_base_region/';

        drop table if exists ${APP}.ods_base_trademark; 
        create external table ${APP}.ods_base_trademark ( 
            tm_id bigint COMMENT '编号', 
            tm_name string COMMENT '品牌名称' 
        ) COMMENT '品牌表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_base_trademark/';

        drop table if exists ${APP}.ods_order_status_log; 
        create external table ${APP}.ods_order_status_log ( 
            id bigint COMMENT '编号', 
            order_id string COMMENT '订单 ID', 
            order_status string COMMENT '订单状态', 
            operate_time string COMMENT '修改时间' 
        ) COMMENT '订单状态表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_order_status_log/';

        drop table if exists ${APP}.ods_spu_info; 
        create external table ${APP}.ods_spu_info( 
            id string COMMENT 'spuid', 
            spu_name string COMMENT 'spu 名称', 
            category3_id string COMMENT '品类 id', 
            tm_id string COMMENT '品牌 id' 
        ) COMMENT 'SPU 商品表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_spu_info/';

        drop table if exists ${APP}.ods_comment_info; 
        create external table ${APP}.ods_comment_info( 
            id string COMMENT '编号', 
            user_id string COMMENT '用户 ID', 
            sku_id string COMMENT '商品 sku', 
            spu_id string COMMENT '商品 spu', 
            order_id string COMMENT '订单 ID', 
            appraise string COMMENT '评价', 
            create_time string COMMENT '评价时间'
        ) COMMENT '商品评论表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_comment_info/';

        drop table if exists ${APP}.ods_order_refund_info; 
        create external table ${APP}.ods_order_refund_info( 
            id string COMMENT '编号', 
            user_id string COMMENT '用户 ID', 
            order_id string COMMENT '订单 ID', 
            sku_id string COMMENT '商品 ID', 
            refund_type string COMMENT '退款类型', 
            refund_num bigint COMMENT '退款件数', 
            refund_amount decimal(16,2) COMMENT '退款金额', 
            refund_reason_type string COMMENT '退款原因类型', 
            create_time string COMMENT '退款时间' 
        ) COMMENT '退单表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_order_refund_info/';

        drop table if exists ${APP}.ods_cart_info; 
        create external table ${APP}.ods_cart_info( 
            id string COMMENT '编号', 
            user_id string COMMENT '用户 id', 
            sku_id string COMMENT 'skuid', 
            cart_price string COMMENT '放入购物车时价格', 
            sku_num string COMMENT '数量', 
            sku_name string COMMENT 'sku 名称 (冗余)', 
            create_time string COMMENT '创建时间',
            operate_time string COMMENT '修改时间', 
            is_ordered string COMMENT '是否已经下单', 
            order_time string COMMENT '下单时间',
            source_type string,
            source_id bigint
        ) COMMENT '加购表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_cart_info/';

        drop table if exists ${APP}.ods_favor_info; 
        create external table ${APP}.ods_favor_info( 
            id string COMMENT '编号', 
            user_id string COMMENT '用户 id', 
            sku_id string COMMENT 'skuid',
            spu_id string COMMENT 'spuid', 
            is_cancel string COMMENT '是否取消', 
            create_time string COMMENT '收藏时间', 
            cancel_time string COMMENT '取消时间' 
        ) COMMENT '商品收藏表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_favor_info/';

        drop table if exists ${APP}.ods_coupon_use; 
        create external table ${APP}.ods_coupon_use( 
            id string COMMENT '编号', 
            coupon_id string COMMENT '优惠券 ID', 
            user_id string COMMENT 'skuid', 
            order_id string COMMENT 'spuid',
            coupon_status string COMMENT '优惠券状态', 
            get_time string COMMENT '领取时间', 
            using_time string COMMENT '使用时间(下单)', 
            used_time string COMMENT '使用时间(支付)' 
        ) COMMENT '优惠券领用表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_coupon_use/';

        drop table if exists ${APP}.ods_coupon_info; 
        create external table ${APP}.ods_coupon_info( 
            id string COMMENT '购物券编号', 
            coupon_name string COMMENT '购物券名称', 
            coupon_type string COMMENT '购物券类型 1 现金券 2 折扣券 3 满减券 4 满件打折券', 
            condition_amount string COMMENT '满额数', 
            condition_num string COMMENT '满件数', 
            activity_id string COMMENT '活动编号', 
            benefit_amount string COMMENT '减金额', 
            benefit_discount string COMMENT '折扣', 
            create_time string COMMENT '创建时间', 
            range_type string COMMENT '范围类型 1、商品 2、品类 3、品牌', 
            spu_id string COMMENT '商品 id', 
            tm_id string COMMENT '品牌 id', 
            category3_id string COMMENT '品类 id', 
            limit_num string COMMENT '最多领用次数', 
            operate_time string COMMENT '修改时间', 
            expire_time string COMMENT '过期时间' 
        ) COMMENT '优惠券表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_coupon_info/';

        drop table if exists ${APP}.ods_activity_info; 
        create external table ${APP}.ods_activity_info( 
            id string COMMENT '编号', 
            activity_name string COMMENT '活动名称', 
            activity_type string COMMENT '活动类型', 
            start_time string COMMENT '开始时间', 
            end_time string COMMENT '结束时间', 
            create_time string COMMENT '创建时间' 
        ) COMMENT '活动表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_activity_info/';

        drop table if exists ${APP}.ods_activity_order; 
        create external table ${APP}.ods_activity_order( 
            id string COMMENT '编号', 
            activity_id string COMMENT '优惠券 ID', 
            order_id string COMMENT 'skuid', 
            create_time string COMMENT '领取时间' 
        ) COMMENT '活动订单关联表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_activity_order/';

        drop table if exists ${APP}.ods_activity_rule; 
        create external table ${APP}.ods_activity_rule( 
            id string COMMENT '编号', 
            activity_id string COMMENT '活动 ID', 
            condition_amount string COMMENT '满减金额', 
            condition_num string COMMENT '满减件数', 
            benefit_amount string COMMENT '优惠金额', 
            benefit_discount string COMMENT '优惠折扣', 
            benefit_level string COMMENT '优惠级别' 
        ) COMMENT '优惠规则表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_activity_rule/';

        drop table if exists ${APP}.ods_base_dic; 
        create external table ${APP}.ods_base_dic(
            dic_code string COMMENT '编号', 
            dic_name string COMMENT '编码名称', 
            parent_code string COMMENT '父编码', 
            create_time string COMMENT '创建日期', 
            operate_time string COMMENT '操作日期' 
        ) COMMENT '编码字典表' 
        PARTITIONED BY (dt string) 
        row format delimited fields terminated by '\t' 
        STORED AS 
            INPUTFORMAT 'com.hadoop.mapred.DeprecatedLzoTextInputFormat' 
            OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
        location '/warehouse/gmall/ods/ods_base_dic/';
    "
    $hive -e "$sql"
}

case $1 in 
    "ods_log")
        create_ods_action_log
;;
    "ods_info")
        create_ods_service_info
;;
esac
