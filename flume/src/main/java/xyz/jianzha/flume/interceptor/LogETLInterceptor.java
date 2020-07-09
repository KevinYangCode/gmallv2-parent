package xyz.jianzha.flume.interceptor;

import org.apache.flume.Context;
import org.apache.flume.Event;
import org.apache.flume.interceptor.Interceptor;
import xyz.jianzha.flume.utils.LogUtils;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Y_Kevin
 * @date 2020-07-09 14:35
 */
public class LogETLInterceptor implements Interceptor {
    @Override
    public void initialize() {
    }

    @Override
    public Event intercept(Event event) {
        // 清洗数据 ETL

        // 1、获取日志
        String log = new String(event.getBody(), Charset.forName("UTF-8"));

        // 3、区分类型处理
        if (log.contains("start")) {
            // 验证启动日志的逻辑
            if (LogUtils.validateStart(log)) {
                return event;
            }
        } else {
            // 验证事件日志额逻辑
            if (LogUtils.validateEvent(log)) {
                return event;
            }
        }
        return event;
    }

    @Override
    public List<Event> intercept(List<Event> events) {
        // 多event
        ArrayList<Event> interceptorList = new ArrayList<>();

        // 取出校验合格数据返回
        for (Event event : events) {
            Event intercept = intercept(event);
            if (intercept != null) {
                interceptorList.add(intercept);
            }
        }
        return interceptorList;
    }

    @Override
    public void close() {
    }

    public static class Builder implements Interceptor.Builder{
        @Override
        public Interceptor build() {
            return new LogETLInterceptor();
        }

        @Override
        public void configure(Context context) {
        }
    }
}
