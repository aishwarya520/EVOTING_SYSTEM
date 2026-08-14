package com.evoting.dao;

import com.evoting.model.Voter;
import com.evoting.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/** All database operations related to voters. */
public class VoterDAO {

    /* ── Register ─────────────────────────────────────────── */
    public boolean registerVoter(Voter v) {
        String sql = "INSERT INTO voters (name,dob,email,gender,phone,address,password,status) "
                   + "VALUES (?,?,?,?,?,?,?,'pending')";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, v.getName());
            ps.setString(2, v.getDob());
            ps.setString(3, v.getEmail());
            ps.setString(4, v.getGender());
            ps.setString(5, v.getPhone());
            ps.setString(6, v.getAddress());
            ps.setString(7, v.getPassword());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    /* ── Login ────────────────────────────────────────────── */
    public Voter loginVoter(String email, String password) {
        String sql = "SELECT * FROM voters WHERE email=? AND password=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /* ── Fetch all ────────────────────────────────────────── */
    public List<Voter> getAllVoters() {
        List<Voter> list = new ArrayList<>();
        String sql = "SELECT * FROM voters ORDER BY created_at DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /* ── Approve / Reject ─────────────────────────────────── */
    public boolean approveVoter(int id) { return setStatus(id, "approved"); }
    public boolean rejectVoter(int id)  { return setStatus(id, "rejected"); }

    private boolean setStatus(int id, String status) {
        String sql = "UPDATE voters SET status=? WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    /* ── Email uniqueness check ───────────────────────────── */
    public boolean emailExists(String email) {
        String sql = "SELECT id FROM voters WHERE email=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            return ps.executeQuery().next();
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    /* ── Row mapper ───────────────────────────────────────── */
    private Voter map(ResultSet rs) throws SQLException {
        Voter v = new Voter();
        v.setId(rs.getInt("id"));
        v.setName(rs.getString("name"));
        v.setDob(rs.getString("dob"));
        v.setEmail(rs.getString("email"));
        v.setGender(rs.getString("gender"));
        v.setPhone(rs.getString("phone"));
        v.setAddress(rs.getString("address"));
        v.setPassword(rs.getString("password"));
        v.setStatus(rs.getString("status"));
        return v;
    }
}
