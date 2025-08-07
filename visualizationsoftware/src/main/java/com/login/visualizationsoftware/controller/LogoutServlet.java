package com.login.visualizationsoftware.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Handles user logout by invalidating the current session.
 */
@WebServlet("/logout") // This servlet will be accessible at the URL "logout"
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get the current session, but do not create a new one if it doesn't exist.
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Invalidate the session, which removes all attributes (like the "user" object).
            session.invalidate();
        }

        // Redirect the user back to the login page.
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // In case a POST request is ever sent, handle it the same as a GET.
        doGet(request, response);
    }
}