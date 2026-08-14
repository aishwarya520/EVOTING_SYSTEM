<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Already Voted | E-Voting</title>
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
    <div class="status-icon warn">&#9888;</div>
    <h2>You Have Already Voted</h2>
    <p>Our records show that you have already cast your vote in this election.<br>
       Each voter is permitted to vote only once per election.</p>
    <a href="userHome.jsp" class="btn btn-primary">Back to Dashboard</a>
</div>

</body>
</html>
