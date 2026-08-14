package com.evoting.servlet;

import com.evoting.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username").trim();
        String password = req.getParameter("password");

        String sql = "SELECT id FROM admin WHERE username=? AND password=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = req.getSession(true);
                session.setAttribute("adminUser", username);
                res.sendRedirect("admin/adminHome.jsp");
            } else {
                res.sendRedirect("admin/adminLogin.jsp?error=Invalid+username+or+password.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            res.sendRedirect("admin/adminLogin.jsp?error=Server+error.+Please+try+again.");
        }
    }
}