package xyz.jianzha.gmall.mock.db.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import xyz.jianzha.gmall.mock.db.bean.ActivityInfo;
import xyz.jianzha.gmall.mock.db.mapper.ActivityInfoMapper;
import xyz.jianzha.gmall.mock.db.service.ActivityInfoService;

/**
 * 活动表 服务实现类
 *
 * @author Y_Kevin
 * @date 2020-07-12 14:34
 */
@Service
public class ActivityInfoServiceImpl extends ServiceImpl<ActivityInfoMapper, ActivityInfo> implements ActivityInfoService {

}
