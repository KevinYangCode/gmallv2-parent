package xyz.jianzha.gmall.mock.log.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import xyz.jianzha.gmall.mock.db.util.RandomNum;
import xyz.jianzha.gmall.mock.db.util.RandomOptionGroup;
import xyz.jianzha.gmall.mock.log.enums.DisplayType;
import xyz.jianzha.gmall.mock.log.enums.ItemType;
import xyz.jianzha.gmall.mock.log.enums.PageId;

import java.util.ArrayList;
import java.util.List;

import static xyz.jianzha.gmall.mock.log.config.AppConfig.*;

/**
 * @author Y_Kevin
 * @date 2020-07-12 16:36
 */
@Data
@AllArgsConstructor
public class AppDisplay {

    ItemType itemType;

    String item;

    DisplayType displayType;

    Integer order;

    public static List<AppDisplay> buildList(AppPage appPage) {
        List<AppDisplay> displayList = new ArrayList<>();

        if (appPage.pageId == PageId.home || appPage.pageId == PageId.discovery
                || appPage.pageId == PageId.category) {
            int displayCount = RandomNum.getRandInt(1, max_activity_count);
            for (int i = 1; i <= displayCount; i++) {
                int actId = RandomNum.getRandInt(1, max_activity_count);
                AppDisplay appDisplay = new AppDisplay(ItemType.activity_id, actId + "", DisplayType.activity, i);
                displayList.add(appDisplay);
            }
        }
        //商品明细
        if (appPage.pageId == PageId.good_detail
                //   首页
                || appPage.pageId == PageId.home
                // 分类
                || appPage.pageId == PageId.category
                // 活动
                || appPage.pageId == PageId.activity
                //  规格
                || appPage.pageId == PageId.good_spec
                // 商品列表
                || appPage.pageId == PageId.good_list
                // 发现
                || appPage.pageId == PageId.discovery) {

            int displayCount = RandomNum.getRandInt(min_display_count, max_display_count);
            // 商品显示从 活动后面开始
            int activityCount = displayList.size();
            for (int i = 1 + activityCount; i <= displayCount + activityCount; i++) {
                int skuId = RandomNum.getRandInt(1, max_sku_id);
                RandomOptionGroup<DisplayType> dispTypeGroup = RandomOptionGroup.<DisplayType>builder().add(DisplayType.promotion, 30)
                        .add(DisplayType.query, 60).add(DisplayType.recommend, 10).build();
                DisplayType displayType = dispTypeGroup.getValue();

                AppDisplay appDisplay = new AppDisplay(ItemType.sku_id, skuId + "", displayType, i);
                displayList.add(appDisplay);
            }
        }
        return displayList;
    }
}

