<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Categories with Pagination</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<section class="row">
<div class="col mt-4">
<div class="card">
<div class="card-header">
<h2>Search Categories with Pagination</h2>
</div>
<div class="card-body">
<!-- Hiển thông báo -->
<c:if test="${message != null}">
<div class="alert alert-primary" role="alert">
<i>${message}</i>
</div>
</c:if>

<form action="<c:url value="/admin/categories/searchpaginated" />" method="GET">
<div class="row">
<div class="col-md-6">
<input type="text" class="form-control" name="name" value="${name}" 
       placeholder="Enter category name to search...">
</div>
<div class="col-md-3">
<select class="form-control" name="size">
<option value="5" ${param.size == '5' ? 'selected' : ''}>5 per page</option>
<option value="10" ${param.size == '10' ? 'selected' : ''}>10 per page</option>
<option value="15" ${param.size == '15' ? 'selected' : ''}>15 per page</option>
</select>
</div>
<div class="col-md-3">
<button type="submit" class="btn btn-primary">Search</button>
<a href="<c:url value="/admin/categories/searchpaginated?page=1&size=5"/>" class="btn btn-secondary">Clear</a>
</div>
</div>
<input type="hidden" name="page" value="1">
</form>

<hr>

<table class="table table-striped table-responsive">
<thead class="thead-inverse">
<tr>
<th>Category ID</th>
<th>Category Name</th>
<th>Images</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>
<tbody>
<c:forEach items="${categoryPage.content}" var ="category">
<tr>
<td scope="row">${category.id}</td>
<td>${category.categoryName}</td>
<td>
<c:if test="${category.images != null}">
<img width="100" height="100" src="${category.images}" alt="Category Image">
</c:if>
</td>
<td>${category.status == 1 ? 'Active' : 'Inactive'}</td>
<td>
<a href="/admin/categories/edit/${category.id}" class="btn btn-outline-warning">
<i class="fa fa-edit"></i> Edit</a>
<a href="/admin/categories/delete/${category.id}" class="btn btn-outline-danger" 
   onclick="return confirm('Are you sure you want to delete this category?')">
<i class="fa fa-trash"></i> Delete</a>
</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
<div class="card-footer text-muted">
<nav aria-label="Category pagination">
<ul class="pagination">
<c:if test="${categoryPage.hasPrevious()}">
<li class="page-item">
<a class="page-link" href="?page=${categoryPage.number}&size=${categoryPage.size}&name=${name}">Previous</a>
</li>
</c:if>

<c:forEach items="${pageNumbers}" var="pageNumber">
<li class="page-item ${pageNumber == categoryPage.number + 1 ? 'active' : ''}">
<a class="page-link" href="?page=${pageNumber}&size=${categoryPage.size}&name=${name}">${pageNumber}</a>
</li>
</c:forEach>

<c:if test="${categoryPage.hasNext()}">
<li class="page-item">
<a class="page-link" href="?page=${categoryPage.number + 2}&size=${categoryPage.size}&name=${name}">Next</a>
</li>
</c:if>
</ul>
</nav>

<div class="mt-3">
<a href="<c:url value="/admin/categories/add"/>" class="btn btn-primary">Add New Category</a>
<a href="<c:url value="/admin/categories"/>" class="btn btn-success">View All Categories</a>
</div>
</div>
</div>
</div>
</section>
</body>
</html>
