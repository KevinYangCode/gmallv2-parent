package xyz.jianzha.gmall.mock.db.bean;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 优惠券表
 *
 * @author Y_Kevin
 * @date 2020-07-12 13:40
 */
@Data
public class CouponInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 购物券编号
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 购物券名称
     */
    private String couponName;

    /**
     * 购物券类型 1 现金券 2 折扣券 3 满减券 4 满件打折券
     */
    private String couponType;

    /**
     * 满额数
     */
    private BigDecimal conditionAmount;

    /**
     * 满件数
     */
    private Long conditionNum;

    /**
     * 活动编号
     */
    private Long activityId;

    /**
     * 减金额
     */
    private BigDecimal benefitAmount;

    /**
     * 折扣
     */
    private Long benefitDiscount;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 范围类型 1、商品 2、品类 3、品牌
     */
    private String rangeType;

    /**
     * 商品id
     */
    private Long spuId;

    /**
     * 品牌id
     */
    private Long tmId;

    /**
     * 品类id
     */
    private Long category3Id;

    /**
     * 最多领用次数
     */
    private Integer limitNum;

    /**
     * 修改时间
     */
    private Date operateTime;

    private Date expireTime;
}
