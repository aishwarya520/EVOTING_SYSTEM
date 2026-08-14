package com.evoting.servlet;

import com.evoting.dao.CandidateDAO;
import com.evoting.model.Candidate;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;   // ✅ keep this
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.Paths;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 1024 * 1024 * 5,
    maxRequestSize    = 1024 * 1024 * 10
)
public class AddCandidateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        if (req.getSession(false) == null ||
            req.getSession(false).getAttribute("adminUser") == null) {
            res.sendRedirect("admin/adminLogin.jsp");
            return;
        }

        int electionId;
        try {
            electionId = Integer.parseInt(req.getParameter("electionId"));
        } catch (NumberFormatException e) {
            res.sendRedirect("admin/addCandidate.jsp?error=Please+select+a+valid+election.");
            return;
        }

        String name    = req.getParameter("candidateName").trim();
        String party   = req.getParameter("partyName").trim();
        String address = req.getParameter("address") != null ? req.getParameter("address").trim() : "";
        String phone   = req.getParameter("phone")   != null ? req.getParameter("phone").trim()   : "";

        if (name.isEmpty() || party.isEmpty()) {
            res.sendRedirect("admin/addCandidate.jsp?error=Candidate+name+and+party+are+required.");
            return;
        }

        String logoPath = "default-logo.png";
        Part logoPart = req.getPart("logo");

        if (logoPart != null && logoPart.getSize() > 0) {
            String fileName  = Paths.get(logoPart.getSubmittedFileName()).getFileName().toString();
            String uploadDir = getServletContext().getRealPath("/uploads/");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            String savedName = System.currentTimeMillis() + "_" + fileName;
            logoPart.write(uploadDir + File.separator + savedName);
            logoPath = "uploads/" + savedName;
        }

        Candidate cand = new Candidate();
        cand.setElectionId(electionId);
        cand.setName(name);
        cand.setPartyName(party);
        cand.setAddress(address);
        cand.setPhone(phone);
        cand.setLogoPath(logoPath);

        CandidateDAO dao = new CandidateDAO();
        if (dao.addCandidate(cand)) {
            res.sendRedirect("admin/addCandidate.jsp?msg=Candidate+Added+Successfully");
        } else {
            res.sendRedirect("admin/addCandidate.jsp?error=Failed+to+add+candidate.");
        }
    }
}