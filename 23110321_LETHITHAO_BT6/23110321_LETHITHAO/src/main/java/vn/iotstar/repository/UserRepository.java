package vn.iotstar.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.iotstar.entity.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    // Tìm kiếm theo username
    Optional<User> findByUsername(String username);
    
    // Tìm kiếm theo email
    Optional<User> findByEmail(String email);
    
    // Tìm kiếm theo fullname chứa từ khóa
    List<User> findByFullnameContaining(String fullname);
    
    // Tìm kiếm và phân trang theo fullname
    Page<User> findByFullnameContaining(String fullname, Pageable pageable);
    
    // Tìm kiếm theo username chứa từ khóa
    List<User> findByUsernameContaining(String username);
    
    // Tìm kiếm và phân trang theo username
    Page<User> findByUsernameContaining(String username, Pageable pageable);
}
