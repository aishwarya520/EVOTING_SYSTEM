<%@ page contentType="text/html;charset=UTF-8"
         import="com.evoting.dao.VoterDAO,
                 com.evoting.dao.ElectionDAO,
                 com.evoting.dao.VoteDAO,
                 com.evoting.model.Voter,
                 java.util.List" %>
<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("adminLogin.jsp"); return;
    }
    List<Voter> voters    = new VoterDAO().getAllVoters();
    int         elections = new ElectionDAO().getAllElections().size();
    long        approved  = voters.stream().filter(v -> "approved".equals(v.getStatus())).count();
    long        pending   = voters.stream().filter(v -> "pending".equals(v.getStatus())).count();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | E-Voting</title>
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
        <div class="page-title">&#127968; Admin Dashboard</div>

        <!-- Stats -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="sc-num"><%= voters.size() %></div>
                <div class="sc-lbl">Total Voters</div>
            </div>
            <div class="stat-card">
                <div class="sc-num"><%= approved %></div>
                <div class="sc-lbl">Approved</div>
            </div>
            <div class="stat-card">
                <div class="sc-num"><%= pending %></div>
                <div class="sc-lbl">Pending</div>
            </div>
            <div class="stat-card">
                <div class="sc-num"><%= elections %></div>
                <div class="sc-lbl">Elections</div>
            </div>
        </div>

        <!-- Quick-action cards -->
        <div class="two-col mt-2">
            <a href="viewVoters.jsp" style="text-decoration:none">
                <div class="feature-card">
                    <div class="fc-icon" style="background:#eef3fd;color:#2d5be3">&#128101;</div>
                    <h3>Manage Voters</h3>
                    <p>View all registered voters, approve or reject pending registrations.</p>
                </div>
            </a>
            <a href="viewResults.jsp" style="text-decoration:none">
                <div class="feature-card">
                    <div class="fc-icon" style="background:#fff8e6;color:#946200">&#128202;</div>
                    <h3>Election Results</h3>
                    <p>View live vote counts and rankings for all elections.</p>
                </div>
            </a>
        </div>
    </div>
</div>

</body>
</html>
