package vn.iotstar.model;

import java.util.Date;

public class UserModel {
    private int id;
    private String username;
    private String password;
    private String email;
    private String fullname;
    private String phone;
    private String images;
    private int roleid;
    private Date createDate;
    private int active;
    private Boolean isEdit = false;
    
    public UserModel() {}
    
    public UserModel(int id, String username, String password, String email, String fullname, 
                    String phone, String images, int roleid, Date createDate, int active, Boolean isEdit) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
        this.images = images;
        this.roleid = roleid;
        this.createDate = createDate;
        this.active = active;
        this.isEdit = isEdit;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }
    
    public int getRoleid() { return roleid; }
    public void setRoleid(int roleid) { this.roleid = roleid; }
    
    public Date getCreateDate() { return createDate; }
    public void setCreateDate(Date createDate) { this.createDate = createDate; }
    
    public int getActive() { return active; }
    public void setActive(int active) { this.active = active; }
    
    public Boolean getIsEdit() { return isEdit; }
    public void setIsEdit(Boolean isEdit) { this.isEdit = isEdit; }
}
