<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Category Management</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<section class="row">
<div class="col-6 offset-3 mt-4">
<form action="<c:url value="/admin/categories/saveOrUpdate" />" method="POST">
<div class="card">
<div class="card-header">
<h2>${category.isEdit ? 'Edit' : 'Add New'} Category</h2>
</div>
<div class="card-body">
<div class="mb-3">
<label for="categoryId" class="form-label">Category ID:</label>
<input type="text" readonly="readonly" class="form-control" value="${category.id}" id="id" name="id"
aria-describedby="categoryIdid" placeholder="Category Id">
</div>
<div class="mb-3">
<label for="categoryname" class="form-label">Category Name:</label>
<input type="text" class="form-control" value="${category.categoryName}" id="categoryName" name="categoryName"
aria-describedby="nameid" placeholder="Category Name" required>
</div>
<div class="mb-3">
<label for="images" class="form-label">Images:</label>
<input type="text" class="form-control" value="${category.images}" id="images" name="images"
placeholder="Image URL">
</div>
<div class="mb-3">
<label for="status" class="form-label">Status:</label>
<select class="form-control" id="status" name="status">
<option value="1" ${category.status == 1 ? 'selected' : ''}>Active</option>
<option value="0" ${category.status == 0 ? 'selected' : ''}>Inactive</option>
</select>
</div>
<input type="hidden" name="isEdit" value="${category.isEdit}">
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
