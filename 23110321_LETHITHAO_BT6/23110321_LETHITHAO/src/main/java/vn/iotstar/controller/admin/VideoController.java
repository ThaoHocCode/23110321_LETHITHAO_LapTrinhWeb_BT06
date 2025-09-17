package vn.iotstar.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Video;
import vn.iotstar.model.VideoModel;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.VideoService;

@Controller
@RequestMapping("admin/videos")
public class VideoController {

    @Autowired
    VideoService videoService;
    
    @Autowired
    CategoryService categoryService;

    @GetMapping("add")
    public String add(ModelMap model) {
        VideoModel video = new VideoModel();
        video.setIsEdit(false);
        
        // Load danh sách categories cho dropdown
        List<Category> categories = categoryService.findAll();
        model.addAttribute("categories", categories);
        model.addAttribute("video", video);
        return "admin/videos/add";
    }

    @PostMapping("saveOrUpdate")
    public ModelAndView saveOrUpdate(ModelMap model, @ModelAttribute("video") VideoModel videoModel) {
        Video entity = new Video();
        // Copy từ Model sang Entity
        BeanUtils.copyProperties(videoModel, entity);
        
        // Set category cho video
        if (videoModel.getCategoryId() != 0) {
            Optional<Category> optCategory = categoryService.findById(videoModel.getCategoryId());
            if (optCategory.isPresent()) {
                entity.setCategory(optCategory.get());
            }
        }

        // Gọi hàm save trong service
        videoService.save(entity);

        // Đưa thông báo về cho listpaginated
        String message = "";
        if (videoModel.getIsEdit() == true) {
            message = "Video is Edited!!!!";
        } else {
            message = "Video is saved!!!!";
        }
        model.addAttribute("message", message);

        // Redirect về URL listpaginated
        return new ModelAndView("redirect:/admin/videos/searchpaginated", model);
    }

    @RequestMapping("")
    public String list(ModelMap model) {
        // Gọi hàm findAll() trong service
        List<Video> list = videoService.findAll();
        // Chuyển dữ liệu từ list lên biến videos
        model.addAttribute("videos", list);
        return "admin/videos/list";
    }

    @GetMapping("edit/{videoId}")
    public ModelAndView edit(ModelMap model, @PathVariable("videoId") int videoId) {
        Optional<Video> optVideo = videoService.findById(videoId);
        VideoModel videoModel = new VideoModel();

        // Kiểm tra video có tồn tại không
        if (optVideo.isPresent()) {
            Video entity = optVideo.get();
            // Copy từ entity sang model
            BeanUtils.copyProperties(entity, videoModel);
            if (entity.getCategory() != null) {
                videoModel.setCategoryId(entity.getCategory().getId());
            }
            videoModel.setIsEdit(true);
            
            // Load danh sách categories cho dropdown
            List<Category> categories = categoryService.findAll();
            model.addAttribute("categories", categories);
            
            // Đưa dữ liệu ra view
            model.addAttribute("video", videoModel);
            return new ModelAndView("admin/videos/add", model);
        }
        model.addAttribute("message", "Video is not existed!!!!");
        return new ModelAndView("redirect:/admin/videos/searchpaginated", model);
    }

    @GetMapping("delete/{videoId}")
    public ModelAndView delete(ModelMap model, @PathVariable("videoId") int videoId) {
        videoService.deleteById(videoId);
        model.addAttribute("message", "Video is deleted!!!!");
        return new ModelAndView("redirect:/admin/videos/searchpaginated", model);
    }

    @RequestMapping("search")
    public String search(ModelMap model, 
                        @RequestParam(name = "title", required = false) String title,
                        @RequestParam(name = "categoryId", required = false) Integer categoryId) {
        List<Video> list = null;
        
        if (StringUtils.hasText(title)) {
            list = videoService.findByTitleContaining(title);
        } else if (categoryId != null && categoryId > 0) {
            list = videoService.findByCategoryId(categoryId);
        } else {
            list = videoService.findAll();
        }
        
        // Load danh sách categories cho dropdown
        List<Category> categories = categoryService.findAll();
        model.addAttribute("categories", categories);
        model.addAttribute("videos", list);
        model.addAttribute("title", title);
        model.addAttribute("categoryId", categoryId);
        return "admin/videos/search";
    }

    @RequestMapping("searchpaginated")
    public String search(ModelMap model, 
                        @RequestParam(name = "title", required = false) String title,
                        @RequestParam(name = "categoryId", required = false) Integer categoryId,
                        @RequestParam("page") Optional<Integer> page,
                        @RequestParam("size") Optional<Integer> size) {
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize);
        Page<Video> resultPage = null;

        if (StringUtils.hasText(title)) {
            resultPage = videoService.findByTitleContaining(title, pageable);
            model.addAttribute("title", title);
        } else if (categoryId != null && categoryId > 0) {
            resultPage = videoService.findByCategoryId(categoryId, pageable);
            model.addAttribute("categoryId", categoryId);
        } else {
            resultPage = videoService.findAll(pageable);
        }

        // Load danh sách categories cho dropdown
        List<Category> categories = categoryService.findAll();
        model.addAttribute("categories", categories);
        
        model.addAttribute("videoPage", resultPage);
        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0) {
            int start = Math.max(1, currentPage - 2);
            int end = Math.min(currentPage + 2, totalPages);
            if (totalPages > 5) {
                if (end == totalPages) start = end - 5;
                else if (start == 1) end = start + 5;
            }
            model.addAttribute("pageNumbers", java.util.stream.IntStream.rangeClosed(start, end).boxed().collect(java.util.stream.Collectors.toList()));
        }
        return "admin/videos/searchpaginated";
    }
}
