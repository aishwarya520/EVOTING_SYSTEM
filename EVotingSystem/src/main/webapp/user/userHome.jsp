<%@ page contentType="text/html;charset=UTF-8"
         import="com.evoting.dao.ElectionDAO,
                 com.evoting.dao.VoteDAO,
                 com.evoting.dao.CandidateDAO,
                 com.evoting.model.Election,
                 com.evoting.model.Voter,
                 java.util.List" %>
<%
    /* ── Session guard ── */
    if (session.getAttribute("voter") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Voter voter       = (Voter) session.getAttribute("voter");
    List<Election> elections = new ElectionDAO().getAllElections();
    VoteDAO        voteDAO   = new VoteDAO();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | E-Voting</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<nav class="navbar">
    <span class="brand">E-<span>Vote</span></span>
    <div class="nav-links">
        <span class="user-info">Hello, <%= voter.getName() %></span>
        <a href="../logout" class="logout">Logout</a>
    </div>
</nav>

<div style="max-width:820px;margin:36px auto;padding:0 20px">

    <div class="page-title">&#127931; Available Elections</div>

    <% if (request.getParameter("msg") != null) { %>
        <div class="alert alert-success">&#10003; <%= request.getParameter("msg") %></div>
    <% } %>

    <% if (elections.isEmpty()) { %>
        <div class="alert alert-info">No elections are available at this time. Check back later.</div>
    <% } else { %>

        <div class="election-list">
            <% for (Election el : elections) {
                boolean hasVoted = voteDAO.hasVoted(voter.getId(), el.getId());
                int candCount = new CandidateDAO().getCandidatesByElection(el.getId()).size();
            %>
            <div class="election-item <%= hasVoted ? "voted" : "" %>"
                 <%= !hasVoted ? "onclick=\"location.href='votingPage.jsp?electionId=" + el.getId() + "'\"" : "" %>>
                <div>
                    <h3><%= el.getName() %></h3>
                    <div class="meta">
                        Ends: <strong><%= el.getEndDate() %></strong>
                        &nbsp;&#183;&nbsp;
                        Candidates: <strong><%= candCount %></strong>
                    </div>
                </div>
                <div>
                    <% if (hasVoted) { %>
                        <span class="badge badge-approved">&#10003; Voted</span>
                    <% } else { %>
                        <span class="badge badge-active">Vote Now &rarr;</span>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>

    <% } %>
</div>

</body>
</html>
