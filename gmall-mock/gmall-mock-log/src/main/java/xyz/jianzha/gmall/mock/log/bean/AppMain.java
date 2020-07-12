package xyz.jianzha.gmall.mock.log.bean;

import com.alibaba.fastjson.JSON;
import lombok.Builder;
import lombok.Data;
import xyz.jianzha.gmall.mock.db.util.RandomOptionGroup;
import xyz.jianzha.gmall.mock.log.config.AppConfig;

import java.util.List;

/**
 * @author Y_Kevin
 * @date 2020-07-12 16:37
 */
@Data
@Builder
public class AppMain {

    /**
     * (String) 客户端日志产生时的时间
     */
    private Long ts;

    private AppCommon common;

    private AppPage page;

    private AppError err;

    private AppNotice notice;

    private AppStart start;

    private List<AppDisplay> displays;
    private List<AppAction> actions;

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }

    public static class AppMainBuilder {
        public void checkError() {
            Integer errorRate = AppConfig.error_rate;
            Boolean ifError = RandomOptionGroup.builder().add(true, errorRate).add(false, 100 - errorRate).build().getRandBoolValue();
            if (ifError) {
                this.err = AppError.build();
            }
        }
    }
}
