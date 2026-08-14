<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Server Error | E-Voting</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav class="navbar">
    <span class="brand">E-<span>Vote</span></span>
    <div class="nav-links"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></div>
</nav>
<div class="status-page">
    <div class="status-icon warn" style="font-size:40px">500</div>
    <h2>Internal Server Error</h2>
    <p>Something went wrong on the server. Please try again or contact the administrator.</p>
    <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">Go to Home</a>
</div>
</body>
</html>
