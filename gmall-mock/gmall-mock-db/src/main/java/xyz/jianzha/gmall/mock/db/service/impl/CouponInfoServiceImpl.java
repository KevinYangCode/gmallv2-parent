package xyz.jianzha.gmall.mock.db.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import xyz.jianzha.gmall.mock.db.bean.CouponInfo;
import xyz.jianzha.gmall.mock.db.mapper.CouponInfoMapper;
import xyz.jianzha.gmall.mock.db.service.CouponInfoService;

/**
 * 优惠券表 服务实现类
 *
 * @author Y_Kevin
 * @date 2020-07-12 15:03
 */
@Service
public class CouponInfoServiceImpl extends ServiceImpl<CouponInfoMapper, CouponInfo> implements CouponInfoService {

}
