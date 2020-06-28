package xyz.jianzha.bean;

/**
 * 收藏
 *
 * @author Y_Kevin
 * @date 2020-06-28 23:17
 */
public class AppFavorites {
    /**
     * 主键
     */
    private int id;

    /**
     * 商品id
     */
    private int course_id;

    /**
     * 用户ID
     */
    private int userid;

    /**
     * 创建时间
     */
    private String add_time;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCourse_id() {
        return course_id;
    }

    public void setCourse_id(int course_id) {
        this.course_id = course_id;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getAdd_time() {
        return add_time;
    }

    public void setAdd_time(String add_time) {
        this.add_time = add_time;
    }
}
