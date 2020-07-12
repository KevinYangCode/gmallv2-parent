package xyz.jianzha.gmall.mock.db.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import xyz.jianzha.gmall.mock.db.bean.OrderDetail;
import xyz.jianzha.gmall.mock.db.mapper.OrderDetailMapper;
import xyz.jianzha.gmall.mock.db.service.OrderDetailService;

/**
 * 订单明细表 服务实现类
 *
 * @author Y_Kevin
 * @date 2020-07-12 15:09
 */
@Service
public class OrderDetailServiceImpl extends ServiceImpl<OrderDetailMapper, OrderDetail> implements OrderDetailService {

}
