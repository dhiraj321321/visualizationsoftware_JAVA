<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.login.visualizationsoftware.model.User" %>
<%
    // Session check remains the same
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // We still get the file name to display it on the page
    String currentFile = (String) session.getAttribute("currentFile");
    if (currentFile == null) {
        response.sendRedirect("upload.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Chart Type - DataViz Pro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .chart-card {
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
            border: 1px solid #dee2e6;
            height: 100%;
        }
        .chart-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .chart-card a {
            text-decoration: none;
            color: inherit;
        }
        .chart-card-img {
            padding: 2rem 1rem;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 150px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="dashboard.jsp"><i class="bi bi-bar-chart-line-fill"></i> DataViz Pro</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle"></i> <%= user.getName() %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="logout.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5">
    <div class="text-center mb-5">
        <h1 class="display-6">Choose Your Visualization</h1>
        <p class="lead text-muted">Select a chart type to visualize your data from <strong class="text-dark"><%= currentFile %></strong>.</p>
    </div>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-4">
        
        <div class="col">
            <div class="card chart-card text-center">
                <a href="chart?type=bar">
                    <div class="chart-card-img">
                         <svg width="80" height="80" viewBox="0 0 24 24" fill="#0d6efd"><path d="M2 20h20v2H2v-2zM4 18h2V6H4v12zm4 0h2V9H8v9zm4 0h2V3h-2v15zm4 0h2V12h-2v6z"/></svg>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Bar Chart</h5>
                        <p class="card-text small text-muted">Best for comparing values across different categories.</p>
                    </div>
                </a>
            </div>
        </div>

        <div class="col">
            <div class="card chart-card text-center">
                 <a href="chart?type=pie">
                    <div class="chart-card-img">
                        <svg width="80" height="80" viewBox="0 0 24 24" fill="#198754"><path d="M12 2C6.5 2 2 6.5 2 12s4.5 10 10 10 10-4.5 10-10S17.5 2 12 2zm1 1.1c.3.1.6.2.9.4l-2.8 2.8C11.1 6.1 11.1 6 11 6h2zm-2.1 2.8c-.2.3-.3.6-.4.9L7.7 7.7c.2-.1.5-.2.8-.3L10.9 9zM11 13v8.9c-.3-.1-.7-.2-1-.4l2.8-2.8c.1.1.2.2.3.4l-2.1 2.1zM13 11V3.1c.3.1.7.2 1 .4l-2.8 2.8c-.1-.1-.2-.2-.3-.4l2.1-2.1z"/></svg>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Pie Chart</h5>
                        <p class="card-text small text-muted">Ideal for showing the proportions of a whole.</p>
                    </div>
                 </a>
            </div>
        </div>

        <div class="col">
            <div class="card chart-card text-center">
                 <a href="chart?type=line">
                    <div class="chart-card-img">
                         <svg width="80" height="80" viewBox="0 0 24 24" fill="#ffc107"><path d="M2 18h20v2H2v-2zm1.2-6.4L6 14.3l3.3-2.9 3.2 2.1L20 8.2l-1.2-1.4-7.3 6-3.2-2.1L7.2 13 3.2 9.2 2 10.4z"/></svg>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Line Chart</h5>
                        <p class="card-text small text-muted">Used to display trends over a period of time.</p>
                    </div>
                 </a>
            </div>
        </div>

        <div class="col">
            <div class="card chart-card text-center">
                <a href="chart?type=histogram">
                    <div class="chart-card-img">
                         <svg width="80" height="80" viewBox="0 0 24 24" fill="#0dcaf0"><path d="M3 20h18v2H3v-2zm1-2h2V8H4v10zm4 0h2V4H8v14zm4 0h2V12h-2v6zm4 0h2V6h-2v12z"/></svg>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Histogram</h5>
                        <p class="card-text small text-muted">Shows the frequency distribution of a dataset.</p>
                    </div>
                </a>
            </div>
        </div>
    </div>
    
    <div class="text-center mt-5">
        <a href="upload.jsp" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-repeat me-2"></i>Use a Different File
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>