package xyz.jianzha.gmall.mock.log.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import xyz.jianzha.gmall.mock.db.util.RandomNum;

import java.net.ConnectException;

/**
 * @author Y_Kevin
 * @date 2020-07-12 16:37
 */
@Data
@AllArgsConstructor
public class AppError {

    Integer errorCode;

    String msg;

    public static AppError build() {
        int errorCode = RandomNum.getRandInt(1001, 4001);
        String msg = " Exception in thread \\  java.net.SocketTimeoutException\\n \\tat com.atgugu.gmall2020.mock.log.bean.AppError.main(AppError.java:xxxxxx)";
        return new AppError(errorCode, msg);
    }

    public static void main(String[] args) throws Exception {
        throw new ConnectException();
    }
}
