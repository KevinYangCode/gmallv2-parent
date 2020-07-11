package xyz.jianzha.gmall.mock.db.util;

/**
 * @author Y_Kevin
 * @date 2020-07-11 23:37
 */
public class RanOpt<T> {
    T value;
    int weight;

    public RanOpt(T value, int weight) {
        this.value = value;
        this.weight = weight;
    }

    public T getValue() {
        return value;
    }

    public int getWeight() {
        return weight;
    }
}
