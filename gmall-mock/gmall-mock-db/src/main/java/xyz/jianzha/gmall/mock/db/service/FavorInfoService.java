package xyz.jianzha.gmall.mock.db.service;

import com.baomidou.mybatisplus.extension.service.IService;
import xyz.jianzha.gmall.mock.db.bean.FavorInfo;

/**
 * 商品收藏表 服务类
 *
 * @author Y_Kevin
 * @date 2020-07-12 14:08
 */
public interface FavorInfoService extends IService<FavorInfo> {

    void genFavors(Boolean ifClear);

}
