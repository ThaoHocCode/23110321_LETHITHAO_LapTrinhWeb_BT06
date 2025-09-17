package vn.iotstar.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.iotstar.entity.Video;

@Repository
public interface VideoRepository extends JpaRepository<Video, Integer> {
    // Tìm kiếm theo title chứa từ khóa
    List<Video> findByTitleContaining(String title);
    
    // Tìm kiếm và phân trang theo title
    Page<Video> findByTitleContaining(String title, Pageable pageable);
    
    // Tìm kiếm theo category id
    List<Video> findByCategoryId(int categoryId);
    
    // Tìm kiếm và phân trang theo category id
    Page<Video> findByCategoryId(int categoryId, Pageable pageable);
    
    // Tìm kiếm theo active status
    List<Video> findByActive(int active);
}
