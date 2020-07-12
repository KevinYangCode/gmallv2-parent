package xyz.jianzha.gmall.mock.db.bean;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 商品收藏表
 *
 * @author Y_Kevin
 * @date 2020-07-12 13:41
 */
@Data
public class FavorInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 编号
     */
    private Long id;

    /**
     * 用户名称
     */
    private Long userId;

    /**
     * skuid
     */
    private Long skuId;

    /**
     * 商品id
     */
    private Long spuId;

    /**
     * 是否已取消 0 正常 1 已取消
     */
    private String isCancel;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改时间
     */
    private Date cancelTime;
}
