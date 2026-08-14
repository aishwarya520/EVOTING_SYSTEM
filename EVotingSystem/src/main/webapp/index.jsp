<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Voting System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar">
    <span class="brand">E-<span>Vote</span></span>
    <div class="nav-links">
        <a href="index.jsp" class="active">Home</a>
        <a href="user/login.jsp">User</a>
        <a href="admin/adminLogin.jsp">Admin</a>
    </div>
</nav>

<div class="hero">
    <h1>E-<span>Voting</span> System</h1>
    <p>A secure and transparent digital platform for conducting elections with full administrative oversight and verified voter participation.</p>
    <div class="hero-btns">
        <a href="register.jsp"          class="btn btn-primary">Register to Vote</a>
        <a href="user/login.jsp"        class="btn btn-outline">Voter Login</a>
        <a href="admin/adminLogin.jsp"  class="btn btn-outline">Admin Login</a>
    </div>
</div>

<div class="features">
    <div class="feature-card">
        <div class="fc-icon" style="background:#eef3fd;color:#2d5be3">&#128274;</div>
        <h3>Secure &amp; Trusted</h3>
        <p>Every vote is protected at both application and database levels, preventing any duplicate submissions.</p>
    </div>
    <div class="feature-card">
        <div class="fc-icon" style="background:#e6f7ef;color:#0f7a4a">&#9989;</div>
        <h3>Admin Oversight</h3>
        <p>Administrators approve voters, manage elections, add candidates, and monitor live results.</p>
    </div>
    <div class="feature-card">
        <div class="fc-icon" style="background:#fff8e6;color:#946200">&#128202;</div>
        <h3>Live Results</h3>
        <p>Real-time vote tallies and candidate rankings are available to admins at any moment.</p>
    </div>
</div>

</body>
</html>
