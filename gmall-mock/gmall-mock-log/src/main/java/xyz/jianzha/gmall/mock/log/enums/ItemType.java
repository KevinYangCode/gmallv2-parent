package xyz.jianzha.gmall.mock.log.enums;

/**
 * @author Y_Kevin
 * @date 2020-07-12 16:11
 */
public enum ItemType {

    /**
     *
     */
    sku_id("商品skuId"),
    keyword("搜索关键词"),
    sku_ids("多个商品skuId"),
    activity_id("活动id"),
    coupon_id("购物券id");

    String desc;

    ItemType(String desc) {
        this.desc = desc;
    }
}
