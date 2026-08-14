<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("voter") == null) {
        response.sendRedirect("login.jsp"); return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Vote Submitted | E-Voting</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<nav class="navbar">
    <span class="brand">E-<span>Vote</span></span>
    <div class="nav-links">
        <a href="userHome.jsp">Dashboard</a>
        <a href="../logout" class="logout">Logout</a>
    </div>
</nav>

<div class="status-page">
    <div class="status-icon ok">&#10003;</div>
    <h2>Vote Submitted Successfully!</h2>
    <p>Your vote has been securely recorded. Thank you for participating in the election.</p>
    <a href="userHome.jsp" class="btn btn-primary">Back to Dashboard</a>
</div>

</body>
</html>
