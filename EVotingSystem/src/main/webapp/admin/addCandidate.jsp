<%@ page contentType="text/html;charset=UTF-8"
         import="com.evoting.dao.ElectionDAO,
                 com.evoting.dao.CandidateDAO,
                 com.evoting.model.Election,
                 com.evoting.model.Candidate,
                 java.util.List" %>
<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("adminLogin.jsp"); return;
    }
    request.setAttribute("currentPage", "candidate");
    List<Election>  elections  = new ElectionDAO().getAllElections();
    /* Show candidates for the currently selected election, if any */
    String eidStr = request.getParameter("electionId");
    List<Candidate> existingCandidates = null;
    if (eidStr != null && !eidStr.isEmpty()) {
        existingCandidates = new CandidateDAO().getCandidatesByElection(Integer.parseInt(eidStr));
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Candidate | E-Voting</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<nav class="navbar">
    <span class="brand">E-<span>Vote</span></span>
    <div class="nav-links">
        <span class="user-info">Admin: <%= session.getAttribute("adminUser") %></span>
        <a href="../logout" class="logout">Logout</a>
    </div>
</nav>

<div class="admin-layout">

    <%@ include file="sidebar.jsp" %>

    <div class="main-content">
        <div class="page-title">&#128100; Add Candidate</div>

        <% if (request.getParameter("msg") != null) { %>
            <div class="alert alert-success">&#10003; <%= request.getParameter("msg") %></div>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-error">&#9888; <%= request.getParameter("error") %></div>
        <% } %>

        <% if (elections.isEmpty()) { %>
            <div class="alert alert-warning">
                &#9888; No elections found.
                <a href="addElection.jsp" style="color:var(--amber)">Add an election first</a>
                before adding candidates.
            </div>
        <% } else { %>

        <div class="content-card" style="max-width:600px">
            <form action="../addCandidate" method="post" enctype="multipart/form-data">

                <div class="form-group">
                    <label>Select Election *</label>
                    <select name="electionId" required
                            onchange="this.form.action='addCandidate.jsp?electionId='+this.value;this.form.submit()">
                        <option value="">-- Select Election --</option>
                        <% for (Election e : elections) { %>
                            <option value="<%= e.getId() %>"
                                <%= (eidStr != null && eidStr.equals(String.valueOf(e.getId()))) ? "selected" : "" %>>
                                <%= e.getName() %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <% if (eidStr != null && !eidStr.isEmpty()) { %>
                <!-- Restore election id for actual form submission -->
                <input type="hidden" name="electionId" value="<%= eidStr %>">

                <div class="form-row">
                    <div class="form-group">
                        <label>Candidate Name *</label>
                        <input type="text" name="candidateName" placeholder="Full name" required>
                    </div>
                    <div class="form-group">
                        <label>Party Name *</label>
                        <input type="text" name="partyName" placeholder="Party / affiliation" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Address / Constituency</label>
                    <input type="text" name="address" placeholder="City or constituency">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="tel" name="phone" placeholder="+91 9XXXXXXXXX">
                    </div>
                    <div class="form-group">
                        <label>Logo / Symbol (optional)</label>
                        <input type="file" name="logo" accept="image/*"
                               style="padding:8px;background:var(--surface2);border:1.5px solid var(--border);border-radius:8px;width:100%">
                    </div>
                </div>

                <button type="submit" class="btn btn-primary btn-block" style="margin-top:8px"
                        formaction="../addCandidate">
                    &#128100; Add Candidate
                </button>
                <% } %>

            </form>
        </div>

        <!-- Existing candidates for selected election -->
        <% if (existingCandidates != null) { %>
        <div class="table-container mt-3">
            <div class="table-header">
                Candidates in this election (<%= existingCandidates.size() %>)
            </div>
            <table>
                <thead>
                    <tr><th>#</th><th>Name</th><th>Party</th><th>Address</th><th>Phone</th></tr>
                </thead>
                <tbody>
                <% if (existingCandidates.isEmpty()) { %>
                    <tr><td colspan="5" class="no-data">No candidates added yet.</td></tr>
                <% } %>
                <% int i=1; for (Candidate c : existingCandidates) { %>
                    <tr>
                        <td><%= i++ %></td>
                        <td class="text-strong"><%= c.getName() %></td>
                        <td><%= c.getPartyName() %></td>
                        <td><%= c.getAddress() != null ? c.getAddress() : "—" %></td>
                        <td><%= c.getPhone()   != null ? c.getPhone()   : "—" %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } %>

        <% } /* end if elections not empty */ %>

    </div>
</div>

<script>
/* Prevent the SELECT onchange from submitting with enctype=multipart/form-data -
   it uses GET to reload, the real add-candidate submit uses POST to /addCandidate */
</script>

</body>
</html>
