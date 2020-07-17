package xyz.jianzha.udf;

import org.apache.commons.lang3.StringUtils;
import org.apache.hadoop.hive.ql.exec.UDF;
import org.json.JSONObject;

/**
 * @author Y_Kevin
 * @date 2020-07-17 16:21
 */
public class BaseFieldUDF extends UDF {

    public String evaluate(String line, String key) {
        // 切割
        String[] log = line.split("\\|");
        // 合法性判断
        if (log.length != 2 || StringUtils.isBlank(log[1].trim())) {
            return "";
        }

        JSONObject json = new JSONObject(log[1].trim());
        String result = "";

        // st serverTime
        // 根据传入的可以取值
        if ("st".equals(key)) {
            // 返回服务器时间
            result = log[0].trim();
        } else if ("et".equals(key)) {
            if (json.has("et")) {
                result = json.getString("et");
            }
        } else {
            // 获取cm对应的value
            JSONObject cm = json.getJSONObject("cm");
            if (cm.has(key)) {
                result = cm.getString(key);
            }
        }
        return result;
    }

//    public static void main(String[] args) {
//        String line = "1594395661254|{\"cm\":{\"ln\":\"-53.2\",\"sv\":\"V2.8.8\",\"os\":\"8.2.9\",\"g\":\"58A7V1FC@gmail.com\",\"mid\":\"0\",\"nw\":\"4G\",\"l\":\"en\",\"vc\":\"15\",\"hw\":\"640*960\",\"ar\":\"MX\",\"uid\":\"0\",\"t\":\"1594319475589\",\"la\":\"17.7\",\"md\":\"Huawei-8\",\"vn\":\"1.2.5\",\"ba\":\"Huawei\",\"sr\":\"J\"},\"ap\":\"app\",\"et\":[{\"ett\":\"1594324433618\",\"en\":\"display\",\"kv\":{\"goodsid\":\"0\",\"action\":\"1\",\"extend1\":\"1\",\"place\":\"0\",\"category\":\"21\"}},{\"ett\":\"1594349494075\",\"en\":\"loading\",\"kv\":{\"extend2\":\"\",\"loading_time\":\"36\",\"action\":\"3\",\"extend1\":\"\",\"type\":\"2\",\"type1\":\"\",\"loading_way\":\"2\"}},{\"ett\":\"1594295826589\",\"en\":\"error\",\"kv\":{\"errorDetail\":\"java.lang.NullPointerException\\\\n    at cn.lift.appIn.web.AbstractBaseController.validInbound(AbstractBaseController.java:72)\\\\n at cn.lift.dfdf.web.AbstractBaseController.validInbound\",\"errorBrief\":\"at cn.lift.appIn.control.CommandUtil.getInfo(CommandUtil.java:67)\"}},{\"ett\":\"1594309882840\",\"en\":\"praise\",\"kv\":{\"target_id\":3,\"id\":4,\"type\":3,\"add_time\":\"1594382310825\",\"userid\":7}}]}";
//
//        String result = new BaseFieldUDF().evaluate(line, "et");
//        System.out.println(result);
//    }
}
