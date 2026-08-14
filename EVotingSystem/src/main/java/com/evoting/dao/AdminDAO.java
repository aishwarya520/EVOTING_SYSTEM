package com.evoting.dao;

import com.evoting.util.DBConnection;

import java.sql.*;

public class AdminDAO {

    public boolean loginAdmin(String username, String password) throws SQLException {

        boolean status = false;

        String sql = "SELECT id FROM admin WHERE username=? AND password=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                status = true;
            }
        }

        return status;
    }
}