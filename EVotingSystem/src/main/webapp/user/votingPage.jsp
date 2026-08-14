<%@ page contentType="text/html;charset=UTF-8"
         import="com.evoting.dao.ElectionDAO,
                 com.evoting.dao.CandidateDAO,
                 com.evoting.dao.VoteDAO,
                 com.evoting.model.Election,
                 com.evoting.model.Candidate,
                 com.evoting.model.Voter,
                 java.util.List" %>
<%
    /* ── Session guard ── */
    if (session.getAttribute("voter") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Voter voter = (Voter) session.getAttribute("voter");

    /* ── Param guard ── */
    String eidStr = request.getParameter("electionId");
    if (eidStr == null || eidStr.isEmpty()) {
        response.sendRedirect("userHome.jsp");
        return;
    }
    int electionId = Integer.parseInt(eidStr);

    /* ── Duplicate-vote guard ── */
    VoteDAO voteDAO = new VoteDAO();
    if (voteDAO.hasVoted(voter.getId(), electionId)) {
        response.sendRedirect("alreadyVoted.jsp");
        return;
    }

    Election         election   = new ElectionDAO().getElectionById(electionId);
    List<Candidate>  candidates = new CandidateDAO().getCandidatesByElection(electionId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cast Vote | E-Voting</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<nav class="navbar">
    <span class="brand">E-<span>Vote</span></span>
    <div class="nav-links">
        <a href="userHome.jsp">&#8592; Back</a>
        <a href="../logout" class="logout">Logout</a>
    </div>
</nav>

<div style="max-width:900px;margin:36px auto;padding:0 20px">

    <div class="page-title">
        &#128499; <%= election != null ? election.getName() : "Election" %>
    </div>

    <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-error">&#9888; <%= request.getParameter("error") %></div>
    <% } %>

    <% if (candidates.isEmpty()) { %>
        <div class="alert alert-info">No candidates have been added to this election yet.</div>
        <a href="userHome.jsp" class="btn btn-ghost mt-2">&#8592; Back to Dashboard</a>
    <% } else { %>

        <p class="text-muted" style="margin-bottom:20px">
            Click a candidate to select, then press <strong>Cast Vote</strong>. You can vote only once — this cannot be undone.
        </p>

        <form action="../vote" method="post" id="voteForm">
            <input type="hidden" name="electionId"   value="<%= electionId %>">
            <input type="hidden" name="candidateId"  id="candidateId" value="">

            <div class="candidate-grid">
                <% for (Candidate c : candidates) {
                    /* Build initials from candidate name */
                    String initials = "";
                    for (String part : c.getName().split("\\s+")) {
                        if (!part.isEmpty()) initials += part.charAt(0);
                    }
                    if (initials.length() > 2) initials = initials.substring(0, 2);
                %>
                <div class="candidate-card"
                     id="card-<%= c.getId() %>"
                     onclick="selectCandidate(<%= c.getId() %>)">

                    <% if (c.getLogoPath() != null &&
                           !c.getLogoPath().equals("default-logo.png") &&
                           !c.getLogoPath().isEmpty()) { %>
                        <img src="../<%= c.getLogoPath() %>" alt="logo" class="c-logo">
                    <% } else { %>
                        <div class="c-initials"><%= initials.toUpperCase() %></div>
                    <% } %>

                    <h4><%= c.getName() %></h4>
                    <div class="party"><%= c.getPartyName() %></div>
                    <% if (c.getAddress() != null && !c.getAddress().isEmpty()) { %>
                        <div class="caddr"><%= c.getAddress() %></div>
                    <% } %>
                </div>
                <% } %>
            </div>

            <div style="margin-top:28px;display:flex;gap:12px;align-items:center">
                <button type="button"
                        onclick="submitVote()"
                        class="btn btn-primary"
                        style="padding:12px 36px;font-size:15px">
                    &#128499; Cast Vote
                </button>
                <a href="userHome.jsp" class="btn btn-ghost">Cancel</a>
                <span id="select-hint" class="text-muted" style="font-size:13px">
                    No candidate selected yet.
                </span>
            </div>
        </form>
    <% } %>
</div>

<script>
    var selectedId = null;

    function selectCandidate(cid) {
        // Deselect all
        document.querySelectorAll('.candidate-card').forEach(function(el) {
            el.classList.remove('selected');
        });
        // Select clicked
        document.getElementById('card-' + cid).classList.add('selected');
        document.getElementById('candidateId').value = cid;
        selectedId = cid;
        document.getElementById('select-hint').textContent = 'Candidate selected. Click Cast Vote to confirm.';
    }

    function submitVote() {
        if (!selectedId) {
            alert('Please select a candidate before voting.');
            return;
        }
        if (confirm('Confirm your vote? This cannot be changed after submission.')) {
            document.getElementById('voteForm').submit();
        }
    }
</script>

</body>
</html>
