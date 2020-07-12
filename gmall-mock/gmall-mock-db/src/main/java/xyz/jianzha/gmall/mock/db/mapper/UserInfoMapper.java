package xyz.jianzha.gmall.mock.db.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Update;
import xyz.jianzha.gmall.mock.db.bean.UserInfo;

/**
 * 用户表 Mapper 接口
 *
 * @author Y_Kevin
 * @date 2020-07-12 13:56
 */
public interface UserInfoMapper extends BaseMapper<UserInfo> {

    @Update("truncate table user_info")
    void truncateUserInfo();
}
