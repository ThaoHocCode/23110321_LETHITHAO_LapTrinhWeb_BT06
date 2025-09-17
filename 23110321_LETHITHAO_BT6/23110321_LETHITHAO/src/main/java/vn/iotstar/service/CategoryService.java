package vn.iotstar.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import vn.iotstar.entity.Category;

public interface CategoryService {
    
    List<Category> findAll();
    
    Page<Category> findAll(Pageable pageable);
    
    Optional<Category> findById(Integer id);
    
    Category save(Category entity);
    
    void deleteById(Integer id);
    
    void delete(Category entity);
    
    long count();
    
    List<Category> findByCategoryNameContaining(String name);
    
    Page<Category> findByCategoryNameContaining(String name, Pageable pageable);
}
