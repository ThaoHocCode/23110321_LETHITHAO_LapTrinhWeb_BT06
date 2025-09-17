package vn.iotstar.entity;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

@Entity
@Table(name="videos")
@NamedQuery(name="Video.findAll", query="SELECT v FROM Video v")
public class Video implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @Column(name="title", columnDefinition = "NVARCHAR(255)")
    private String title;
    
    @Column(name="description", columnDefinition = "NVARCHAR(MAX)")
    private String description;
    
    @Column(name="poster", columnDefinition = "NVARCHAR(MAX)")
    private String poster;
    
    @Column(name="views")
    private int views;
    
    private int active;
    
    @ManyToOne
    @JoinColumn(name="categoryId")
    private Category category;
    
    public Video() {}
    
    public Video(int id, String title, String description, String poster, 
                int views, int active, Category category) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.poster = poster;
        this.views = views;
        this.active = active;
        this.category = category;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getPoster() { return poster; }
    public void setPoster(String poster) { this.poster = poster; }
    
    public int getViews() { return views; }
    public void setViews(int views) { this.views = views; }
    
    public int getActive() { return active; }
    public void setActive(int active) { this.active = active; }
    
    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
}
