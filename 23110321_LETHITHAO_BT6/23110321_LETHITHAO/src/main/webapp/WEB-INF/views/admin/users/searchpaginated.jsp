<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Users with Pagination</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<section class="row">
<div class="col mt-4">
<div class="card">
<div class="card-header">
<h2>Search Users with Pagination</h2>
</div>
<div class="card-body">
<!-- Hiển thông báo -->
<c:if test="${message != null}">
<div class="alert alert-primary" role="alert">
<i>${message}</i>
</div>
</c:if>

<form action="<c:url value="/admin/users/searchpaginated" />" method="GET">
<div class="row">
<div class="col-md-4">
<input type="text" class="form-control" name="username" value="${username}" 
       placeholder="Search by username...">
</div>
<div class="col-md-4">
<input type="text" class="form-control" name="fullname" value="${fullname}" 
       placeholder="Search by fullname...">
</div>
<div class="col-md-2">
<select class="form-control" name="size">
<option value="5" ${param.size == '5' ? 'selected' : ''}>5 per page</option>
<option value="10" ${param.size == '10' ? 'selected' : ''}>10 per page</option>
<option value="15" ${param.size == '15' ? 'selected' : ''}>15 per page</option>
</select>
</div>
<div class="col-md-2">
<button type="submit" class="btn btn-primary">Search</button>
</div>
</div>
<input type="hidden" name="page" value="1">
</form>

<hr>

<table class="table table-striped table-responsive">
<thead class="thead-inverse">
<tr>
<th>User ID</th>
<th>Username</th>
<th>Full Name</th>
<th>Email</th>
<th>Phone</th>
<th>Role</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>
<tbody>
<c:forEach items="${userPage.content}" var ="user">
<tr>
<td scope="row">${user.id}</td>
<td>${user.username}</td>
<td>${user.fullname}</td>
<td>${user.email}</td>
<td>${user.phone}</td>
<td>
<c:choose>
<c:when test="${user.roleid == 1}">Admin</c:when>
<c:when test="${user.roleid == 2}">User</c:when>
<c:when test="${user.roleid == 3}">Manager</c:when>
<c:otherwise>Unknown</c:otherwise>
</c:choose>
</td>
<td>${user.active == 1 ? 'Active' : 'Inactive'}</td>
<td>
<a href="/admin/users/edit/${user.id}" class="btn btn-outline-warning btn-sm">
<i class="fa fa-edit"></i> Edit</a>
<a href="/admin/users/delete/${user.id}" class="btn btn-outline-danger btn-sm" 
   onclick="return confirm('Are you sure you want to delete this user?')">
<i class="fa fa-trash"></i> Delete</a>
</td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
<div class="card-footer text-muted">
<nav aria-label="User pagination">
<ul class="pagination">
<c:if test="${userPage.hasPrevious()}">
<li class="page-item">
<a class="page-link" href="?page=${userPage.number}&size=${userPage.size}&username=${username}&fullname=${fullname}">Previous</a>
</li>
</c:if>

<c:forEach items="${pageNumbers}" var="pageNumber">
<li class="page-item ${pageNumber == userPage.number + 1 ? 'active' : ''}">
<a class="page-link" href="?page=${pageNumber}&size=${userPage.size}&username=${username}&fullname=${fullname}">${pageNumber}</a>
</li>
</c:forEach>

<c:if test="${userPage.hasNext()}">
<li class="page-item">
<a class="page-link" href="?page=${userPage.number + 2}&size=${userPage.size}&username=${username}&fullname=${fullname}">Next</a>
</li>
</c:if>
</ul>
</nav>

<div class="mt-3">
<a href="<c:url value="/admin/users/add"/>" class="btn btn-primary">Add New User</a>
<a href="<c:url value="/admin/users"/>" class="btn btn-success">View All Users</a>
</div>
</div>
</div>
</div>
</section>
</body>
</html>
