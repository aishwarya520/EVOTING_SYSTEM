package com.evoting.dao;

import com.evoting.util.DBConnection;

import java.sql.*;

/** All database operations related to casting and checking votes. */
public class VoteDAO {

    /**
     * Cast a vote.  Returns false (without throwing) when the
     * database UNIQUE constraint catches a duplicate attempt.
     */
    public boolean castVote(int voterId, int electionId, int candidateId) {
        // Guard at application level too
        if (hasVoted(voterId, electionId)) return false;

        String sql = "INSERT INTO votes (voter_id, election_id, candidate_id) VALUES (?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, voterId);
            ps.setInt(2, electionId);
            ps.setInt(3, candidateId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            // 1062 = duplicate-key error → voter already voted
            if (e.getErrorCode() == 1062) return false;
            e.printStackTrace();
            return false;
        }
    }

    /** Returns true if this voter already voted in the given election. */
    public boolean hasVoted(int voterId, int electionId) {
        String sql = "SELECT id FROM votes WHERE voter_id=? AND election_id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, voterId);
            ps.setInt(2, electionId);
            return ps.executeQuery().next();
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    /** Total votes cast in an election (for the results page). */
    public int getTotalVotes(int electionId) {
        String sql = "SELECT COUNT(*) FROM votes WHERE election_id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, electionId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
}
