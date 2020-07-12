package xyz.jianzha.gmall.mock.db.service;

import com.baomidou.mybatisplus.extension.service.IService;
import xyz.jianzha.gmall.mock.db.bean.PaymentInfo;

/**
 * 支付流水表 服务类
 *
 * @author Y_Kevin
 * @date 2020-07-12 14:14
 */
public interface PaymentInfoService extends IService<PaymentInfo> {
    void genPayments(Boolean ifClear);
}
