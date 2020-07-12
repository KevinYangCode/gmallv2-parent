package xyz.jianzha.gmall.mock.db.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import xyz.jianzha.gmall.mock.db.bean.ActivityOrder;
import xyz.jianzha.gmall.mock.db.bean.ActivitySku;
import xyz.jianzha.gmall.mock.db.bean.OrderDetail;
import xyz.jianzha.gmall.mock.db.bean.OrderInfo;
import xyz.jianzha.gmall.mock.db.mapper.ActivityOrderMapper;
import xyz.jianzha.gmall.mock.db.service.ActivityOrderService;
import xyz.jianzha.gmall.mock.db.service.ActivitySkuService;
import xyz.jianzha.gmall.mock.db.util.ParamUtil;
import xyz.jianzha.gmall.mock.db.util.RandomNum;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 活动与订单关联表 服务实现类
 *
 * @author Y_Kevin
 * @date 2020-07-12 14:57
 */
@Service
@Slf4j
public class ActivityOrderServiceImpl extends ServiceImpl<ActivityOrderMapper, ActivityOrder> implements ActivityOrderService {

    @Autowired
    ActivitySkuService activitySkuService;

    @Value("${mock.date}")
    String mockDate;

    @Override
    public List<ActivityOrder> genActivityOrder(List<OrderInfo> orderInfoList, Boolean ifClear) {
        Date date = ParamUtil.checkDate(mockDate);

        if (ifClear) {
            remove(new QueryWrapper<ActivityOrder>());
        }

        List<ActivitySku> activitySkuList = activitySkuService.list(new QueryWrapper<>());

        // 检查每个订单里是否有对应的活动商品 如果有随机进行优惠
        List<ActivityOrder> activityOrderList = new ArrayList<>();
        for (OrderInfo orderInfo : orderInfoList) {

            List<OrderDetail> orderDetailList = orderInfo.getOrderDetailList();
            orderDetailLoop:
            for (OrderDetail orderDetail : orderDetailList) {
                for (ActivitySku activitySku : activitySkuList) {
                    if (orderDetail.getSkuId().equals(activitySku.getSkuId())) {
                        orderInfo.setBenefitReduceAmount(BigDecimal.valueOf(RandomNum.getRandInt(1, (orderInfo.getOriginalTotalAmount().intValue() / 2))));
                        orderInfo.sumTotalAmount();

                        activityOrderList.add(new ActivityOrder(null, activitySku.getActivityId(), orderInfo.getId(), orderInfo, date));
                        break orderDetailLoop;
                    }
                }
            }
        }
        log.warn("共有" + activityOrderList.size() + "订单参与活动条");
        return activityOrderList;
    }

    @Override
    public void saveActivityOrderList(List<ActivityOrder> activityOrderList) {
        saveBatch(activityOrderList, 100);
    }
}

