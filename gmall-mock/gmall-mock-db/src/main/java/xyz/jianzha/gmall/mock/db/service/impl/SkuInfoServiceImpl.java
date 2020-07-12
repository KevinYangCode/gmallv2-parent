package xyz.jianzha.gmall.mock.db.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import xyz.jianzha.gmall.mock.db.bean.SkuInfo;
import xyz.jianzha.gmall.mock.db.mapper.SkuInfoMapper;
import xyz.jianzha.gmall.mock.db.service.SkuInfoService;

/**
 * 库存单元表 服务实现类
 *
 * @author Y_Kevin
 * @date 2020-07-12 15:17
 */
@Service
public class SkuInfoServiceImpl extends ServiceImpl<SkuInfoMapper, SkuInfo> implements SkuInfoService {

}
