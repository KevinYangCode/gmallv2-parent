package xyz.jianzha.gmall.mock.log.bean;

import lombok.Data;
import xyz.jianzha.gmall.mock.db.util.RandomNum;
import xyz.jianzha.gmall.mock.db.util.RandomOptionGroup;
import xyz.jianzha.gmall.mock.log.config.AppConfig;
import xyz.jianzha.gmall.mock.log.enums.ActionId;
import xyz.jianzha.gmall.mock.log.enums.ItemType;
import xyz.jianzha.gmall.mock.log.enums.PageId;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Y_Kevin
 * @date 2020-07-12 16:09
 */
@Data
public class AppAction {

    public AppAction(ActionId actionId, ItemType itemType, String item) {
        this.actionId = actionId;
        this.itemType = itemType;
        this.item = item;
    }

    ActionId actionId;

    ItemType itemType;

    String item;

    String extend1;

    String extend2;

    Long ts;

    public static List<AppAction> buildList(AppPage appPage, Long startTs, Integer duringTime) {

        List<AppAction> actionList = new ArrayList<>();
        Boolean ifFavor = RandomOptionGroup.builder().add(true, AppConfig.if_favor_rate)
                .add(false, 100 - AppConfig.if_favor_rate).build().getRandBoolValue();
        Boolean ifCart = RandomOptionGroup.builder().add(true, AppConfig.if_cart_rate)
                .add(false, 100 - AppConfig.if_cart_rate).build().getRandBoolValue();
        Boolean ifCartAddNum = RandomOptionGroup.builder().add(true, AppConfig.if_cart_add_num_rate)
                .add(false, 100 - AppConfig.if_cart_add_num_rate).build().getRandBoolValue();
        Boolean ifCartMinusNum = RandomOptionGroup.builder().add(true, AppConfig.if_cart_minus_num_rate)
                .add(false, 100 - AppConfig.if_cart_minus_num_rate).build().getRandBoolValue();
        Boolean ifCartRm = RandomOptionGroup.builder().add(true, AppConfig.if_cart_rm_rate)
                .add(false, 100 - AppConfig.if_cart_rm_rate).build().getRandBoolValue();
        if (appPage.pageId == PageId.good_detail) {

            if (ifFavor) {
                AppAction favorAction = new AppAction(ActionId.favor_add, appPage.itemType, appPage.item);
                actionList.add(favorAction);
            }
            if (ifCart) {
                AppAction favorAction = new AppAction(ActionId.cart_add, appPage.itemType, appPage.item);
                actionList.add(favorAction);
            }
        } else if (appPage.pageId == PageId.cart) {

            if (ifCartAddNum) {
                int skuId = RandomNum.getRandInt(1, AppConfig.max_sku_id);
                AppAction favorAction = new AppAction(ActionId.cart_add_num, ItemType.sku_id, skuId + "");
                actionList.add(favorAction);
            }
            if (ifCartMinusNum) {
                int skuId = RandomNum.getRandInt(1, AppConfig.max_sku_id);
                AppAction favorAction = new AppAction(ActionId.cart_minus_num, ItemType.sku_id, skuId + "");
                actionList.add(favorAction);
            }
            if (ifCartRm) {
                int skuId = RandomNum.getRandInt(1, AppConfig.max_sku_id);
                AppAction favorAction = new AppAction(ActionId.cart_remove, ItemType.sku_id, skuId + "");
                actionList.add(favorAction);
            }
        } else if (appPage.pageId == PageId.trade) {
            Boolean ifAddAddress = RandomOptionGroup.builder().add(true, AppConfig.if_add_address)
                    .add(false, 100 - AppConfig.if_add_address).build().getRandBoolValue();
            if (ifAddAddress) {
                AppAction appAction = new AppAction(ActionId.trade_add_address, null, null);
                actionList.add(appAction);
            }
        } else if (appPage.pageId == PageId.favor) {
            Boolean ifFavorCancel = RandomOptionGroup.builder().add(true, AppConfig.if_favor_cancel_rate)
                    .add(false, 100 - AppConfig.if_favor_cancel_rate).build().getRandBoolValue();
            int skuId = RandomNum.getRandInt(1, AppConfig.max_sku_id);
            for (int i = 0; i < 3; i++) {
                if (ifFavorCancel) {
                    AppAction appAction = new AppAction(ActionId.favor_canel, ItemType.sku_id, skuId + i + "");
                    actionList.add(appAction);
                }
            }
        }

        int size = actionList.size();
        long avgActionTime = duringTime / (size + 1);
        for (int i = 1; i <= actionList.size(); i++) {
            AppAction appAction = actionList.get(i - 1);
            appAction.setTs(startTs + i * avgActionTime);
        }
        return actionList;
    }
}
