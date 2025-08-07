<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.ByteArrayOutputStream, java.util.Base64" %>
<%@ page import="com.login.visualizationsoftware.model.User" %>
<%
    // --- Session Check ---
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // --- Retrieve Chart and Context from Session ---
    BufferedImage chartImage = (BufferedImage) session.getAttribute("chartImage");
    String chartType = (String) session.getAttribute("chartType");
    String currentFile = (String) session.getAttribute("currentFile");

    // Default values if session attributes are null
    if (chartType == null) chartType = "Unknown Chart";
    if (currentFile == null) currentFile = "Unknown File";


    String base64Image = "";
    if (chartImage != null) {
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(chartImage, "png", baos);
            byte[] bytes = baos.toByteArray();
            base64Image = Base64.getEncoder().encodeToString(bytes);
        } catch (Exception e) {
            e.printStackTrace();
            // Handle error if image writing fails
            chartImage = null; 
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Chart: <%= chartType %> - DataViz Pro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    
    <style>
        body { background-color: #f8f9fa; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand" href="dashboard.jsp"><i class="bi bi-bar-chart-line-fill"></i> DataViz Pro</a>
        <div class="ms-auto">
             <a class="nav-link text-light" href="dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
        </div>
    </div>
</nav>

<div class="container my-5">

    <div class="text-center mb-4">
        <h1 class="h2">Your Visualization is Ready!</h1>
        <p class="lead text-muted">Below is the generated <strong><%= chartType %></strong> for the file <strong><%= currentFile %></strong>.</p>
    </div>

    <% if (!base64Image.isEmpty()) { %>
        <div class="card shadow-sm mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><%= chartType %>: <%= currentFile %></h5>
                <a href="data:image/png;base64,<%= base64Image %>" download="<%= chartType.replace(" ", "_") %>_<%= currentFile %>.png" class="btn btn-sm btn-outline-primary">
                    <i class="bi bi-download me-2"></i>Download
                </a>
            </div>
            <div class="card-body text-center p-4">
                <img src="data:image/png;base64,<%= base64Image %>" class="img-fluid border rounded" alt="Generated Chart: <%= chartType %>" />
            </div>
        </div>

        <div class="text-center">
             <h4 class="h5 mb-3">What's next?</h4>
             <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                <a href="selectChart.jsp" class="btn btn-secondary">
                    <i class="bi bi-palette me-2"></i>Choose Different Chart
                </a>
                <a href="upload.jsp" class="btn btn-outline-secondary">
                    <i class="bi bi-file-earmark-plus me-2"></i>Upload New Data
                </a>
            </div>
        </div>

    <% } else { %>
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="alert alert-warning text-center" role="alert">
                    <h4 class="alert-heading"><i class="bi bi-exclamation-triangle-fill"></i> Oops! Something went wrong.</h4>
                    <p>We couldn't generate a chart from the data provided. The file might be empty, formatted incorrectly, or the selected columns may not be suitable for visualization.</p>
                    <hr>
                    <p class="mb-0">Please try again with a different file or different settings.</p>
                    <a href="upload.jsp" class="btn btn-warning mt-3">Try Again</a>
                </div>
            </div>
        </div>
    <% } %>
</div>

<footer class="text-center text-muted mt-5 py-3 bg-light fixed-bottom">
    <p class="mb-0">&copy; <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> DataViz Pro. All Rights Reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>