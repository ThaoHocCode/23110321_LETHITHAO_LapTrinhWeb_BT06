file application.properties

spring.datasource.driverClassName=com.microsoft.sqlserver.jdbc.SQLServerDriver


spring.datasource.url=jdbc:sqlserver://DESKTOP-T2CV8JR:1433;databaseName=jpast56;encrypt=true;trustServerCertificate=true;sslProtocol=TLSv1.2;characterEncoding=UTF-8


spring.datasource.username=sa


spring.datasource.password=1234567@a$



spring.jpa.show-sql=true


spring.jpa.properties.hibernate.format_sql = true


spring.jpa.properties.hibernate.dialect = org.hibernate.dialect.SQLServer2012Dialect


spring.jpa.hibernate.ddl-auto = update



server.port=8092



2. Cấu hình viewResolver


Cách 1: bỏ vào file ...Application.java




@Bean


 public InternalResourceViewResolver viewResolver() {


 InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();


 viewResolver.setViewClass(JstlView.class);


 viewResolver.setPrefix("/WEB-INF/views/");


 viewResolver.setSuffix(".jsp");


 return viewResolver;


 }


hoặc: bỏ vào application.properties




##Cấu hình JSP Template Engine trong Spring boot


spring.mvc.view.prefix=/WEB-INF/views/


spring.mvc.view.suffix=.jsp







3. Cấu hình scan component trong file  ...Application.java




@SpringBootApplication(scanBasePackages = {"vn.iotstar.Controller"})


@ComponentScan



4. Tạo cấu trúc thư mục cho jsp


src
└── main
    └── resources
        ├── META-INF
        │   └── resources
        │       ├── common
        │       ├── template
        │       └── WEB-INF
        │           ├── decorators
        │           └── views
        │               ├── admin
        │               │   ├── accounts
        │               │   ├── categories
        │               │   ├── products
        │               │   └── index.jsp
        │               └── web
        │                   ├── index.jsp
        │                   ├── login.jsp
        │                   └── search.jsp
        ├── static
        ├── templates
        └── application.properties



5. Thêm thư viện jsp




<dependency>


<groupId>jakarta.servlet.jsp.jstl</groupId>


<artifactId>jakarta.servlet.jsp.jstl-api</artifactId>


</dependency>


<!-- https://mvnrepository.com/artifact/jakarta.el/jakarta.el-api -->


<dependency>


<groupId>jakarta.el</groupId>


<artifactId>jakarta.el-api</artifactId>


<version>6.0.1</version>


</dependency>


<!--


 https://mvnrepository.com/artifact/org.glassfish.web/jakarta.servlet.jsp.jstl -->


<dependency>


<groupId>org.glassfish.web</groupId>


<artifactId>jakarta.servlet.jsp.jstl</artifactId>


</dependency>



6. Thêm thư viện tomcat-jasper để hiểu jsp




<dependency>


<groupId>org.apache.tomcat.embed</groupId>


<artifactId>tomcat-embed-jasper</artifactId>


<scope>provided</scope>


</dependency>









7. Cấu hình tomcat để nhận file .jsp


https://utexlms.hcmute.edu.vn/mod/page/view.php?id=771281



8. Viết các Entity




package vn.iotstar.entity;



import java.io.Serializable;



import jakarta.persistence.Column;


import jakarta.persistence.Entity;


import jakarta.persistence.GeneratedValue;


import jakarta.persistence.GenerationType;


import jakarta.persistence.Id;


import jakarta.persistence.NamedQuery;


import jakarta.persistence.Table;


import lombok.AllArgsConstructor;


import lombok.Data;


import lombok.NoArgsConstructor;




@AllArgsConstructor


@NoArgsConstructor


@Data



@Entity


@Table(name="categories")


@NamedQuery(name="Category.findAll", query="SELECT c FROM Category c")


public class Category implements Serializable {



 private static final long serialVersionUID = 1L;


 


 @Id


 @GeneratedValue (strategy = GenerationType.IDENTITY)


 private int id;


 @Column(name="categoryName",columnDefinition = "NVARCHAR(255)")


 private String categoryName;


 @Column(columnDefinition = "NVARCHAR(MAX)")


 private String images;


 


 


 


}



9. Viết các Repository




@Repository


public interface CategoryRepository extends JpaRepository<Category, Integer > {


 //Tìm Kiếm theo nội dung tên


 List<Category> findByCategoryNameContaining(String name);


 //Tìm kiếm và Phân trang


 Page<Category> findByCategoryNameContaining(String name,Pageable pageable);


}


10. Viết services



Tạo interface

Tạo class để implement interface

Tiêm Repository vào calss service bằng 






@Service


public class CategoryServicesImpl implements CategoryService {


 @Autowired


