package xyz.jianzha.gmall.mock.log.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import xyz.jianzha.gmall.mock.db.util.ParamUtil;

import java.util.Date;

/**
 * @author Y_Kevin
 * @date 2020-07-12 16:13
 */
@Configuration
public class AppConfig {

    public static Date date = new Date();

    public static Integer mock_count = 1000;

    public static String mock_type = "log";

    public static String mock_url = "http://localhost:80";

    public static Integer max_mid = 500;

    public static Integer max_uid = 500;

    public static Integer max_sku_id = 10;

    public static Integer page_during_max_ms = 20000;

    public static Integer error_rate = 3;

    public static Integer log_sleep = 100;

    public static Integer if_favor_rate = 30;

    public static Integer if_favor_cancel_rate = 10;

    public static Integer if_cart_rate = 10;

    public static Integer if_cart_add_num_rate = 10;

    public static Integer if_cart_minus_num_rate = 10;

    public static Integer if_cart_rm_rate = 10;

    public static Integer if_add_address = 15;

    public static Integer max_display_count = 10;

    public static Integer min_display_count = 4;

    public static Integer max_activity_count = 2;

    public static Integer[] sourceTypeRate;

    @Value("${mock.type}")
    public void setMockType(String mockType) {
        AppConfig.mock_type = mockType;
    }

    @Value("${mock.url}")
    public void setMockUrl(String mockUrl) {
        AppConfig.mock_url = mockUrl;
    }

    @Value("${mock.startup.count}")
    public void setMockCount(String mockCount) {
        AppConfig.mock_count = ParamUtil.checkCount(mockCount);
    }

    @Value("${mock.max.mid}")
    public void setMaxMid(String maxMid) {
        AppConfig.max_mid = ParamUtil.checkCount(maxMid);
    }

    @Value("${mock.max.uid}")
    public void setMaxUid(String maxUid) {
        AppConfig.max_uid = ParamUtil.checkCount(maxUid);
    }

    @Value("${mock.max.sku-id}")
    public void setMaxSkuId(String maxSkuId) {
        AppConfig.max_sku_id = ParamUtil.checkCount(maxSkuId);
    }

    @Value("${mock.page.during-time-ms}")
    public void setPageDuringMaxMs(String pageDuringMaxMs) {
        AppConfig.page_during_max_ms = ParamUtil.checkCount(pageDuringMaxMs);
    }

    @Value("${mock.error.rate}")
    public void setErrorRate(String errorRate) {
        AppConfig.error_rate = ParamUtil.checkRatioNum(errorRate);
    }

    @Value("${mock.log.sleep}")
    public void setLogSleep(String logSleep) {
        AppConfig.log_sleep = ParamUtil.checkCount(logSleep);
    }

    public static void setIfFavorRate(Integer ifFavorRate) {
        AppConfig.if_favor_rate = ifFavorRate;
    }

    public static void setIfFavorCancelRate(Integer ifFavorCancelRate) {
        AppConfig.if_favor_cancel_rate = ifFavorCancelRate;
    }

    public static void setIfCartRate(Integer ifCartRate) {
        AppConfig.if_cart_rate = ifCartRate;
    }

    public static void setIfCartAddNumRate(Integer ifCartAddNumRate) {
        AppConfig.if_cart_add_num_rate = ifCartAddNumRate;
    }

    public static void setIfCartMinusNumRate(Integer ifCartMinusNumRate) {
        AppConfig.if_cart_minus_num_rate = ifCartMinusNumRate;
    }

    public static void setIfCartRmRate(Integer ifCartRmRate) {
        AppConfig.if_cart_rm_rate = ifCartRmRate;
    }

    public static void setIfAddAddress(Integer ifAddAddress) {
        AppConfig.if_add_address = ifAddAddress;
    }

    public static void setMaxDisplayCount(Integer maxDisplayCount) {
        AppConfig.max_display_count = maxDisplayCount;
    }

    public static void setMinDisplayCount(Integer minDisplayCount) {
        AppConfig.min_display_count = minDisplayCount;
    }

    public static void setMaxActivityCount(Integer maxActivityCount) {
        AppConfig.max_activity_count = maxActivityCount;
    }

    @Value("${mock.date}")
    public void setMockDate(String mockDate) {
        AppConfig.date = ParamUtil.checkDate(mockDate);
    }

    @Value("${mock.detail.source-type-rate}")
    public void setSourceType(String sourceTypeRate) {
        AppConfig.sourceTypeRate = ParamUtil.checkRate(sourceTypeRate, 4);
    }
}
