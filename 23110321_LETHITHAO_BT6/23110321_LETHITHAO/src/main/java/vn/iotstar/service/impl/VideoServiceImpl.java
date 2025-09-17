package vn.iotstar.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.iotstar.entity.Video;
import vn.iotstar.repository.VideoRepository;
import vn.iotstar.service.VideoService;

@Service
public class VideoServiceImpl implements VideoService {

    @Autowired
    VideoRepository videoRepository;

    @Override
    public List<Video> findAll() {
        return videoRepository.findAll();
    }

    @Override
    public Page<Video> findAll(Pageable pageable) {
        return videoRepository.findAll(pageable);
    }

    @Override
    public Optional<Video> findById(Integer id) {
        return videoRepository.findById(id);
    }

    @Override
    public Video save(Video entity) {
        return videoRepository.save(entity);
    }

    @Override
    public void deleteById(Integer id) {
        videoRepository.deleteById(id);
    }

    @Override
    public void delete(Video entity) {
        videoRepository.delete(entity);
    }

    @Override
    public long count() {
        return videoRepository.count();
    }

    @Override
    public List<Video> findByTitleContaining(String title) {
        return videoRepository.findByTitleContaining(title);
    }

    @Override
    public Page<Video> findByTitleContaining(String title, Pageable pageable) {
        return videoRepository.findByTitleContaining(title, pageable);
    }

    @Override
    public List<Video> findByCategoryId(int categoryId) {
        return videoRepository.findByCategoryId(categoryId);
    }

    @Override
    public Page<Video> findByCategoryId(int categoryId, Pageable pageable) {
        return videoRepository.findByCategoryId(categoryId, pageable);
    }

    @Override
    public List<Video> findByActive(int active) {
        return videoRepository.findByActive(active);
    }
}
