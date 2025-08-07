package com.login.visualizationsoftware.controller;

import com.login.visualizationsoftware.dao.UserDAO;
import com.login.visualizationsoftware.model.User;
import org.mindrot.jbcrypt.BCrypt; // Import jBCrypt

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // 1. Get user by email ONLY.
            User user = UserDAO.getUserByEmail(email);

            // 2. Check if user exists AND if passwords match using BCrypt
            if (user != null && BCrypt.checkpw(password, user.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect("dashboard.jsp");
            } else {
                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error during login.", e);
        }
    }
}