package model;

public class LoginBean {
    // ÇÊµå(¼Ó¼º)
    private String id;
    private String password;

    // Getter Setter
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    // ·Î±×ÀÎ ÀÎÁõ
    public boolean validate() {
        if (password.equals("admin"))
            return true;
        else
            return false;
    }
}