 CategoryRepository categoryRepository;








Gọi các phương thức từ Respository: source -> generate Delegate methods..

Refactor - pull up lên cho intergface

 




11. Viết controller




@Controller


@RequestMapping("admin/categories")


public class CategoryController {


 @Autowired


 CategoryService categoryService;


 


 @GetMapping("add")


 public String add(ModelMap model) { 


 return "admin/categories/add";


 }


 


 


 @RequestMapping("")


 public String list(ModelMap model) {


 //gọi hàm findAll() trong service


 List<Category> list = categoryService.findAll();


 //chuyển dữ liệu từ list lên biến categories 


 model.addAttribute("categories",list);


 return "admin/categories/list";


 }


 



 


 @GetMapping("delete/{categoryId}")


 public ModelAndView delet(ModelMap model, @PathVariable("categoryId") int categoryId) {


 categoryService.deleteById(categoryId);


 model.addAttribute("message","Category is deleted!!!!");


 return new ModelAndView("redirect:/admin/categories/searchpaginated",model);


 }



 


 @RequestMapping("search")


 public String search(ModelMap model,@RequestParam(name="name",required = false) String name) {


 List<Category> list = null;


 //có nội dung truyền về không, name là tùy chọn khi required=false


 if(StringUtils.hasText(name)) {


 list = categoryService.findByCategoryNameContaining(name);


 }else {


 list = categoryService.findAll();


 }


 model.addAttribute("categories",list);


 return "admin/categories/search";


 }


 


12. Viết views



file add.jsp




<%@ page language="java" contentType="text/html; charset=UTF-8"


pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<!DOCTYPE html>


<html>


<head>


<meta charset="UTF-8">


<title>Insert title here</title>


</head>


<body>


<section class="row">


<div class="col-6 offset-3 mt-4">


<form action="<c:url value="/admin/categories/saveOrUpdate" />" method="POST">


<div class="card">


<div class="card-header">


<h2>Add New Category</h2>


</div>


<div class="card-body">


<div class="mb-3">


<label for="categoryId" class="form-label">Category ID:</label>



<input


type="text" readonly="readonly" class="form-control" value="${category.id}" id="id" name="id"


aria-describedby="categoryIdid" placeholder="Category Id">



</div>


<div class="mb-3">


<label for="categoryname" class="form-label">Category Name:</label>


<input


type="text" class="form-control" value="${category.categoryName}" id="name" name="categoryName"


aria-describedby="nameid" placeholder="Category Name">



</div>


</div>


</div>


<div class="card-footer text-muted">


<a href="<c:url value="/admin/categories/add"/>" class="btn btn-secondary"><i class="fas fa-new"></i> New</a>


<a href="<c:url value="/admin/categories" />" class="btn btn-success"><i class="fas fa-bars"></i> List Categories</a>


<button class="btn btn-primary" type="submit"><i class="fas fa-save"></i>



<span>Submit</span>





</button>



</div>




</form>




</div>



</section>


</body>


</html>





file list.jsp




<%@ page language="java" contentType="text/html; charset=UTF-8"


pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<!DOCTYPE html>


<html>


<head>


<meta charset="UTF-8">


<title>Insert title here</title>


</head>


<body>



<section class="row">


<div class="col mt-4">


<div class="card">


<div class="card-header">List Category</div>


<div class="card-body">


<!-- Hiển thông báo -->


<c:if test="${message != null}">


<div class="alert alert-primary"


role="alert">


<i>${message}</i>


</div>


</c:if>


<!-- Hêt thông báo -->



<table class="table table-striped table-responsive">


<thead class="thead-inverse">


<tr>


<th>Category ID</th>


<th>Category Name</th>


<th>Action</th>


</tr>


</thead>


<tbody>


<c:forEach items="${categories}" var ="category">


<tr>


<td scope="row">${category.id}</td>


<td>${category.categoryName}</td>


<td><a href="/admin/categories/view/${category.id}" class="btn btn-outline-info"><i


class="fa fa-info"></i></a>


<a href="/admin/categories/edit/${category.id}"


class="btn btn-outline-warning"><i class="fa fa-edit"></i></a>


<a href="/admin/categories/delete/${category.id}" class="btn btn-outline-danger"><i


class="fa fa-trash"></i></a></td>


</tr>


</c:forEach>


</tbody>



</table>



</div>


<div class="card-footer text-muted">


<nav aria-label="...">


<ul class="pagination">


<li class="page-item disabled"><span class="page-link">Previous</span>


</li>


<li class="page-item"><a class="page-link" href="#">1</a></li>


<li class="page-item active" aria-current="page"><span


class="page-link">2</span></li>


<li class="page-item"><a class="page-link" href="#">3</a></li>


<li class="page-item"><a class="page-link" href="#">Next</a>


</li>


</ul>


</nav>


</div>


</div>






</div>


</section>


</body>


</html>