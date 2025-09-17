<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Video List</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
<div class="row">
<!-- Sidebar -->
<nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
<div class="position-sticky pt-3">
<h5 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
Admin Panel
</h5>
<ul class="nav flex-column">
<li class="nav-item">
<a class="nav-link" href="<c:url value="/admin"/>">
<i class="fas fa-home"></i> Dashboard
</a>
</li>
<li class="nav-item">
<a class="nav-link" href="<c:url value="/admin/categories/searchpaginated?page=1&size=5"/>">
<i class="fas fa-list"></i> Categories
</a>
</li>
<li class="nav-item">
<a class="nav-link" href="<c:url value="/admin/users/searchpaginated?page=1&size=5"/>">
<i class="fas fa-users"></i> Users
</a>
</li>
<li class="nav-item">
<a class="nav-link active" href="<c:url value="/admin/videos/searchpaginated?page=1&size=5"/>">
<i class="fas fa-video"></i> Videos
</a>
</li>
</ul>
</div>
</nav>

<!-- Main content -->
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
<h1 class="h2">Video Management</h1>
<div class="btn-toolbar mb-2 mb-md-0">
<a href="<c:url value="/admin/videos/add"/>" class="btn btn-primary">
<i class="fas fa-plus"></i> Add New Video
</a>
</div>
</div>

<!-- Hiển thông báo -->
<c:if test="${message != null}">
<div class="alert alert-primary alert-dismissible fade show" role="alert">
<i class="fas fa-info-circle"></i> ${message}
<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
</c:if>

<div class="card">
<div class="card-header d-flex justify-content-between align-items-center">
<h5 class="mb-0">
<i class="fas fa-video"></i> Video List
</h5>
<span class="badge bg-primary">${videos.size()} videos</span>
</div>
<div class="card-body">
<c:choose>
<c:when test="${videos != null && videos.size() > 0}">
<div class="table-responsive">
<table class="table table-striped table-hover">
<thead class="table-dark">
<tr>
<th>ID</th>
<th>Title</th>
<th>Description</th>
<th>Poster</th>
<th>Views</th>
<th>Category</th>
<th>Status</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<c:forEach items="${videos}" var="video">
<tr>
<td><span class="badge bg-secondary">${video.id}</span></td>
<td>
<strong>${video.title}</strong>
</td>
<td>
<c:choose>
<c:when test="${video.description.length() > 50}">
${video.description.substring(0, 50)}...
</c:when>
<c:otherwise>
${video.description}
</c:otherwise>
</c:choose>
</td>
<td>
<c:choose>
<c:when test="${video.poster != null && !video.poster.isEmpty()}">
<img src="${video.poster}" alt="Poster" class="img-thumbnail" style="width: 60px; height: 40px; object-fit: cover;">
</c:when>
<c:otherwise>
<span class="text-muted"><i class="fas fa-image"></i> No image</span>
</c:otherwise>
</c:choose>
</td>
<td>
<span class="badge bg-info">
<i class="fas fa-eye"></i> ${video.views}
</span>
</td>
<td>
<c:choose>
<c:when test="${video.category != null}">
<span class="badge bg-success">${video.category.categoryName}</span>
</c:when>
<c:otherwise>
<span class="badge bg-warning">No Category</span>
</c:otherwise>
</c:choose>
</td>
<td>
<c:choose>
<c:when test="${video.active == 1}">
<span class="badge bg-success"><i class="fas fa-check"></i> Active</span>
</c:when>
<c:otherwise>
<span class="badge bg-danger"><i class="fas fa-times"></i> Inactive</span>
</c:otherwise>
</c:choose>
</td>
<td>
<div class="btn-group" role="group">
<a href="<c:url value="/admin/videos/edit/${video.id}"/>" 
   class="btn btn-outline-warning btn-sm" title="Edit">
<i class="fas fa-edit"></i>
</a>
<a href="<c:url value="/admin/videos/delete/${video.id}"/>" 
   class="btn btn-outline-danger btn-sm" title="Delete"
   onclick="return confirm('Are you sure you want to delete this video?')">
<i class="fas fa-trash"></i>
</a>
</div>
</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
</c:when>
<c:otherwise>
<div class="text-center py-4">
<i class="fas fa-video fa-3x text-muted mb-3"></i>
<h5 class="text-muted">No videos found</h5>
<p class="text-muted">Get started by adding your first video.</p>
<a href="<c:url value="/admin/videos/add"/>" class="btn btn-primary">
<i class="fas fa-plus"></i> Add Video
</a>
</div>
</c:otherwise>
</c:choose>
</div>
<div class="card-footer">
<div class="d-flex justify-content-between align-items-center">
<small class="text-muted">
<i class="fas fa-info-circle"></i> 
Showing all videos
</small>
<div>
<a href="<c:url value="/admin/videos/searchpaginated?page=1&size=5"/>" class="btn btn-outline-primary btn-sm">
<i class="fas fa-search"></i> Search & Filter
</a>
<a href="<c:url value="/admin"/>" class="btn btn-outline-secondary btn-sm">
<i class="fas fa-arrow-left"></i> Back to Dashboard
</a>
</div>
</div>
</div>
</div>
</main>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
