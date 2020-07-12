package xyz.jianzha.gmall.mock.log.enums;

import lombok.AllArgsConstructor;

/**
 * @author Y_Kevin
 * @date 2020-07-12 16:11
 */
@AllArgsConstructor
public enum DisplayType {

    /**
     *
     */
    promotion("商品推广"),
    recommend("算法推荐商品"),
    query("查询结果商品"),
    activity("促销活动");

    private String desc;
}
