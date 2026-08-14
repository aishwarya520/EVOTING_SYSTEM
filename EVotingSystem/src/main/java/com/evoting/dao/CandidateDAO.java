package com.evoting.dao;

import com.evoting.model.Candidate;
import com.evoting.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/** All database operations related to candidates. */
public class CandidateDAO {

    public boolean addCandidate(Candidate cand) {
        String sql = "INSERT INTO candidates (election_id,name,party_name,address,phone,logo_path) "
                   + "VALUES (?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, cand.getElectionId());
            ps.setString(2, cand.getName());
            ps.setString(3, cand.getPartyName());
            ps.setString(4, cand.getAddress());
            ps.setString(5, cand.getPhone());
            ps.setString(6, cand.getLogoPath());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    /** Plain list (no vote counts) – used on the voting page. */
    public List<Candidate> getCandidatesByElection(int electionId) {
        List<Candidate> list = new ArrayList<>();
        String sql = "SELECT * FROM candidates WHERE election_id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, electionId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** With vote counts – used on the results page. */
    public List<Candidate> getCandidatesWithVotes(int electionId) {
        List<Candidate> list = new ArrayList<>();
        String sql = "SELECT c.*, COUNT(v.id) AS vote_count "
                   + "FROM candidates c "
                   + "LEFT JOIN votes v ON v.candidate_id = c.id "
                   + "WHERE c.election_id = ? "
                   + "GROUP BY c.id "
                   + "ORDER BY vote_count DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, electionId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Candidate cand = map(rs);
                cand.setVoteCount(rs.getInt("vote_count"));
                list.add(cand);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /* ── Row mapper ───────────────────────────────────────── */
    private Candidate map(ResultSet rs) throws SQLException {
        Candidate c = new Candidate();
        c.setId(rs.getInt("id"));
        c.setElectionId(rs.getInt("election_id"));
        c.setName(rs.getString("name"));
        c.setPartyName(rs.getString("party_name"));
        c.setAddress(rs.getString("address"));
        c.setPhone(rs.getString("phone"));
        c.setLogoPath(rs.getString("logo_path"));
        return c;
    }
}
