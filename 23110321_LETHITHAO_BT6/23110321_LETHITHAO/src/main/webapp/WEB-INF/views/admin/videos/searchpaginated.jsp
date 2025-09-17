<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Videos with Pagination</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<section class="row">
<div class="col mt-4">
<div class="card">
<div class="card-header">
<h2>Search Videos with Pagination</h2>
</div>
<div class="card-body">
<!-- Hiển thông báo -->
<c:if test="${message != null}">
<div class="alert alert-primary" role="alert">
<i>${message}</i>
</div>
</c:if>

<form action="<c:url value="/admin/videos/searchpaginated" />" method="GET">
<div class="row">
<div class="col-md-4">
<input type="text" class="form-control" name="title" value="${title}" 
       placeholder="Search by title...">
</div>
<div class="col-md-3">
<select class="form-control" name="categoryId">
<option value="">All Categories</option>
<c:forEach items="${categories}" var="category">
<option value="${category.id}" ${categoryId == category.id ? 'selected' : ''}>${category.categoryName}</option>
</c:forEach>
</select>
</div>
<div class="col-md-2">
<select class="form-control" name="size">
<option value="5" ${param.size == '5' ? 'selected' : ''}>5 per page</option>
<option value="10" ${param.size == '10' ? 'selected' : ''}>10 per page</option>
<option value="15" ${param.size == '15' ? 'selected' : ''}>15 per page</option>
</select>
</div>
<div class="col-md-3">
<button type="submit" class="btn btn-primary">Search</button>
<a href="<c:url value="/admin/videos/searchpaginated?page=1&size=5"/>" class="btn btn-secondary">Clear</a>
</div>
</div>
<input type="hidden" name="page" value="1">
</form>

<hr>

<table class="table table-striped table-responsive">
<thead class="thead-inverse">
<tr>
<th>Video ID</th>
<th>Title</th>
<th>Poster</th>
<th>Category</th>
<th>Views</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>
<tbody>
<c:forEach items="${videoPage.content}" var ="video">
<tr>
<td scope="row">${video.id}</td>
<td>${video.title}</td>
<td>
<c:if test="${video.poster != null}">
<img width="80" height="60" src="${video.poster}" alt="Video Poster">
</c:if>
</td>
<td>${video.category != null ? video.category.categoryName : 'No Category'}</td>
<td>${video.views}</td>
<td>${video.active == 1 ? 'Active' : 'Inactive'}</td>
<td>
<a href="/admin/videos/edit/${video.id}" class="btn btn-outline-warning btn-sm">
<i class="fa fa-edit"></i> Edit</a>
<a href="/admin/videos/delete/${video.id}" class="btn btn-outline-danger btn-sm" 
   onclick="return confirm('Are you sure you want to delete this video?')">
<i class="fa fa-trash"></i> Delete</a>
</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
<div class="card-footer text-muted">
<nav aria-label="Video pagination">
<ul class="pagination">
<c:if test="${videoPage.hasPrevious()}">
<li class="page-item">
<a class="page-link" href="?page=${videoPage.number}&size=${videoPage.size}&title=${title}&categoryId=${categoryId}">Previous</a>
</li>
</c:if>

<c:forEach items="${pageNumbers}" var="pageNumber">
<li class="page-item ${pageNumber == videoPage.number + 1 ? 'active' : ''}">
<a class="page-link" href="?page=${pageNumber}&size=${videoPage.size}&title=${title}&categoryId=${categoryId}">${pageNumber}</a>
</li>
</c:forEach>

<c:if test="${videoPage.hasNext()}">
<li class="page-item">
<a class="page-link" href="?page=${videoPage.number + 2}&size=${videoPage.size}&title=${title}&categoryId=${categoryId}">Next</a>
</li>
</c:if>
</ul>
</nav>

<div class="mt-3">
<a href="<c:url value="/admin/videos/add"/>" class="btn btn-primary">Add New Video</a>
<a href="<c:url value="/admin/videos"/>" class="btn btn-success">View All Videos</a>
</div>
</div>
</div>
</div>
</section>
</body>
</html>
