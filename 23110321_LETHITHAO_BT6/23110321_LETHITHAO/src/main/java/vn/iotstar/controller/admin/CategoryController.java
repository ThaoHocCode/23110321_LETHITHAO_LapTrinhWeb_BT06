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
import vn.iotstar.model.CategoryModel;
import vn.iotstar.service.CategoryService;

@Controller
@RequestMapping("admin/categories")
public class CategoryController {

    @Autowired
    CategoryService categoryService;

    @GetMapping("add")
    public String add(ModelMap model) {
        CategoryModel category = new CategoryModel();
        category.setIsEdit(false);
        model.addAttribute("category", category);
        return "admin/categories/add";
    }

    @PostMapping("saveOrUpdate")
    public ModelAndView saveOrUpdate(ModelMap model, @ModelAttribute("category") CategoryModel categoryModel) {
        Category entity = new Category();
        // Copy từ Model sang Entity
        BeanUtils.copyProperties(categoryModel, entity);

        // Gọi hàm save trong service
        categoryService.save(entity);

        // Đưa thông báo về cho listpaginated
        String message = "";
        if (categoryModel.getIsEdit() == true) {
            message = "Category is Edited!!!!";
        } else {
            message = "Category is saved!!!!";
        }
        model.addAttribute("message", message);

        // Redirect về URL listpaginated
        return new ModelAndView("redirect:/admin/categories/searchpaginated", model);
    }

    @RequestMapping("")
    public String list(ModelMap model) {
        // Gọi hàm findAll() trong service
        List<Category> list = categoryService.findAll();
        // Chuyển dữ liệu từ list lên biến categories
        model.addAttribute("categories", list);
        return "admin/categories/list";
    }

    @GetMapping("edit/{categoryId}")
    public ModelAndView edit(ModelMap model, @PathVariable("categoryId") int categoryId) {
        Optional<Category> optCategory = categoryService.findById(categoryId);
        CategoryModel categoryModel = new CategoryModel();

        // Kiểm tra category có tồn tại không
        if (optCategory.isPresent()) {
            Category entity = optCategory.get();
            // Copy từ entity sang model
            BeanUtils.copyProperties(entity, categoryModel);
            categoryModel.setIsEdit(true);
            // Đưa dữ liệu ra view
            model.addAttribute("category", categoryModel);
            return new ModelAndView("admin/categories/add", model);
        }
        model.addAttribute("message", "Category is not existed!!!!");
        return new ModelAndView("redirect:/admin/categories/searchpaginated", model);
    }

    @GetMapping("delete/{categoryId}")
    public ModelAndView delete(ModelMap model, @PathVariable("categoryId") int categoryId) {
        categoryService.deleteById(categoryId);
        model.addAttribute("message", "Category is deleted!!!!");
        return new ModelAndView("redirect:/admin/categories/searchpaginated", model);
    }

    @RequestMapping("search")
    public String search(ModelMap model, @RequestParam(name = "name", required = false) String name) {
        List<Category> list = null;
        // Có nội dung truyền về không, name là tùy chọn khi required=false
        if (StringUtils.hasText(name)) {
            list = categoryService.findByCategoryNameContaining(name);
        } else {
            list = categoryService.findAll();
        }
        model.addAttribute("categories", list);
        return "admin/categories/search";
    }

    @RequestMapping("searchpaginated")
    public String search(ModelMap model, 
                        @RequestParam(name = "name", required = false) String name,
                        @RequestParam("page") Optional<Integer> page,
                        @RequestParam("size") Optional<Integer> size) {
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize);
        Page<Category> resultPage = null;

        if (StringUtils.hasText(name)) {
            resultPage = categoryService.findByCategoryNameContaining(name, pageable);
            model.addAttribute("name", name);
        } else {
            resultPage = categoryService.findAll(pageable);
        }

        model.addAttribute("categoryPage", resultPage);
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
        return "admin/categories/searchpaginated";
    }
}
