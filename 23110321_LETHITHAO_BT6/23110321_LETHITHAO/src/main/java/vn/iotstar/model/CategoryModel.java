package vn.iotstar.model;

public class CategoryModel {
    private int id;
    private String categoryName;
    private String images;
    private int status;
    private Boolean isEdit = false;
    
    public CategoryModel() {}
    
    public CategoryModel(int id, String categoryName, String images, int status, Boolean isEdit) {
        this.id = id;
        this.categoryName = categoryName;
        this.images = images;
        this.status = status;
        this.isEdit = isEdit;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    
    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }
    
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
    
    public Boolean getIsEdit() { return isEdit; }
    public void setIsEdit(Boolean isEdit) { this.isEdit = isEdit; }
}
