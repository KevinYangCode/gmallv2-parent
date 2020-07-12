package xyz.jianzha.gmall.mock.db.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import xyz.jianzha.gmall.mock.db.bean.CommentInfo;
import xyz.jianzha.gmall.mock.db.bean.OrderDetail;
import xyz.jianzha.gmall.mock.db.bean.OrderInfo;
import xyz.jianzha.gmall.mock.db.bean.SkuInfo;
import xyz.jianzha.gmall.mock.db.constant.GmallConstant;
import xyz.jianzha.gmall.mock.db.mapper.CommentInfoMapper;
import xyz.jianzha.gmall.mock.db.mapper.SkuInfoMapper;
import xyz.jianzha.gmall.mock.db.mapper.UserInfoMapper;
import xyz.jianzha.gmall.mock.db.service.CommentInfoService;
import xyz.jianzha.gmall.mock.db.service.OrderInfoService;
import xyz.jianzha.gmall.mock.db.util.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 商品评论表 服务实现类
 *
 * @author Y_Kevin
 * @date 2020-07-12 15:02
 */
@Service
@Slf4j
public class CommentInfoServiceImpl extends ServiceImpl<CommentInfoMapper, CommentInfo> implements CommentInfoService {

    @Autowired
    SkuInfoMapper skuInfoMapper;

    @Autowired
    UserInfoMapper userInfoMapper;

    @Autowired
    OrderInfoService orderInfoService;

    @Value("${mock.date}")
    String mockDate;

    @Value("${mock.comment.appraise-rate:30:10:10:50}")
    String appraiseRate;

    @Override
    public void genComments(Boolean ifClear) {
        if (ifClear) {
            remove(new QueryWrapper<>());
        }

        Integer userTotal = userInfoMapper.selectCount(new QueryWrapper<>());

        List<CommentInfo> commentInfoList = new ArrayList<>();
        List<OrderInfo> orderInfoFinishList = orderInfoService.listWithDetail(new QueryWrapper<OrderInfo>().eq("order_status", GmallConstant.ORDER_STATUS_FINISH), true);
        for (OrderInfo orderInfo : orderInfoFinishList) {
            for (OrderDetail orderDetail : orderInfo.getOrderDetailList()) {
                Long userId = (long) RandomNum.getRandInt(1, userTotal);
                commentInfoList.add(initCommentInfo(orderDetail.getSkuInfo(), orderInfo, userId));
            }
        }
        log.warn("共生成评价" + commentInfoList.size() + "条");
        saveBatch(commentInfoList, 100);
    }

    public CommentInfo initCommentInfo(SkuInfo skuInfo, OrderInfo orderInfo, Long userId) {
        Date date = ParamUtil.checkDate(mockDate);
        Integer[] appraiseRateWeight = ParamUtil.checkRate(this.appraiseRate, 4);
        RandomOptionGroup<String> appraiseOptionGroup = new RandomOptionGroup(new RanOpt<>(GmallConstant.APPRAISE_GOOD, appraiseRateWeight[0]),
                new RanOpt<>(GmallConstant.APPRAISE_SOSO, appraiseRateWeight[1]), new RanOpt<>(GmallConstant.APPRAISE_BAD, appraiseRateWeight[2]),
                new RanOpt<>(GmallConstant.APPRAISE_AUTO, appraiseRateWeight[3]));

        CommentInfo commentInfo = new CommentInfo();
        commentInfo.setOrderId(orderInfo.getId());
        commentInfo.setSkuId(skuInfo.getId());
        commentInfo.setSpuId(skuInfo.getSpuId());
        commentInfo.setUserId(userId);
        commentInfo.setCommentTxt("评论内容：" + RandomNumString.getRandNumString(1, 9, 50, ""));
        commentInfo.setCreateTime(date);
        commentInfo.setAppraise(appraiseOptionGroup.getRandStringValue());
        return commentInfo;
    }
}
