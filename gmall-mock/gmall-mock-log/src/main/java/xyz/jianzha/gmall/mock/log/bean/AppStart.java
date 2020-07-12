package xyz.jianzha.gmall.mock.log.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import xyz.jianzha.gmall.mock.db.util.RanOpt;
import xyz.jianzha.gmall.mock.db.util.RandomNum;
import xyz.jianzha.gmall.mock.db.util.RandomOptionGroup;

/**
 * @author Y_Kevin
 * @date 2020-07-12 16:38
 */
@Data
@AllArgsConstructor
public class AppStart {

    /**
     * 入口：  安装后进入=install，  点击图标= icon，  点击通知= notice
     */
    private String entry;
    /**
     * 开屏广告Id
     */
    private Long openAdId;
    /**
     * 开屏广告持续时间
     */
    private Integer openAdMs;
    /**
     * 开屏广告点击掉过的时间  未点击为0
     */
    private Integer openAdSkipMs;
    /**
     * 加载时长：计算下拉开始到接口返回数据的时间，（开始加载报0，加载成功或加载失败才上报时间）
     */
    private Integer loadingTime;

    public static class Builder {
        /**
         * 入口： 安装后进入=install，  点击图标= icon，  点击通知= notice
         */
        private final String entry;
        /**
         * 开屏广告Id
         */
        private final Long open_ad_id;
        /**
         * 开屏广告持续时间
         */
        private final Integer open_ad_ms;
        /**
         * 开屏广告持续多长时间，点击跳过 未点击为0
         */
        private final Integer open_ad_skip_ms;
        /**
         * 加载时长：计算下拉开始到接口返回数据的时间，（开始加载报0，加载成功或加载失败才上报时间）
         */
        private final Integer loading_time;

        public Builder() {
            entry = new RandomOptionGroup<>(new RanOpt<String>("install", 5),
                    new RanOpt<>("icon", 75),
                    new RanOpt<>("notice", 20)).getRandStringValue();
            open_ad_id = (long) RandomNum.getRandInt(1, 20);
            open_ad_ms = RandomNum.getRandInt(1000, 10000);
            open_ad_skip_ms = RandomOptionGroup.builder().add(0, 50)
                    .add(RandomNum.getRandInt(1000, open_ad_ms), 50).build().getRandIntValue();
            loading_time = RandomNum.getRandInt(1000, 20000);
        }

        public AppStart build() {
            return new AppStart(entry, open_ad_id, open_ad_ms, open_ad_skip_ms, loading_time);
        }
    }
}

