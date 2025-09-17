package vn.iotstar.entity;

import java.io.Serializable;
import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Entity
@Table(name="users")
@NamedQuery(name="User.findAll", query="SELECT u FROM User u")
public class User implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @Column(name="username", columnDefinition = "NVARCHAR(255)", unique = true)
    private String username;
    
    @Column(name="password", columnDefinition = "NVARCHAR(255)")
    private String password;
    
    @Column(name="email", columnDefinition = "NVARCHAR(255)")
    private String email;
    
    @Column(name="fullname", columnDefinition = "NVARCHAR(255)")
    private String fullname;
    
    @Column(name="phone", columnDefinition = "NVARCHAR(20)")
    private String phone;
    
    @Column(name="images", columnDefinition = "NVARCHAR(MAX)")
    private String images;
    
    private int roleid;
    
    @Temporal(TemporalType.DATE)
    private Date createDate;
    
    private int active;
    
    public User() {}
    
    public User(int id, String username, String password, String email, String fullname, 
                String phone, String images, int roleid, Date createDate, int active) {
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
}
