package xyz.jianzha.gmall.mock.db.util;

import java.util.Date;
import java.util.Random;

/**
 * @author Y_Kevin
 * @date 2020-07-11 23:28
 */
public class RandomDate {
    Long logDateTime = 0L;
    int maxTimeStep = 0;

    public RandomDate(Date startDate, Date endDate, int num) {
        long avgStepTime = (endDate.getTime() - startDate.getTime()) / num;
        this.maxTimeStep = (int) avgStepTime * 2;
        this.logDateTime = startDate.getTime();

    }

    public Date getRandomDate() {
        int timeStep = new Random().nextInt(maxTimeStep);
        logDateTime = logDateTime + timeStep;
        return new Date(logDateTime);
    }
}