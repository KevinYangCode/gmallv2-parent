package xyz.jianzha.bean;

/**
 * 错误日志
 *
 * @author Y_Kevin
 * @date 2020-06-28 23:18
 */
public class AppErrorLog {

    /**
     * 错误摘要
     */
    private String errorBrief;

    /**
     * 错误详情
     */
    private String errorDetail;

    public String getErrorBrief() {
        return errorBrief;
    }

    public void setErrorBrief(String errorBrief) {
        this.errorBrief = errorBrief;
    }

    public String getErrorDetail() {
        return errorDetail;
    }

    public void setErrorDetail(String errorDetail) {
        this.errorDetail = errorDetail;
    }
}
