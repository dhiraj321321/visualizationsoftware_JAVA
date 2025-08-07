package com.login.visualizationsoftware.dao;

import com.login.visualizationsoftware.model.FileMetadata;
import com.login.visualizationsoftware.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FileDAO {

    // This method is now updated to fetch rich metadata for the dashboard
    public static List<FileMetadata> getFilesByUser(int userId) throws SQLException {
        List<FileMetadata> files = new ArrayList<>();
        // Note: Assumes your 'files' table has 'id', 'filename', and 'upload_date' columns.
        String sql = "SELECT id, filename, upload_date FROM files WHERE user_id = ? ORDER BY upload_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String filename = rs.getString("filename");
                Timestamp uploadDate = rs.getTimestamp("upload_date");
                files.add(new FileMetadata(id, filename, uploadDate));
            }
        }
        return files;
    }
    
    // Add other methods like deleteFile(int fileId) here if needed
}