package xyz.jianzha.gmall.mock.db.bean;

import lombok.Data;

import java.io.Serializable;

/**
 * @author Y_Kevin
 * @date 2020-07-12 13:38
 */
@Data
public class BaseProvince implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    private Long id;

    /**
     * 省名称
     */
    private String name;

    /**
     * 大区id
     */
    private String regionId;

    /**
     * 行政区位码
     */
    private String areaCode;

    /**
     * 国际编码
     */
    private String isoCode;
}
