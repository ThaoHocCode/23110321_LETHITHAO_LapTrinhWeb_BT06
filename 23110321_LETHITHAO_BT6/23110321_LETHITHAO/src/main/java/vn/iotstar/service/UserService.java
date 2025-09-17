package vn.iotstar.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import vn.iotstar.entity.User;

public interface UserService {
    
    List<User> findAll();
    
    Page<User> findAll(Pageable pageable);
    
    Optional<User> findById(Integer id);
    
    User save(User entity);
    
    void deleteById(Integer id);
    
    void delete(User entity);
    
    long count();
    
    Optional<User> findByUsername(String username);
    
    Optional<User> findByEmail(String email);
    
    List<User> findByFullnameContaining(String fullname);
    
    Page<User> findByFullnameContaining(String fullname, Pageable pageable);
    
    List<User> findByUsernameContaining(String username);
    
    Page<User> findByUsernameContaining(String username, Pageable pageable);
}
