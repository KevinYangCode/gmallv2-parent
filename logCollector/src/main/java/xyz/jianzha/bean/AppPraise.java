package xyz.jianzha.bean;

/**
 * 点赞
 *
 * @author Y_Kevin
 * @date 2020-06-28 23:19
 */
public class AppPraise {
    /**
     * 主键id
     */
    private int id;

    /**
     * 用户id
     */
    private int userid;

    /**
     * 点赞的对象id
     */
    private int target_id;

    /**
     * 点赞类型 1问答点赞 2问答评论点赞 3 文章点赞数4 评论点赞
     */
    private int type;

    /**
     * 添加时间
     */
    private String add_time;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getTarget_id() {
        return target_id;
    }

    public void setTarget_id(int target_id) {
        this.target_id = target_id;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getAdd_time() {
        return add_time;
    }

    public void setAdd_time(String add_time) {
        this.add_time = add_time;
    }
}

