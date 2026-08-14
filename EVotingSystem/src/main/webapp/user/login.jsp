<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voter Login | E-Voting</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<nav class="navbar">
    <span class="brand">E-<span>Vote</span></span>
    <div class="nav-links">
        <a href="../index.jsp">Home</a>
        <a href="../register.jsp">Register</a>
    </div>
</nav>

<div class="form-page">
    <div class="form-card">
        <h2>Voter Login</h2>
        <p class="subtitle">Sign in with your registered email and password to access the voting portal.</p>

        <%-- Pending approval notice --%>
        <% if ("1".equals(request.getParameter("pending"))) { %>
            <div class="alert alert-warning">
                &#9888; <strong>Your registration is under verification.</strong>
                Please wait for admin approval before logging in.
            </div>
        <% } %>

        <%-- General error / rejected --%>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-error">&#10060; <%= request.getParameter("error") %></div>
        <% } %>

        <%-- Success redirect from registration --%>
        <% if ("1".equals(request.getParameter("registered"))) { %>
            <div class="alert alert-success">
                &#10003; Registration submitted! Await admin approval, then log in.
            </div>
        <% } %>

        <form action="../userLogin" method="post">
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="you@example.com" required autofocus>
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Your password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block" style="margin-top:4px">
                Sign In
            </button>
        </form>

        <p class="link-hint">No account yet? <a href="../register.jsp">Register here</a></p>
    </div>
</div>

</body>
</html>
