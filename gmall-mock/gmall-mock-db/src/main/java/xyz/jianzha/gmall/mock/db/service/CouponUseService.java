package xyz.jianzha.gmall.mock.db.service;

import com.baomidou.mybatisplus.extension.service.IService;
import xyz.jianzha.gmall.mock.db.bean.CouponUse;
import xyz.jianzha.gmall.mock.db.bean.OrderInfo;

import java.util.List;

/**
 * 优惠券领用表 服务类
 *
 * @author Y_Kevin
 * @date 2020-07-12 14:08
 */
public interface CouponUseService extends IService<CouponUse> {

    void genCoupon(Boolean ifClear);

    void usedCoupon(List<OrderInfo> orderInfoList);

    List<CouponUse> usingCoupon(List<OrderInfo> orderInfoList);

    void saveCouponUseList(List<CouponUse> couponUseList);
}
