package xyz.jianzha.gmall.mock.db.service;

import com.baomidou.mybatisplus.extension.service.IService;
import xyz.jianzha.gmall.mock.db.bean.CartInfo;

/**
 * 购物车表 用户登录系统时更新冗余 服务类
 *
 * @author Y_Kevin
 * @date 2020-07-12 14:06
 */
public interface CartInfoService extends IService<CartInfo> {

    void genCartInfo(boolean ifClear);

}
