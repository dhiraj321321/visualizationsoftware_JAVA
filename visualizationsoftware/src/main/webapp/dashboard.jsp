<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.login.visualizationsoftware.model.User" %>
<%@ page import="com.login.visualizationsoftware.dao.FileDAO" %>
<%@ page import="com.login.visualizationsoftware.model.FileMetadata" %>
<%@ page import="java.sql.SQLException" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<FileMetadata> files = null;
    String errorMessage = null;
    try {
        files = FileDAO.getFilesByUser(user.getId());
    } catch (SQLException e) {
        e.printStackTrace();
        errorMessage = "Error: Could not retrieve your files from the database.";
    }
    
    SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | DataViz Pro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .table-hover tbody tr:hover { background-color: #f1f1f1; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="dashboard.jsp"><i class="bi bi-bar-chart-line-fill"></i> DataViz Pro</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle"></i> <%= user.getName() %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h2">Dashboard</h1>
        <a href="upload.jsp" class="btn btn-primary shadow-sm">
            <i class="bi bi-cloud-arrow-up-fill me-2"></i>Upload New File
        </a>
    </div>

    <div class="card shadow-sm">
        <div class="card-header"><h4 class="mb-0">Your Uploaded Files</h4></div>
        <div class="card-body">
            <%-- This is the corrected block --%>
            <% if (errorMessage != null) { %>
                <div class="alert alert-danger text-center" role="alert">
                    <h4 class="alert-heading"><i class="bi bi-exclamation-triangle-fill"></i> An Error Occurred</h4>
                    <p><%= errorMessage %></p>
                    <hr>
                    <p class="mb-0">Please check your database connection and table structure.</p>
                </div>
            <% } else if (files != null && !files.isEmpty()) { %>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th><i class="bi bi-file-earmark-text"></i> File Name</th>
                                <th><i class="bi bi-calendar-check"></i> Upload Date</th>
                                <th class="text-center"><i class="bi bi-trash"></i> Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (FileMetadata file : files) { %>
                                <tr>
                                    <td><%= file.getFileName() %></td>
                                    <td><%= sdf.format(file.getUploadDate()) %></td>
                                    <td class="text-center">
                                        <a href="delete?fileId=<%= file.getId() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this file?');">
                                            <i class="bi bi-trash"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                <div class="alert alert-info text-center">
                    <p class="lead mb-1">You haven't uploaded any files yet.</p>
                    <p>Click the 'Upload New File' button to get started.</p>
                </div>
            <% } %>
         
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>