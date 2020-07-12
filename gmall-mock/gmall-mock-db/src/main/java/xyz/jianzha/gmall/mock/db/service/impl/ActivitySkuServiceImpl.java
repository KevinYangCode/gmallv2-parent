package xyz.jianzha.gmall.mock.db.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import xyz.jianzha.gmall.mock.db.bean.ActivitySku;
import xyz.jianzha.gmall.mock.db.mapper.ActivitySkuMapper;
import xyz.jianzha.gmall.mock.db.service.ActivitySkuService;

/**
 * 活动参与商品 服务实现类
 *
 * @author Y_Kevin
 * @date 2020-07-12 15:00
 */
@Service
public class ActivitySkuServiceImpl extends ServiceImpl<ActivitySkuMapper, ActivitySku> implements ActivitySkuService {

}
