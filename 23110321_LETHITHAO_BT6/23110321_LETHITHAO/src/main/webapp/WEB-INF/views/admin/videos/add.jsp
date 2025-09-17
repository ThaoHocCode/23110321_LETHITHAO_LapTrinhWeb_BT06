<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Video Management</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<section class="row">
<div class="col-8 offset-2 mt-4">
<form action="<c:url value="/admin/videos/saveOrUpdate" />" method="POST">
<div class="card">
<div class="card-header">
<h2>${video.isEdit ? 'Edit' : 'Add New'} Video</h2>
</div>
<div class="card-body">
<div class="row">
<div class="col-md-6">
<div class="mb-3">
<label for="videoId" class="form-label">Video ID:</label>
<input type="text" readonly="readonly" class="form-control" value="${video.id}" id="id" name="id"
placeholder="Video Id">
</div>
<div class="mb-3">
<label for="title" class="form-label">Title:</label>
<input type="text" class="form-control" value="${video.title}" id="title" name="title"
placeholder="Video Title" required>
</div>
<div class="mb-3">
<label for="description" class="form-label">Description:</label>
<textarea class="form-control" id="description" name="description" rows="4"
placeholder="Video Description">${video.description}</textarea>
</div>
<div class="mb-3">
<label for="poster" class="form-label">Poster URL:</label>
<input type="text" class="form-control" value="${video.poster}" id="poster" name="poster"
placeholder="Poster Image URL">
</div>
</div>
<div class="col-md-6">
<div class="mb-3">
<label for="categoryId" class="form-label">Category:</label>
<select class="form-control" id="categoryId" name="categoryId" required>
<option value="">Select Category</option>
<c:forEach items="${categories}" var="category">
<option value="${category.id}" ${video.categoryId == category.id ? 'selected' : ''}>${category.categoryName}</option>
</c:forEach>
</select>
</div>
<div class="mb-3">
<label for="views" class="form-label">Views:</label>
<input type="number" class="form-control" value="${video.views}" id="views" name="views"
placeholder="Number of views" min="0">
</div>
<div class="mb-3">
<label for="active" class="form-label">Status:</label>
<select class="form-control" id="active" name="active">
<option value="1" ${video.active == 1 ? 'selected' : ''}>Active</option>
<option value="0" ${video.active == 0 ? 'selected' : ''}>Inactive</option>
</select>
</div>
<div class="mb-3">
<c:if test="${video.poster != null && !empty video.poster}">
<label class="form-label">Current Poster:</label><br>
<img src="${video.poster}" alt="Current Poster" style="max-width: 200px; max-height: 150px;">
</c:if>
</div>
</div>
</div>
<input type="hidden" name="isEdit" value="${video.isEdit}">
</div>
</div>
<div class="card-footer text-muted">
<a href="<c:url value="/admin/videos/add"/>" class="btn btn-secondary"><i class="fas fa-new"></i> New</a>
<a href="<c:url value="/admin/videos" />" class="btn btn-success"><i class="fas fa-bars"></i> List Videos</a>
<button class="btn btn-primary" type="submit"><i class="fas fa-save"></i>
<span>Submit</span>
</button>
</div>
</form>
</div>
</section>
</body>
</html>
