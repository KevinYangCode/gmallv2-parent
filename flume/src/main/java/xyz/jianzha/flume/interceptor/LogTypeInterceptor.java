package xyz.jianzha.flume.interceptor;

import org.apache.flume.Context;
import org.apache.flume.Event;
import org.apache.flume.interceptor.Interceptor;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author Y_Kevin
 * @date 2020-07-09 14:35
 */
public class LogTypeInterceptor implements Interceptor {
    @Override
    public void initialize() {
    }

    @Override
    public Event intercept(Event event) {
        // 区分类型 start event
        // body header

        // 获取body
        String log = new String(event.getBody(), Charset.forName("UTF-8"));

        // 获取header
        Map<String, String> headers = event.getHeaders();

        // 业务逻辑判断
        if (log.contains("start")) {
            headers.put("topic", "topic_start");
        } else {
            headers.put("topic", "topic_event");
        }
        return event;
    }

    @Override
    public List<Event> intercept(List<Event> events) {
        ArrayList<Event> interceptorList = new ArrayList<>();

        for (Event event : events) {
            Event intercept = intercept(event);
            interceptorList.add(intercept);
        }
        return interceptorList;
    }

    @Override
    public void close() {
    }

    public static class Builder implements Interceptor.Builder {
        @Override
        public Interceptor build() {
            return new LogTypeInterceptor();
        }

        @Override
        public void configure(Context context) {
        }
    }
}
