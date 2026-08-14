<%-- ============================================================
     Reusable Admin Sidebar  –  included by all admin pages.
     The including page must set String currentPage before including.
     e.g.  <% String currentPage = "voters"; %>
     ============================================================ --%>
<%
    String _cp = (String) request.getAttribute("currentPage");
    if (_cp == null) _cp = "";
%>
<div class="sidebar">
    <div class="sidebar-title">Navigation</div>
    <a href="adminHome.jsp"     class="<%= _cp.equals("home")      ? "active" : "" %>">
        <span class="sicon">&#127968;</span>Dashboard
    </a>
    <a href="addElection.jsp"   class="<%= _cp.equals("election")  ? "active" : "" %>">
        <span class="sicon">&#128197;</span>Add Election
    </a>
    <a href="addCandidate.jsp"  class="<%= _cp.equals("candidate") ? "active" : "" %>">
        <span class="sicon">&#128100;</span>Add Candidate
    </a>
    <a href="viewVoters.jsp"    class="<%= _cp.equals("voters")    ? "active" : "" %>">
        <span class="sicon">&#128101;</span>View Voters
    </a>
    <a href="viewResults.jsp"   class="<%= _cp.equals("results")   ? "active" : "" %>">
        <span class="sicon">&#128202;</span>View Results
    </a>
    <a href="../logout" style="margin-top:auto">
        <span class="sicon">&#128275;</span>Logout
    </a>
</div>
