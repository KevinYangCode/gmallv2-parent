package xyz.jianzha.gmall.mock.db.service;

import com.baomidou.mybatisplus.extension.service.IService;
import xyz.jianzha.gmall.mock.db.bean.CommentInfo;

/**
 * 商品评论表 服务类
 *
 * @author Y_Kevin
 * @date 2020-07-12 14:07
 */
public interface CommentInfoService extends IService<CommentInfo> {

    void genComments(Boolean ifClear);

}