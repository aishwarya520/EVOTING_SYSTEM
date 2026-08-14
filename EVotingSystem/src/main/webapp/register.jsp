<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | E-Voting</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar">
    <span class="brand">E-<span>Vote</span></span>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="user/login.jsp">Login</a>
    </div>
</nav>

<div class="form-page">
    <div class="form-card">
        <h2>Voter Registration</h2>
        <p class="subtitle">Create your account. An admin will review and approve your registration before you can vote.</p>

        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-error">&#9888; <%= request.getParameter("error") %></div>
        <% } %>

        <form action="register" method="post">

            <div class="form-row">
                <div class="form-group">
                    <label>Full Name *</label>
                    <input type="text" name="name" placeholder="John Doe" required autofocus>
                </div>
                <div class="form-group">
                    <label>Date of Birth *</label>
                    <input type="date" name="dob" required>
                </div>
            </div>

            <div class="form-group">
                <label>Email Address *</label>
                <input type="email" name="email" placeholder="you@example.com" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Gender *</label>
                    <select name="gender" required>
                        <option value="">Select gender</option>
                        <option>Male</option>
                        <option>Female</option>
                        <option>Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Phone Number *</label>
                    <input type="tel" name="phone" placeholder="+91 9XXXXXXXXX" required>
                </div>
            </div>

            <div class="form-group">
                <label>Address *</label>
                <input type="text" name="address" placeholder="Street, City, State" required>
            </div>

            <div class="form-group">
                <label>Password *</label>
                <input type="password" name="password" placeholder="Minimum 6 characters" minlength="6" required>
            </div>

            <button type="submit" class="btn btn-primary btn-block" style="margin-top:4px">
                Create Account
            </button>
        </form>

        <p class="link-hint">Already registered? <a href="user/login.jsp">Sign in here</a></p>
    </div>
</div>

</body>
</html>
