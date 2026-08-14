package com.evoting.servlet;

import com.evoting.dao.VoterDAO;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class ApproveVoterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Guard: admin only
        if (req.getSession(false) == null ||
            req.getSession(false).getAttribute("adminUser") == null) {
            res.sendRedirect("admin/adminLogin.jsp");
            return;
        }

        String action = req.getParameter("action");  // "approve" or "reject"
        int id;
        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NumberFormatException e) {
            res.sendRedirect("admin/viewVoters.jsp?error=Invalid+voter+ID.");
            return;
        }

        VoterDAO dao = new VoterDAO();
        boolean ok;
        String msg;

        if ("reject".equals(action)) {
            ok  = dao.rejectVoter(id);
            msg = "Voter+Rejected+Successfully";
        } else {
            ok  = dao.approveVoter(id);
            msg = "Approved+Successfully";
        }

        if (ok) {
            res.sendRedirect("admin/viewVoters.jsp?msg=" + msg);
        } else {
            res.sendRedirect("admin/viewVoters.jsp?error=Action+failed.+Please+try+again.");
        }
    }
}