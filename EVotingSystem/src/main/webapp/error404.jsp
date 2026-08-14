<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Page Not Found | E-Voting</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav class="navbar">
    <span class="brand">E-<span>Vote</span></span>
    <div class="nav-links"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></div>
</nav>
<div class="status-page">
    <div class="status-icon warn" style="font-size:40px">404</div>
    <h2>Page Not Found</h2>
    <p>The page you're looking for doesn't exist or has been moved.</p>
    <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">Go to Home</a>
</div>
</body>
</html>
