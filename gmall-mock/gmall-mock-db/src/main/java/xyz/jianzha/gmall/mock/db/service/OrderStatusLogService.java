package xyz.jianzha.gmall.mock.db.service;

import com.baomidou.mybatisplus.extension.service.IService;
import xyz.jianzha.gmall.mock.db.bean.OrderInfo;
import xyz.jianzha.gmall.mock.db.bean.OrderStatusLog;

import java.util.List;

/**
 * 服务类
 *
 * @author Y_Kevin
 * @date 2020-07-12 14:12
 */
public interface OrderStatusLogService extends IService<OrderStatusLog> {
    void genOrderStatusLog(List<OrderInfo> orderInfoList);

}
