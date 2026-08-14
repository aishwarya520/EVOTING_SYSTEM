package com.evoting.servlet;

import com.evoting.dao.VoterDAO;
import com.evoting.model.Voter;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String name    = req.getParameter("name").trim();
        String dob     = req.getParameter("dob").trim();
        String email   = req.getParameter("email").trim().toLowerCase();
        String gender  = req.getParameter("gender");
        String phone   = req.getParameter("phone").trim();
        String address = req.getParameter("address").trim();
        String pass    = req.getParameter("password");

        if (name.isEmpty() || dob.isEmpty() || email.isEmpty() ||
            gender == null || phone.isEmpty() || address.isEmpty() || pass.isEmpty()) {
            res.sendRedirect("register.jsp?error=All+fields+are+required.");
            return;
        }

        VoterDAO dao = new VoterDAO();
        if (dao.emailExists(email)) {
            res.sendRedirect("register.jsp?error=This+email+is+already+registered.");
            return;
        }

        Voter v = new Voter();
        v.setName(name);
        v.setDob(dob);
        v.setEmail(email);
        v.setGender(gender);
        v.setPhone(phone);
        v.setAddress(address);
        v.setPassword(pass);

        if (dao.registerVoter(v)) {
            res.sendRedirect("register_success.jsp");
        } else {
            res.sendRedirect("register.jsp?error=Registration+failed.+Please+try+again.");
        }
    }
}