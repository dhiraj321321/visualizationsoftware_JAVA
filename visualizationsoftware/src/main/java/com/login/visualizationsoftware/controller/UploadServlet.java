package com.login.visualizationsoftware.controller;

import com.login.visualizationsoftware.model.User;
import com.login.visualizationsoftware.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/upload") 
@MultipartConfig
public class UploadServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Part filePart = request.getPart("dataFile");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            int labelIndex = Integer.parseInt(request.getParameter("labelColumn"));
            int valueIndex = Integer.parseInt(request.getParameter("valueColumn"));
            int limitCount = Integer.parseInt(request.getParameter("limitCount"));

            String appPath = request.getServletContext().getRealPath("");
            String uploadPath = appPath + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            String filePath = uploadPath + File.separator + fileName;
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
            }

            // Save metadata to DB
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "INSERT INTO files (user_id, filename, file_path, upload_date) VALUES (?, ?, ?, NOW())";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, user.getId());
                stmt.setString(2, fileName);
                stmt.setString(3, filePath);
                stmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("Database Error: Failed to save file metadata.");
                e.printStackTrace();
            }
            
            // Set attributes needed by the NEXT servlet (ChartServlet)
            session.setAttribute("filePath", filePath);
            session.setAttribute("labelIndex", labelIndex);
            session.setAttribute("valueIndex", valueIndex);
            session.setAttribute("limitCount", limitCount);
            session.setAttribute("currentFile", fileName);

            // Redirect to the chart selection page to begin visualization
            response.sendRedirect("selectChart.jsp");

        } catch (Exception e) {
            System.err.println("UPLOAD SERVLET FAILED:");
            e.printStackTrace();
            session.setAttribute("uploadError", "Error processing your request: " + e.getMessage());
            response.sendRedirect("upload.jsp");
        }
    }
}