package vn.iotstar.model;

public class VideoModel {
    private int id;
    private String title;
    private String description;
    private String poster;
    private int views;
    private int active;
    private int categoryId;
    private Boolean isEdit = false;
    
    public VideoModel() {}
    
    public VideoModel(int id, String title, String description, String poster, 
                     int views, int active, int categoryId, Boolean isEdit) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.poster = poster;
        this.views = views;
        this.active = active;
        this.categoryId = categoryId;
        this.isEdit = isEdit;
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
    
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    
    public Boolean getIsEdit() { return isEdit; }
    public void setIsEdit(Boolean isEdit) { this.isEdit = isEdit; }
}
