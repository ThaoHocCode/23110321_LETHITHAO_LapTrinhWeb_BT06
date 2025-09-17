<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Categories</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<section class="row">
<div class="col mt-4">
<div class="card">
<div class="card-header">
<h2>Search Categories</h2>
</div>
<div class="card-body">
<form action="<c:url value="/admin/categories/search" />" method="GET">
<div class="row">
<div class="col-md-8">
<input type="text" class="form-control" name="name" value="${name}" 
       placeholder="Enter category name to search...">
</div>
<div class="col-md-4">
<button type="submit" class="btn btn-primary">Search</button>
<a href="<c:url value="/admin/categories/search"/>" class="btn btn-secondary">Clear</a>
</div>
</div>
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
<c:forEach items="${categories}" var ="category">
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
<a href="<c:url value="/admin/categories/add"/>" class="btn btn-primary">Add New Category</a>
<a href="<c:url value="/admin/categories"/>" class="btn btn-success">View All Categories</a>
</div>
</div>
</div>
</section>
</body>
</html>
