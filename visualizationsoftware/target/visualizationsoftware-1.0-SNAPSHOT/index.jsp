<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.login.visualizationsoftware.model.User" %>
<%
    // This logic is perfect and remains.
    // If a user is already logged in, send them straight to the dashboard.
    User user = (User) session.getAttribute("user");
    if (user != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DataViz Pro | Turn Data into Insight</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', sans-serif;
        }
        .navbar {
            background-color: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
        }
        .hero-section {
            padding: 6rem 0;
            background-color: #f8f9fa;
        }
        .feature-icon {
            font-size: 2.5rem;
            color: var(--bs-primary);
        }
        .section {
            padding: 4rem 0;
        }
        .footer {
            background-color: #343a40;
            color: #adb5bd;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">
            <i class="bi bi-bar-chart-line-fill text-primary"></i>
            DataViz Pro
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-lg-center">
                <li class="nav-item">
                    <a class="nav-link" href="#features">Features</a>
                </li>
                <li class="nav-item ms-lg-2">
                    <a href="login.jsp" class="btn btn-outline-secondary btn-sm">Login</a>
                </li>
                <li class="nav-item ms-lg-2 mt-2 mt-lg-0">
                    <a href="register.jsp" class="btn btn-primary btn-sm">Sign Up Free</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<section class="hero-section">
    <div class="container">
        <div class="row align-items-center g-5">
            <div class="col-lg-6">
                <h1 class="display-4 fw-bold lh-1 mb-4">Turn Your Raw Data Into Actionable Insights</h1>
                <p class="lead text-muted mb-4">Our platform makes it simple to upload your CSV files, generate beautiful interactive charts, and uncover the stories hidden in your data. No complex software required.</p>
                <div class="d-grid gap-2 d-md-flex">
                    <a href="register.jsp" class="btn btn-primary btn-lg px-4 me-md-2">Get Started for Free</a>
                    <a href="#features" class="btn btn-outline-secondary btn-lg px-4">Learn More</a>
                </div>
            </div>
            <div class="col-lg-6">
                <img src="data:image/svg+xml,%3csvg id='visual' viewBox='0 0 900 600' width='900' height='600' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' version='1.1'%3e%3crect x='0' y='0' width='900' height='600' fill='%23f8f9fa'%3e%3c/rect%3e%3cdefs%3e%3cmarker id='arrow' markerWidth='10' markerHeight='10' refX='5' refY='5' orient='auto'%3e%3cpath d='M0,0L10,5L0,10' fill='none' stroke='%23343a40'%3e%3c/path%3e%3c/marker%3e%3c/defs%3e%3cpath d='M300 550L300 50' stroke='%23343a40' stroke-width='2' marker-end='url(%23arrow)'%3e%3c/path%3e%3cpath d='M300 550L850 550' stroke='%23343a40' stroke-width='2' marker-end='url(%23arrow)'%3e%3c/path%3e%3crect x='350' y='350' width='80' height='200' fill='%230d6efd'%3e%3c/rect%3e%3crect x='450' y='250' width='80' height='300' fill='%230dcaf0'%3e%3c/rect%3e%3crect x='550' y='400' width='80' height='150' fill='%23198754'%3e%3c/rect%3e%3crect x='650' y='300' width='80' height='250' fill='%23ffc107'%3e%3c/rect%3e%3ccircle cx='150' cy='150' r='100' fill='%230d6efd' stroke='%23FFFFFF' stroke-width='10'%3e%3c/circle%3e%3ccircle cx='150' cy='150' r='60' fill='%23198754' stroke='%23FFFFFF' stroke-width='10'%3e%3c/circle%3e%3ccircle cx='150' cy='150' r='20' fill='%23ffc107' stroke='%23FFFFFF' stroke-width='10'%3e%3c/circle%3e%3c/svg%3e" class="img-fluid" alt="Data Visualization Illustration">
            </div>
        </div>
    </div>
</section>

<section id="features" class="section">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold">Everything You Need to Get Started</h2>
            <p class="lead text-muted">A powerful toolset that's incredibly easy to use.</p>
        </div>
        <div class="row g-4 text-center">
            <div class="col-md-4">
                <div class="feature-icon bg-primary bg-opacity-10 rounded-3 d-inline-flex align-items-center justify-content-center mb-3 p-3">
                    <i class="bi bi-cloud-arrow-up"></i>
                </div>
                <h5 class="fw-bold">Simple CSV Upload</h5>
                <p class="text-muted">Just drag and drop or select your CSV file. We handle the parsing so you can focus on the insights.</p>
            </div>
            <div class="col-md-4">
                <div class="feature-icon bg-primary bg-opacity-10 rounded-3 d-inline-flex align-items-center justify-content-center mb-3 p-3">
                    <i class="bi bi-bar-chart-steps"></i>
                </div>
                <h5 class="fw-bold">Multiple Chart Types</h5>
                <p class="text-muted">Choose from Bar, Pie, Line charts, and Histograms to find the perfect way to tell your data's story.</p>
            </div>
            <div class="col-md-4">
                <div class="feature-icon bg-primary bg-opacity-10 rounded-3 d-inline-flex align-items-center justify-content-center mb-3 p-3">
                    <i class="bi bi-shield-lock"></i>
                </div>
                <h5 class="fw-bold">Secure & Private</h5>
                <p class="text-muted">Your data is yours. We provide a secure environment for you to explore your datasets with peace of mind.</p>
            </div>
        </div>
    </div>
</section>

<footer class="footer py-4">
    <div class="container text-center">
        <p class="mb-0">&copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> DataViz Pro. All Rights Reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>