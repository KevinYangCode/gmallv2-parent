package xyz.jianzha.gmall.mock.db.bean;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 优惠规则
 *
 * @author Y_Kevin
 * @date 2020-07-11 23:46
 */
@Data
public class ActivityRule implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 编号
     */
    private Integer id;

    /**
     * 类型
     */
    private Integer activityId;

    /**
     * 满减金额
     */
    private BigDecimal conditionAmount;

    /**
     * 满减件数
     */
    private Long conditionNum;

    /**
     * 优惠金额
     */
    private BigDecimal benefitAmount;

    /**
     * 优惠折扣
     */
    private Long benefitDiscount;

    /**
     * 优惠级别
     */
    private Long benefitLevel;
}
