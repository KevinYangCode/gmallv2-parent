package xyz.jianzha.gmall.mock.db.service;

import com.baomidou.mybatisplus.extension.service.IService;
import xyz.jianzha.gmall.mock.db.bean.UserInfo;

/**
 * 用户表 服务类
 *
 * @author Y_Kevin
 * @date 2020-07-12 14:31
 */
public interface UserInfoService extends IService<UserInfo> {

    void genUserInfos(Boolean ifClear);

}
