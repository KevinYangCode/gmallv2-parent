package xyz.jianzha.gmall.mock.db.constant;

/**
 * @author Y_Kevin
 * @date 2020-07-12 13:45
 */
public class GmallConstant {

    //10 单据状态
    /**
     * 未支付
     */
    public static final String ORDER_STATUS_UNPAID = "1001";

    /**
     * 已支付
     */
    public static final String ORDER_STATUS_PAID = "1002";

    /**
     * 已取消
     */
    public static final String ORDER_STATUS_CANCEL = "1003";

    /**
     * 已完成
     */
    public static final String ORDER_STATUS_FINISH = "1004";

    /**
     * 退款中
     */
    public static final String ORDER_STATUS_REFUND = "1005";

    /**
     * 退款完成
     */
    public static final String ORDER_STATUS_REFUND_DONE = "1006";


    //11 支付状态
    /**
     * 支付宝
     */
    public static final String PAYMENT_TYPE_ALIPAY = "1101";

    /**
     * 微信
     */
    public static final String PAYMENT_TYPE_WECHAT = "1102";

    /**
     * 银联
     */
    public static final String PAYMENT_TYPE_UNION = "1103";

    //12 评价
    /**
     * 好评
     */
    public static final String APPRAISE_GOOD = "1201";

    /**
     * 中评
     */
    public static final String APPRAISE_SOSO = "1202";

    /**
     * 差评
     */
    public static final String APPRAISE_BAD = "1203";

    /**
     * 自动
     */
    public static final String APPRAISE_AUTO = "1204";


    //13 退货原因
    /**
     * 质量问题
     */
    public static final String REFUND_REASON_BAD_GOODS = "1301";

    /**
     * 商品描述与实际描述不一致
     */
    public static final String REFUND_REASON_WRONG_DESC = "1302";

    /**
     * 缺货
     */
    public static final String REFUND_REASON_SALE_OUT = "1303";

    /**
     * 号码不合适
     */
    public static final String REFUND_REASON_SIZE_ISSUE = "1304";

    /**
     * 拍错
     */
    public static final String REFUND_REASON_MISTAKE = "1305";

    /**
     * 不想买了
     */
    public static final String REFUND_REASON_NO_REASON = "1306";

    /**
     * 其他
     */
    public static final String REFUND_REASON_OTHER = "1307";


    //14 购物券状态
    /**
     * 未使用
     */
    public static final String COUPON_STATUS_UNUSED = "1401";

    /**
     * 使用中
     */
    public static final String COUPON_STATUS_USING = "1402";

    /**
     * 已使用
     */
    public static final String COUPON_STATUS_USED = "1403";


    //15退款类型
    /**
     * 仅退款
     */
    public static final String REFUND_TYPE_ONLY_MONEY = "1501";

    /**
     * 退货退款
     */
    public static final String REFUND_TYPE_WITH_GOODS = "1502";


    //24来源类型
    /**
     * 用户查询
     */
    public static final String SOURCE_TYPE_QUREY = "2401";

    /**
     * 商品推广
     */
    public static final String SOURCE_TYPE_PROMOTION = "2402";

    /**
     * 智能推荐
     */
    public static final String SOURCE_TYPE_AUTO_RECOMMEND = "2403";

    /**
     * 促销活动
     */
    public static final String SOURCE_TYPE_ACTIVITY = "2404";
}

