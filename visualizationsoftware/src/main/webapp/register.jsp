<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - DataViz Pro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #f0f2f5; /* A softer background color */
        }
        .register-container {
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

<div class="container register-container">
    <div class="row justify-content-center w-100">
        <div class="col-md-8 col-lg-6 col-xl-5">
            <div class="card shadow-lg">
                <div class="card-body p-4 p-md-5">
                    <div class="text-center mb-4">
                        <h2 class="h3 fw-bold"><i class="bi bi-bar-chart-line-fill me-2"></i>DataViz Pro</h2>
                        <p class="text-muted">Create your account to get started.</p>
                    </div>

                    <% 
                        String errorMessage = (String) request.getAttribute("errorMessage");
                        if (errorMessage != null) {
                    %>
                        <div class="alert alert-danger" role="alert">
                            <%= errorMessage %>
                        </div>
                    <% } %>

                    <form id="registerForm" action="register" method="post">
                        
                        <div class="form-floating mb-3">
                            <input type="text" name="name" id="name" class="form-control" placeholder="John Doe" required>
                            <label for="name"><i class="bi bi-person me-2"></i>Full Name</label>
                        </div>
                        
                        <div class="form-floating mb-3">
                            <input type="email" name="email" id="email" class="form-control" placeholder="name@example.com" required>
                            <label for="email"><i class="bi bi-envelope me-2"></i>Email Address</label>
                        </div>

                        <div class="form-floating mb-3 position-relative">
                            <input type="password" name="password" id="password" class="form-control" placeholder="Password" required>
                            <label for="password"><i class="bi bi-lock me-2"></i>Password</label>
                            <i class="bi bi-eye-slash password-toggle" id="togglePassword"></i>
                        </div>

                        <div class="form-floating mb-4 position-relative">
                            <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" placeholder="Confirm Password" required>
                            <label for="confirmPassword"><i class="bi bi-shield-lock me-2"></i>Confirm Password</label>
                            <i class="bi bi-eye-slash password-toggle" id="toggleConfirmPassword"></i>
                            <div class="invalid-feedback" id="passwordError">
                                Passwords do not match.
                            </div>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg fw-bold">Create Account</button>
                        </div>
                    </form>
                    
                    <hr class="my-4">
                    
                    <div class="text-center">
                        <p class="text-muted">Already have an account? <a href="login.jsp" class="fw-bold text-decoration-none">Login here</a></p>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const registerForm = document.getElementById('registerForm');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        const passwordError = document.getElementById('passwordError');

        // Function to toggle password visibility
        function toggleVisibility(inputId, toggleId) {
            const input = document.getElementById(inputId);
            const toggle = document.getElementById(toggleId);
            toggle.addEventListener('click', function() {
                const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
                input.setAttribute('type', type);
                this.classList.toggle('bi-eye');
                this.classList.toggle('bi-eye-slash');
            });
        }

        toggleVisibility('password', 'togglePassword');
        toggleVisibility('confirmPassword', 'toggleConfirmPassword');

        // Form submission validation
        registerForm.addEventListener('submit', function(event) {
            if (password.value !== confirmPassword.value) {
                // Prevent form submission
                event.preventDefault();
                // Show error message
                confirmPassword.classList.add('is-invalid');
                passwordError.style.display = 'block';
            } else {
                // Hide error message if passwords match
                confirmPassword.classList.remove('is-invalid');
                passwordError.style.display = 'none';
            }
        });
    });
</script>

</body>
</html>