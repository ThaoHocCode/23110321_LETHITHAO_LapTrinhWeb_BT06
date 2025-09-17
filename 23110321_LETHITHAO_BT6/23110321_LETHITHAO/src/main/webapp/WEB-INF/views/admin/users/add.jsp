<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Management</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<section class="row">
<div class="col-8 offset-2 mt-4">
<form action="<c:url value="/admin/users/saveOrUpdate" />" method="POST">
<div class="card">
<div class="card-header">
<h2>${user.isEdit ? 'Edit' : 'Add New'} User</h2>
</div>
<div class="card-body">
<div class="row">
<div class="col-md-6">
<div class="mb-3">
<label for="userId" class="form-label">User ID:</label>
<input type="text" readonly="readonly" class="form-control" value="${user.id}" id="id" name="id"
placeholder="User Id">
</div>
<div class="mb-3">
<label for="username" class="form-label">Username:</label>
<input type="text" class="form-control" value="${user.username}" id="username" name="username"
placeholder="Username" required>
</div>
<div class="mb-3">
<label for="password" class="form-label">Password:</label>
<input type="password" class="form-control" value="${user.password}" id="password" name="password"
placeholder="Password" required>
</div>
<div class="mb-3">
<label for="email" class="form-label">Email:</label>
<input type="email" class="form-control" value="${user.email}" id="email" name="email"
placeholder="Email" required>
</div>
</div>
<div class="col-md-6">
<div class="mb-3">
<label for="fullname" class="form-label">Full Name:</label>
<input type="text" class="form-control" value="${user.fullname}" id="fullname" name="fullname"
placeholder="Full Name" required>
</div>
<div class="mb-3">
<label for="phone" class="form-label">Phone:</label>
<input type="text" class="form-control" value="${user.phone}" id="phone" name="phone"
placeholder="Phone Number">
</div>
<div class="mb-3">
<label for="images" class="form-label">Avatar URL:</label>
<input type="text" class="form-control" value="${user.images}" id="images" name="images"
placeholder="Avatar URL">
</div>
<div class="mb-3">
<label for="roleid" class="form-label">Role:</label>
<select class="form-control" id="roleid" name="roleid">
<option value="1" ${user.roleid == 1 ? 'selected' : ''}>Admin</option>
<option value="2" ${user.roleid == 2 ? 'selected' : ''}>User</option>
<option value="3" ${user.roleid == 3 ? 'selected' : ''}>Manager</option>
</select>
</div>
<div class="mb-3">
<label for="active" class="form-label">Status:</label>
<select class="form-control" id="active" name="active">
<option value="1" ${user.active == 1 ? 'selected' : ''}>Active</option>
<option value="0" ${user.active == 0 ? 'selected' : ''}>Inactive</option>
</select>
</div>
</div>
</div>
<input type="hidden" name="isEdit" value="${user.isEdit}">
<c:if test="${user.isEdit}">
<input type="hidden" name="createDate" value="${user.createDate}">
</c:if>
</div>
</div>
<div class="card-footer text-muted">
<a href="<c:url value="/admin/users/add"/>" class="btn btn-secondary"><i class="fas fa-new"></i> New</a>
<a href="<c:url value="/admin/users" />" class="btn btn-success"><i class="fas fa-bars"></i> List Users</a>
<button class="btn btn-primary" type="submit"><i class="fas fa-save"></i>
<span>Submit</span>
</button>
</div>
</form>
</div>
</section>
</body>
</html>
