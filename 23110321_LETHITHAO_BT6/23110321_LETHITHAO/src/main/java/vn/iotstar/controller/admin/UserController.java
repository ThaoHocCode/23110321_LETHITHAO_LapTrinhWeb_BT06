package vn.iotstar.controller.admin;

import java.util.Date;
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

import vn.iotstar.entity.User;
import vn.iotstar.model.UserModel;
import vn.iotstar.service.UserService;

@Controller
@RequestMapping("admin/users")
public class UserController {

    @Autowired
    UserService userService;

    @GetMapping("add")
    public String add(ModelMap model) {
        UserModel user = new UserModel();
        user.setIsEdit(false);
        model.addAttribute("user", user);
        return "admin/users/add";
    }

    @PostMapping("saveOrUpdate")
    public ModelAndView saveOrUpdate(ModelMap model, @ModelAttribute("user") UserModel userModel) {
        User entity = new User();
        // Copy từ Model sang Entity
        BeanUtils.copyProperties(userModel, entity);
        
        // Nếu là user mới thì set createDate
        if (!userModel.getIsEdit()) {
            entity.setCreateDate(new Date());
        }

        // Gọi hàm save trong service
        userService.save(entity);

        // Đưa thông báo về cho listpaginated
        String message = "";
        if (userModel.getIsEdit() == true) {
            message = "User is Edited!!!!";
        } else {
            message = "User is saved!!!!";
        }
        model.addAttribute("message", message);

        // Redirect về URL listpaginated
        return new ModelAndView("redirect:/admin/users/searchpaginated", model);
    }

    @RequestMapping("")
    public String list(ModelMap model) {
        // Gọi hàm findAll() trong service
        List<User> list = userService.findAll();
        // Chuyển dữ liệu từ list lên biến users
        model.addAttribute("users", list);
        return "admin/users/list";
    }

    @GetMapping("edit/{userId}")
    public ModelAndView edit(ModelMap model, @PathVariable("userId") int userId) {
        Optional<User> optUser = userService.findById(userId);
        UserModel userModel = new UserModel();

        // Kiểm tra user có tồn tại không
        if (optUser.isPresent()) {
            User entity = optUser.get();
            // Copy từ entity sang model
            BeanUtils.copyProperties(entity, userModel);
            userModel.setIsEdit(true);
            // Đưa dữ liệu ra view
            model.addAttribute("user", userModel);
            return new ModelAndView("admin/users/add", model);
        }
        model.addAttribute("message", "User is not existed!!!!");
        return new ModelAndView("redirect:/admin/users/searchpaginated", model);
    }

    @GetMapping("delete/{userId}")
    public ModelAndView delete(ModelMap model, @PathVariable("userId") int userId) {
        userService.deleteById(userId);
        model.addAttribute("message", "User is deleted!!!!");
        return new ModelAndView("redirect:/admin/users/searchpaginated", model);
    }

    @RequestMapping("search")
    public String search(ModelMap model, 
                        @RequestParam(name = "username", required = false) String username,
                        @RequestParam(name = "fullname", required = false) String fullname) {
        List<User> list = null;
        
        if (StringUtils.hasText(username)) {
            list = userService.findByUsernameContaining(username);
        } else if (StringUtils.hasText(fullname)) {
            list = userService.findByFullnameContaining(fullname);
        } else {
            list = userService.findAll();
        }
        model.addAttribute("users", list);
        model.addAttribute("username", username);
        model.addAttribute("fullname", fullname);
        return "admin/users/search";
    }

    @RequestMapping("searchpaginated")
    public String search(ModelMap model, 
                        @RequestParam(name = "username", required = false) String username,
                        @RequestParam(name = "fullname", required = false) String fullname,
                        @RequestParam("page") Optional<Integer> page,
                        @RequestParam("size") Optional<Integer> size) {
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize);
        Page<User> resultPage = null;

        if (StringUtils.hasText(username)) {
            resultPage = userService.findByUsernameContaining(username, pageable);
            model.addAttribute("username", username);
        } else if (StringUtils.hasText(fullname)) {
            resultPage = userService.findByFullnameContaining(fullname, pageable);
            model.addAttribute("fullname", fullname);
        } else {
            resultPage = userService.findAll(pageable);
        }

        model.addAttribute("userPage", resultPage);
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
        return "admin/users/searchpaginated";
    }
}
