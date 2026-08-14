package com.evoting.servlet;

import com.evoting.dao.VoterDAO;
import com.evoting.model.Voter;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class UserLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email").trim().toLowerCase();
        String pass  = req.getParameter("password");

        VoterDAO dao   = new VoterDAO();
        Voter voter = dao.loginVoter(email, pass);

        if (voter == null) {
            res.sendRedirect("user/login.jsp?error=Invalid+email+or+password.");
            return;
        }

        switch (voter.getStatus()) {
            case "pending":
                res.sendRedirect("user/login.jsp?pending=1");
                break;
            case "rejected":
                res.sendRedirect("user/login.jsp?error=Your+registration+was+rejected+by+admin.");
                break;
            default:  // approved
                HttpSession session = req.getSession(true);
                session.setAttribute("voter", voter);
                res.sendRedirect("user/userHome.jsp");
        }
    }
}