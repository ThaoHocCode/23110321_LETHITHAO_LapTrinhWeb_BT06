<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User List</title>
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
<a class="nav-link active" href="<c:url value="/admin/users/searchpaginated?page=1&size=5"/>">
<i class="fas fa-users"></i> Users
</a>
</li>
<li class="nav-item">
<a class="nav-link" href="<c:url value="/admin/videos/searchpaginated?page=1&size=5"/>">
<i class="fas fa-video"></i> Videos
</a>
</li>
</ul>
</div>
</nav>

<!-- Main content -->
<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
<h1 class="h2">User Management</h1>
<div class="btn-toolbar mb-2 mb-md-0">
<a href="<c:url value="/admin/users/add"/>" class="btn btn-primary">
<i class="fas fa-plus"></i> Add New User
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
<i class="fas fa-users"></i> User List
</h5>
<span class="badge bg-primary">${users.size()} users</span>
</div>
<div class="card-body">
<c:choose>
<c:when test="${users != null && users.size() > 0}">
<div class="table-responsive">
<table class="table table-striped table-hover">
<thead class="table-dark">
<tr>
<th>ID</th>
<th>Username</th>
<th>Full Name</th>
<th>Email</th>
<th>Phone</th>
<th>Role</th>
<th>Status</th>
<th>Created</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<c:forEach items="${users}" var="user">
<tr>
<td><span class="badge bg-secondary">${user.id}</span></td>
<td>
<strong>${user.username}</strong>
<c:if test="${user.images != null && !user.images.isEmpty()}">
<br><img src="${user.images}" alt="Avatar" class="rounded-circle" style="width: 25px; height: 25px;">
</c:if>
</td>
<td>${user.fullname}</td>
<td>
<c:if test="${user.email != null && !user.email.isEmpty()}">
<i class="fas fa-envelope"></i> ${user.email}
</c:if>
</td>
<td>
<c:if test="${user.phone != null && !user.phone.isEmpty()}">
<i class="fas fa-phone"></i> ${user.phone}
</c:if>
</td>
<td>
<c:choose>
<c:when test="${user.roleid == 1}">
<span class="badge bg-danger"><i class="fas fa-crown"></i> Admin</span>
</c:when>
<c:otherwise>
<span class="badge bg-info"><i class="fas fa-user"></i> User</span>
</c:otherwise>
</c:choose>
</td>
<td>
<c:choose>
<c:when test="${user.active == 1}">
<span class="badge bg-success"><i class="fas fa-check"></i> Active</span>
</c:when>
<c:otherwise>
<span class="badge bg-danger"><i class="fas fa-times"></i> Inactive</span>
</c:otherwise>
</c:choose>
</td>
<td>
<c:if test="${user.createDate != null}">
<small class="text-muted">
<i class="fas fa-calendar"></i> 
${user.createDate}
</small>
</c:if>
</td>
<td>
<div class="btn-group" role="group">
<a href="<c:url value="/admin/users/edit/${user.id}"/>" 
   class="btn btn-outline-warning btn-sm" title="Edit">
<i class="fas fa-edit"></i>
</a>
<a href="<c:url value="/admin/users/delete/${user.id}"/>" 
   class="btn btn-outline-danger btn-sm" title="Delete"
   onclick="return confirm('Are you sure you want to delete this user?')">
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
<i class="fas fa-users fa-3x text-muted mb-3"></i>
<h5 class="text-muted">No users found</h5>
<p class="text-muted">Get started by adding your first user.</p>
<a href="<c:url value="/admin/users/add"/>" class="btn btn-primary">
<i class="fas fa-plus"></i> Add User
</a>
</div>
</c:otherwise>
</c:choose>
</div>
<div class="card-footer">
<div class="d-flex justify-content-between align-items-center">
<small class="text-muted">
<i class="fas fa-info-circle"></i> 
Showing all users
</small>
<div>
<a href="<c:url value="/admin/users/searchpaginated?page=1&size=5"/>" class="btn btn-outline-primary btn-sm">
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
