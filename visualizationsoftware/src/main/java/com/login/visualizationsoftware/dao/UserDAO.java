package com.login.visualizationsoftware.dao;

import com.login.visualizationsoftware.model.User;
import com.login.visualizationsoftware.util.DBConnection;
import java.sql.*;

public class UserDAO {

    // This method replaces getUserByEmailAndPassword
    public static User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password") // This password is the HASH from the DB
                );
            }
        }
        return null;
    }

    public static boolean emailExists(String email) throws SQLException {
        String sql = "SELECT id FROM users WHERE email = ?";
         try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // Returns true if a user with this email exists
            }
        }
    }
}