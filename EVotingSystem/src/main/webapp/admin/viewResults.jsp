<%@ page contentType="text/html;charset=UTF-8"
         import="com.evoting.dao.ElectionDAO,
                 com.evoting.dao.CandidateDAO,
                 com.evoting.dao.VoteDAO,
                 com.evoting.model.Election,
                 com.evoting.model.Candidate,
                 java.util.List" %>
<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("adminLogin.jsp"); return;
    }
    request.setAttribute("currentPage", "results");

    List<Election> elections = new ElectionDAO().getAllElections();
    CandidateDAO   candDAO   = new CandidateDAO();
    VoteDAO        voteDAO   = new VoteDAO();

    /* Determine which election to show (default = first) */
    int selectedId = 0;
    String eidParam = request.getParameter("electionId");
    if (eidParam != null && !eidParam.isEmpty()) {
        selectedId = Integer.parseInt(eidParam);
    } else if (!elections.isEmpty()) {
        selectedId = elections.get(0).getId();
    }

    List<Candidate> candidates = (selectedId > 0)
        ? candDAO.getCandidatesWithVotes(selectedId)
        : new java.util.ArrayList<>();
    int totalVotes = (selectedId > 0) ? voteDAO.getTotalVotes(selectedId) : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Results | E-Voting</title>
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
        <div class="page-title">&#128202; Election Results</div>

        <% if (elections.isEmpty()) { %>
            <div class="alert alert-info">No elections found. <a href="addElection.jsp">Add one first.</a></div>
        <% } else { %>

        <!-- Election selector tabs -->
        <div style="display:flex;gap:8px;flex-wrap:wrap;margin-bottom:24px">
            <% for (Election e : elections) { %>
            <a href="viewResults.jsp?electionId=<%= e.getId() %>"
               class="btn <%= e.getId() == selectedId ? "btn-primary" : "btn-ghost" %>">
                <%= e.getName() %>
            </a>
            <% } %>
        </div>

        <!-- Results panel -->
        <% if (candidates.isEmpty()) { %>
            <div class="alert alert-info">No candidates have been added to this election yet.</div>
        <% } else { %>

        <div class="content-card" style="max-width:760px">

            <!-- Header row -->
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:22px">
                <div>
                    <% if (!candidates.isEmpty() && candidates.get(0).getVoteCount() > 0) { %>
                        <span style="font-size:15px;font-weight:600;color:var(--navy)">
                            &#127942; Leader: <%= candidates.get(0).getName() %>
                            &nbsp;<span class="text-muted">(<%=candidates.get(0).getPartyName()%>)</span>
                        </span>
                    <% } else { %>
                        <span class="text-muted">No votes cast yet.</span>
                    <% } %>
                </div>
                <span class="text-muted">
                    Total votes: <strong style="color:var(--navy)"><%= totalVotes %></strong>
                </span>
            </div>

            <!-- Progress bars -->
            <% for (int i = 0; i < candidates.size(); i++) {
                Candidate c = candidates.get(i);
                int pct = totalVotes > 0 ? (int)((c.getVoteCount() * 100.0) / totalVotes) : 0;
            %>
            <div class="result-item">
                <div class="result-header">
                    <span>
                        <%= i == 0 && c.getVoteCount() > 0 ? "&#127942; " : (i+1) + ". " %>
                        <strong><%= c.getName() %></strong>
                        <span class="text-muted">&nbsp;(<%= c.getPartyName() %>)</span>
                    </span>
                    <span>
                        <strong><%= c.getVoteCount() %></strong> vote<%= c.getVoteCount() != 1 ? "s" : "" %>
                        &nbsp;&mdash;&nbsp;<%= pct %>%
                    </span>
                </div>
                <div class="result-track">
                    <div class="result-fill" style="width:<%= pct %>%"></div>
                </div>
            </div>
            <% } %>

            <div class="divider"></div>

            <!-- Summary table -->
            <table>
                <thead>
                    <tr><th>Rank</th><th>Candidate</th><th>Party</th><th>Votes</th><th>Share %</th></tr>
                </thead>
                <tbody>
                <% for (int i = 0; i < candidates.size(); i++) {
                    Candidate c = candidates.get(i);
                    int pct = totalVotes > 0 ? (int)((c.getVoteCount() * 100.0) / totalVotes) : 0;
                %>
                    <tr>
                        <td><%= i+1 == 1 && c.getVoteCount() > 0 ? "&#127942;" : String.valueOf(i+1) %></td>
                        <td class="text-strong"><%= c.getName() %></td>
                        <td><%= c.getPartyName() %></td>
                        <td><strong><%= c.getVoteCount() %></strong></td>
                        <td><%= pct %>%</td>
                    </tr>
                <% } %>
                </tbody>
            </table>

        </div>
        <% } /* end candidates not empty */ %>
        <% } /* end elections not empty */ %>
    </div>
</div>

</body>
</html>
