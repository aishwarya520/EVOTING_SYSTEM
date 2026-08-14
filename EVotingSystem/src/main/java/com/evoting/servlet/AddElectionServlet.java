package com.evoting.servlet;

import com.evoting.dao.ElectionDAO;
import com.evoting.model.Election;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class AddElectionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (req.getSession(false) == null ||
            req.getSession(false).getAttribute("adminUser") == null) {
            res.sendRedirect("admin/adminLogin.jsp");
            return;
        }

        String name    = req.getParameter("electionName").trim();
        String endDate = req.getParameter("endDate").trim();

        if (name.isEmpty() || endDate.isEmpty()) {
            res.sendRedirect("admin/addElection.jsp?error=All+fields+are+required.");
            return;
        }

        Election election = new Election();
        election.setName(name);
        election.setEndDate(endDate);

        ElectionDAO dao = new ElectionDAO();
        if (dao.addElection(election)) {
            res.sendRedirect("admin/addElection.jsp?msg=Election+Created+Successfully");
        } else {
            res.sendRedirect("admin/addElection.jsp?error=Failed+to+create+election.");
        }
    }
}