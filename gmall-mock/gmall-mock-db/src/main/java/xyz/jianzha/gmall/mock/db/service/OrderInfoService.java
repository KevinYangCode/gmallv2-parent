package xyz.jianzha.gmall.mock.db.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import xyz.jianzha.gmall.mock.db.bean.OrderInfo;

import java.util.List;

/**
 * 订单表 服务类
 *
 * @author Y_Kevin
 * @date 2020-07-12 14:09
 */
public interface OrderInfoService extends IService<OrderInfo> {
    void genOrderInfos(boolean ifClear);

    void updateOrderStatus(List<OrderInfo> orderInfoList);

    List<OrderInfo> listWithDetail(Wrapper<OrderInfo> queryWrapper);

    List<OrderInfo> listWithDetail(Wrapper<OrderInfo> queryWrapper, Boolean withSkuInfo);
}
