<%@ page contentType="text/html;charset=UTF-8"
         import="com.evoting.dao.ElectionDAO,
                 com.evoting.model.Election,
                 java.util.List" %>
<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("adminLogin.jsp"); return;
    }
    request.setAttribute("currentPage", "election");
    List<Election> elections = new ElectionDAO().getAllElections();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Election | E-Voting</title>
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
        <div class="page-title">&#128197; Add Election</div>

        <% if (request.getParameter("msg") != null) { %>
            <div class="alert alert-success">&#10003; <%= request.getParameter("msg") %></div>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-error">&#9888; <%= request.getParameter("error") %></div>
        <% } %>

        <div class="two-col">

            <!-- Form -->
            <div class="content-card">
                <h3 style="margin-bottom:20px;font-size:16px;color:var(--navy)">Create New Election</h3>
                <form action="../addElection" method="post">
                    <div class="form-group">
                        <label>Election Name *</label>
                        <input type="text" name="electionName"
                               placeholder="e.g. General Election 2025" required>
                    </div>
                    <div class="form-group">
                        <label>End Date *</label>
                        <input type="date" name="endDate" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block" style="margin-top:8px">
                        &#128197; Create Election
                    </button>
                </form>
            </div>

            <!-- Existing elections list -->
            <div class="table-container">
                <div class="table-header">Existing Elections (<%= elections.size() %>)</div>
                <table>
                    <thead>
                        <tr><th>#</th><th>Name</th><th>End Date</th></tr>
                    </thead>
                    <tbody>
                    <% if (elections.isEmpty()) { %>
                        <tr><td colspan="3" class="no-data">No elections yet.</td></tr>
                    <% } %>
                    <% int i=1; for (Election e : elections) { %>
                        <tr>
                            <td><%= i++ %></td>
                            <td class="text-strong"><%= e.getName() %></td>
                            <td><%= e.getEndDate() %></td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>

</body>
</html>
