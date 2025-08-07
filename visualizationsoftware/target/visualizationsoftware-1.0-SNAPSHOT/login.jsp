<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - DataViz Pro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #f0f2f5; /* Consistent background */
        }
        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .card {
            border: none;
            border-radius: 0.75rem;
        }
        .password-toggle {
            cursor: pointer;
            position: absolute;
            top: 50%;
            right: 1rem;
            transform: translateY(-50%);
            color: #6c757d;
        }
    </style>
</head>
<body>

<div class="container login-container">
    <div class="row justify-content-center w-100">
        <div class="col-md-8 col-lg-6 col-xl-5">
            <div class="card shadow-lg">
                <div class="card-body p-4 p-md-5">
                    <div class="text-center mb-4">
                        <h2 class="h3 fw-bold"><i class="bi bi-bar-chart-line-fill me-2"></i>DataViz Pro</h2>
                        <p class="text-muted">Welcome back! Please login to your account.</p>
                    </div>

                    <% 
                        String errorMessage = (String) request.getAttribute("errorMessage");
                        if (errorMessage != null) {
                    %>
                        <div class="alert alert-danger" role="alert">
                            <%= errorMessage %>
                        </div>
                    <% 
                        }
                        String status = request.getParameter("status");
                        if ("success".equals(status)) {
                    %>
                        <div class="alert alert-success" role="alert">
                            Registration successful! You can now log in.
                        </div>
                    <% } %>

                    <form action="login" method="post">
                        
                        <div class="form-floating mb-3">
                            <input type="email" name="email" id="email" class="form-control" placeholder="name@example.com" required>
                            <label for="email"><i class="bi bi-envelope me-2"></i>Email Address</label>
                        </div>

                        <div class="form-floating mb-3 position-relative">
                            <input type="password" name="password" id="password" class="form-control" placeholder="Password" required>
                            <label for="password"><i class="bi bi-lock me-2"></i>Password</label>
                            <i class="bi bi-eye-slash password-toggle" id="togglePassword"></i>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="rememberMe" id="rememberMe">
                                <label class="form-check-label" for="rememberMe">
                                    Remember me
                                </label>
                            </div>
                            <a href="#" class="small text-decoration-none">Forgot password?</a>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg fw-bold">Login</button>
                        </div>
                    </form>
                    
                    <hr class="my-4">
                    
                    <div class="text-center">
                        <p class="text-muted">Don't have an account? <a href="register.jsp" class="fw-bold text-decoration-none">Sign up here</a></p>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const togglePassword = document.getElementById('togglePassword');
        const passwordInput = document.getElementById('password');

        togglePassword.addEventListener('click', function() {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            // Toggle the eye icon
            this.classList.toggle('bi-eye');
            this.classList.toggle('bi-eye-slash');
        });
    });
</script>

</body>
</html>