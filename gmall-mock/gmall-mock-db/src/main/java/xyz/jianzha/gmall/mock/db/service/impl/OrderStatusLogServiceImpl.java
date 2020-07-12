package xyz.jianzha.gmall.mock.db.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import xyz.jianzha.gmall.mock.db.bean.OrderInfo;
import xyz.jianzha.gmall.mock.db.bean.OrderStatusLog;
import xyz.jianzha.gmall.mock.db.mapper.OrderStatusLogMapper;
import xyz.jianzha.gmall.mock.db.service.OrderStatusLogService;
import xyz.jianzha.gmall.mock.db.util.ParamUtil;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 服务实现类
 *
 * @author Y_Kevin
 * @date 2020-07-12 15:13
 */
@Service
public class OrderStatusLogServiceImpl extends ServiceImpl<OrderStatusLogMapper, OrderStatusLog> implements OrderStatusLogService {

    @Value("${mock.date}")
    String mockDate;

    @Override
    public void genOrderStatusLog(List<OrderInfo> orderInfoList) {
        Date date = ParamUtil.checkDate(mockDate);

        List<OrderStatusLog> orderStatusLogList = new ArrayList<>();
        for (OrderInfo orderInfo : orderInfoList) {
            OrderStatusLog orderStatusLog = new OrderStatusLog();
            orderStatusLog.setOperateTime(date);
            orderStatusLog.setOrderStatus(orderInfo.getOrderStatus());
            orderStatusLog.setOrderId(orderInfo.getId());
            orderStatusLogList.add(orderStatusLog);
        }
        saveBatch(orderStatusLogList);
    }
}
