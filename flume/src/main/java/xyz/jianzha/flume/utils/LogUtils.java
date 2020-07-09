package xyz.jianzha.flume.utils;

import org.apache.commons.lang.math.NumberUtils;

/**
 * @author Y_Kevin
 * @date 2020-07-09 14:49
 */
public class LogUtils {

    /**
     * 验证启动日志
     *
     * @param log
     * @return
     */
    public static boolean validateStart(String log) {

        if (log == null) {
            return false;
        }
        // 判断数据是否是 { 开头 是否是 } 结尾
        return log.trim().startsWith("{") && log.trim().endsWith("}");
    }

    /**
     * 验证事件日志
     *
     * @param log
     * @return
     */
    public static boolean validateEvent(String log) {

        // 1594212722893|{"cm":{"ln":"-104.2","sv":"V2.9.7","os":"8.2.9","g":"1KACL64C@gmail.com","mid":"0","nw":"4G","l":"pt","vc":"13","hw":"1080*1920","ar":"MX","uid":"0","t":"1594119782630",
        // 服务器时间 | 日志内容
        if (log == null) {
            return false;
        }

        // 切割
        String[] logContents = log.split("\\|");

        if (logContents.length != 2) {
            return false;
        }
        // 校验服务器时间 (长度必须是13位  必须全部是数字)
        if (logContents[0].length() != 13 || !NumberUtils.isDigits(logContents[0])) {
            return false;
        }

        // 校验事日志格式
        return logContents[1].trim().startsWith("{") && logContents[1].trim().startsWith("}");
    }
}
