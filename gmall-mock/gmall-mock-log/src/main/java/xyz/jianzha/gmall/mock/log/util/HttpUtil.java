package xyz.jianzha.gmall.mock.log.util;

import okhttp3.*;
import xyz.jianzha.gmall.mock.log.config.AppConfig;

import java.io.IOException;

/**
 * @author Y_Kevin
 * @date 2020-07-12 16:12
 */
public class HttpUtil {

    private static OkHttpClient client;

    private HttpUtil() {
    }

    public static OkHttpClient getInstance() {
        if (client == null) {
            synchronized (HttpUtil.class) {
                if (client == null) {
                    client = new OkHttpClient();
                }
            }
        }
        return client;
    }

    public static void post(String json) {

        RequestBody requestBody = RequestBody.create(MediaType.parse("application/json; charset=utf-8"), json);
        Request request = new Request.Builder()
                .url(AppConfig.mock_url)
                //post请求
                .post(requestBody)
                .build();
        Call call = HttpUtil.getInstance().newCall(request);
        Response response = null;
        try {
            response = call.execute();
            System.out.println(response.body().string());
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("发送失败...检查网络地址...");
        }
    }
}

