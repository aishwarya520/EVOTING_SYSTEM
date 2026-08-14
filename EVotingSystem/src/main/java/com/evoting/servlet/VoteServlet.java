package com.evoting.servlet;

import com.evoting.dao.VoteDAO;
import com.evoting.model.Voter;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class VoteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("voter") == null) {
            res.sendRedirect("user/login.jsp");
            return;
        }

        Voter voter = (Voter) session.getAttribute("voter");

        int electionId;
        int candidateId;
        try {
            electionId  = Integer.parseInt(req.getParameter("electionId"));
            candidateId = Integer.parseInt(req.getParameter("candidateId"));
        } catch (NumberFormatException e) {
            res.sendRedirect("user/userHome.jsp?error=Invalid+vote+data.");
            return;
        }

        VoteDAO voteDAO = new VoteDAO();

        if (voteDAO.hasVoted(voter.getId(), electionId)) {
            res.sendRedirect("user/alreadyVoted.jsp");
            return;
        }

        boolean ok = voteDAO.castVote(voter.getId(), electionId, candidateId);
        if (ok) {
            res.sendRedirect("user/voteSuccess.jsp");
        } else {
            res.sendRedirect("user/votingPage.jsp?electionId=" + electionId
                           + "&error=Vote+submission+failed.+Please+try+again.");
        }
    }
}