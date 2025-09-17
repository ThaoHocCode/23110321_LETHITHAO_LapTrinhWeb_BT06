package vn.iotstar.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import vn.iotstar.entity.Video;

public interface VideoService {
    
    List<Video> findAll();
    
    Page<Video> findAll(Pageable pageable);
    
    Optional<Video> findById(Integer id);
    
    Video save(Video entity);
    
    void deleteById(Integer id);
    
    void delete(Video entity);
    
    long count();
    
    List<Video> findByTitleContaining(String title);
    
    Page<Video> findByTitleContaining(String title, Pageable pageable);
    
    List<Video> findByCategoryId(int categoryId);
    
    Page<Video> findByCategoryId(int categoryId, Pageable pageable);
    
    List<Video> findByActive(int active);
}
