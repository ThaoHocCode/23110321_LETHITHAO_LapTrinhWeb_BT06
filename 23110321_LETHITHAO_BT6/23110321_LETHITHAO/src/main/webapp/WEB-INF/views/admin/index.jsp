<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
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
<h1 class="h2">Dashboard</h1>
</div>

<div class="row">
<div class="col-md-4">
<div class="card text-white bg-primary mb-3">
<div class="card-header">Categories</div>
<div class="card-body">
<h4 class="card-title">
<i class="fas fa-list"></i> Manage Categories
</h4>
<p class="card-text">Add, edit, delete and search categories</p>
<a href="<c:url value="/admin/categories/searchpaginated?page=1&size=5"/>" class="btn btn-light">View Categories</a>
</div>
</div>
</div>

<div class="col-md-4">
<div class="card text-white bg-success mb-3">
<div class="card-header">Users</div>
<div class="card-body">
<h4 class="card-title">
<i class="fas fa-users"></i> Manage Users
</h4>
<p class="card-text">Add, edit, delete and search users</p>
<a href="<c:url value="/admin/users/searchpaginated?page=1&size=5"/>" class="btn btn-light">View Users</a>
</div>
</div>
</div>

<div class="col-md-4">
<div class="card text-white bg-info mb-3">
<div class="card-header">Videos</div>
<div class="card-body">
<h4 class="card-title">
<i class="fas fa-video"></i> Manage Videos
</h4>
<p class="card-text">Add, edit, delete and search videos</p>
<a href="<c:url value="/admin/videos/searchpaginated?page=1&size=5"/>" class="btn btn-light">View Videos</a>
</div>
</div>
</div>
</div>

<div class="row mt-4">
<div class="col-12">
<div class="card">
<div class="card-header">
<h5>Quick Actions</h5>
</div>
<div class="card-body">
<a href="<c:url value="/admin/categories/add"/>" class="btn btn-primary me-2">
<i class="fas fa-plus"></i> Add Category
</a>
<a href="<c:url value="/admin/users/add"/>" class="btn btn-success me-2">
<i class="fas fa-plus"></i> Add User
</a>
<a href="<c:url value="/admin/videos/add"/>" class="btn btn-info me-2">
<i class="fas fa-plus"></i> Add Video
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