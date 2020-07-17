package xyz.jianzha.udtf;

import org.apache.commons.lang3.StringUtils;
import org.apache.hadoop.hive.ql.exec.UDFArgumentException;
import org.apache.hadoop.hive.ql.metadata.HiveException;
import org.apache.hadoop.hive.ql.udf.generic.GenericUDTF;
import org.apache.hadoop.hive.serde2.objectinspector.ObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.ObjectInspectorFactory;
import org.apache.hadoop.hive.serde2.objectinspector.StructObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.primitive.PrimitiveObjectInspectorFactory;
import org.json.JSONArray;
import org.json.JSONException;

import java.util.ArrayList;

/**
 * @author Y_Kevin
 * @date 2020-07-17 17:27
 */
public class EventJsonUDTF extends GenericUDTF {
    @Override
    public StructObjectInspector initialize(StructObjectInspector argOIs) throws UDFArgumentException {
        // 定义UDTF返回值类型和名称
        ArrayList<String> fieldName = new ArrayList<>();
        ArrayList<ObjectInspector> fieldType = new ArrayList<>();

        fieldName.add("event_name");
        fieldName.add("event_json");
        fieldType.add(PrimitiveObjectInspectorFactory.javaStringObjectInspector);
        fieldType.add(PrimitiveObjectInspectorFactory.javaStringObjectInspector);

        return ObjectInspectorFactory.getStandardStructObjectInspector(fieldName, fieldType);
    }

    /**
     * 输入 1 条记录，输出若干条结果
     *
     * @param objects
     * @throws HiveException
     */
    @Override
    public void process(Object[] objects) throws HiveException {
        // 传入的是json array => UDF 传入et
        String input = objects[0].toString();

        // 合法校验
        if (StringUtils.isBlank(input)) {
            return;
        } else {
            try {
                JSONArray jsonArray = new JSONArray(input);
                // 循环遍历array当中每一个元素，封装成返回的 事件名称和事件内容
                for (int i = 0; i < jsonArray.length(); i++) {
//                {
//                    "ett":"1594324433618",
//                        "en":"display",
//                        "kv":{
//                            "goodsid":"0",
//                            "action":"1",
//                            "extend1":"1",
//                            "place":"0",
//                            "category":"21"
//                        }
//                }
                    String[] result = new String[2];
                    try {
                        // 取出每个的事件名称（en/display）
                        result[0] = jsonArray.getJSONObject(i).getString("en");
                        // 取出每一个事件整体
                        result[1] = jsonArray.getString(i);
                    } catch (JSONException e) {
                        continue;
                    }
                    // 写出
                    forward(result);
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 当没有记录处理的时候该方法会被调用，用来清理代码或者产生额外的输出
     *
     * @throws HiveException
     */
    @Override
    public void close() throws HiveException {

    }
}
