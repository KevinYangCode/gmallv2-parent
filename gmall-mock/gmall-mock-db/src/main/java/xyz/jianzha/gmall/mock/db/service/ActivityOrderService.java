package xyz.jianzha.gmall.mock.db.service;

import com.baomidou.mybatisplus.extension.service.IService;
import xyz.jianzha.gmall.mock.db.bean.ActivityOrder;
import xyz.jianzha.gmall.mock.db.bean.OrderInfo;

import java.util.List;

/**
 * 活动与订单关联表 服务类
 *
 * @author Y_Kevin
 * @date 2020-07-12 14:04
 */
public interface ActivityOrderService extends IService<ActivityOrder> {

    List<ActivityOrder> genActivityOrder(List<OrderInfo> orderInfoList, Boolean ifClear);

    void saveActivityOrderList(List<ActivityOrder> activityOrderList);

}
