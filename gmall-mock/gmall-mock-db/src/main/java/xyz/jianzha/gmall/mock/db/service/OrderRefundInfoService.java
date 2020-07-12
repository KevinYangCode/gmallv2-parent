package xyz.jianzha.gmall.mock.db.service;

import com.baomidou.mybatisplus.extension.service.IService;
import xyz.jianzha.gmall.mock.db.bean.OrderRefundInfo;

/**
 * 退单表 服务类
 *
 * @author Y_Kevin
 * @date 2020-07-12 14:10
 */
public interface OrderRefundInfoService extends IService<OrderRefundInfo> {

    void genRefundsOrFinish(Boolean ifClear);
}
