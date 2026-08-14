<%@ page contentType="text/html;charset=UTF-8"
         import="com.evoting.dao.VoterDAO,
                 com.evoting.model.Voter,
                 java.util.List" %>
<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("adminLogin.jsp"); return;
    }
    request.setAttribute("currentPage", "voters");
    List<Voter> voters = new VoterDAO().getAllVoters();
    long approved = voters.stream().filter(v -> "approved".equals(v.getStatus())).count();
    long pending  = voters.stream().filter(v -> "pending".equals(v.getStatus())).count();
    long rejected = voters.stream().filter(v -> "rejected".equals(v.getStatus())).count();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Voters | E-Voting</title>
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
        <div class="page-title">&#128101; Registered Voters</div>

        <% if (request.getParameter("msg") != null) { %>
            <div class="alert alert-success">&#10003; <%= request.getParameter("msg") %></div>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-error">&#9888; <%= request.getParameter("error") %></div>
        <% } %>

        <!-- Stats -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="sc-num"><%= voters.size() %></div>
                <div class="sc-lbl">Total Registered</div>
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
                <div class="sc-num"><%= rejected %></div>
                <div class="sc-lbl">Rejected</div>
            </div>
        </div>

        <!-- Table -->
        <div class="table-container">
            <div class="table-header">All Registered Voters (<%= voters.size() %>)</div>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Gender</th>
                        <th>DOB</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <% if (voters.isEmpty()) { %>
                    <tr><td colspan="8" class="no-data">No voters registered yet.</td></tr>
                <% } %>
                <% int i = 1; for (Voter v : voters) { %>
                    <tr>
                        <td><%= i++ %></td>
                        <td class="text-strong"><%= v.getName() %></td>
                        <td><%= v.getEmail() %></td>
                        <td><%= v.getPhone() %></td>
                        <td><%= v.getGender() %></td>
                        <td><%= v.getDob() %></td>
                        <td>
                            <span class="badge badge-<%= v.getStatus() %>">
                                <%= v.getStatus().substring(0,1).toUpperCase()
                                  + v.getStatus().substring(1) %>
                            </span>
                        </td>
                        <td>
                            <% if ("pending".equals(v.getStatus())) { %>
                                <a href="../approveVoter?action=approve&id=<%= v.getId() %>"
                                   class="btn btn-success btn-sm"
                                   onclick="return confirm('Approve <%= v.getName() %>?')">
                                   Approve
                                </a>
                                <a href="../approveVoter?action=reject&id=<%= v.getId() %>"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Reject <%= v.getName() %>?')"
                                   style="margin-left:4px">
                                   Reject
                                </a>
                            <% } else { %>
                                <span class="text-muted">—</span>
                            <% } %>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>
