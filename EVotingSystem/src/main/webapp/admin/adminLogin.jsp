<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | E-Voting</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<nav class="navbar">
    <span class="brand">E-<span>Vote</span></span>
    <div class="nav-links">
        <a href="../index.jsp">Home</a>
    </div>
</nav>

<div class="form-page">
    <div class="form-card">
        <h2>Admin Login</h2>
        <p class="subtitle">Restricted access for authorised election administrators only.</p>

        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-error">&#10060; <%= request.getParameter("error") %></div>
        <% } %>

        <form action="../adminLogin" method="post">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="admin" required autofocus>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block" style="margin-top:4px">
                Sign In as Admin
            </button>
        </form>

        <p class="link-hint mt-2"><a href="../index.jsp">&#8592; Return to Home</a></p>
    </div>
</div>

</body>
</html>
