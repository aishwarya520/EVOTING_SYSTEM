package com.evoting.dao;

import com.evoting.model.Election;
import com.evoting.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/** All database operations related to elections. */
public class ElectionDAO {

    public boolean addElection(Election e) {
        String sql = "INSERT INTO elections (name, end_date) VALUES (?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, e.getName());
            ps.setString(2, e.getEndDate());
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) { ex.printStackTrace(); return false; }
    }

    public List<Election> getAllElections() {
        List<Election> list = new ArrayList<>();
        String sql = "SELECT * FROM elections ORDER BY created_at DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next())
                list.add(new Election(rs.getInt("id"),
                                      rs.getString("name"),
                                      rs.getString("end_date")));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Election getElectionById(int id) {
        String sql = "SELECT * FROM elections WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return new Election(rs.getInt("id"),
                                    rs.getString("name"),
                                    rs.getString("end_date"));
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }
}
