# E-Voting System
**Java Servlets + JSP + MySQL + Apache Tomcat**

---

## Project Structure

```
EVotingSystem/
├── evoting_db.sql                         ← Run this first in MySQL
├── pom.xml                                ← Maven build file
└── src/main/
    ├── java/com/evoting/
    │   ├── util/
    │   │   └── DBConnection.java          ← MySQL connection helper
    │   ├── model/
    │   │   ├── Voter.java
    │   │   ├── Election.java
    │   │   ├── Candidate.java
    │   │   └── Vote.java
    │   ├── dao/
    │   │   ├── VoterDAO.java              ← All voter DB operations
    │   │   ├── ElectionDAO.java           ← Election DB operations
    │   │   ├── CandidateDAO.java          ← Candidate DB operations
    │   │   └── VoteDAO.java               ← Vote cast + duplicate check
    │   └── servlet/
    │       ├── RegisterServlet.java       ← POST /register
    │       ├── UserLoginServlet.java      ← POST /userLogin
    │       ├── AdminLoginServlet.java     ← POST /adminLogin
    │       ├── ApproveVoterServlet.java   ← GET  /approveVoter
    │       ├── AddElectionServlet.java    ← POST /addElection
    │       ├── AddCandidateServlet.java   ← POST /addCandidate (multipart)
    │       ├── VoteServlet.java           ← POST /vote
    │       └── LogoutServlet.java         ← GET  /logout
    └── webapp/
        ├── index.jsp                      ← Welcome / home page
        ├── register.jsp                   ← Voter registration form
        ├── register_success.jsp           ← Registration confirmation
        ├── error404.jsp
        ├── error500.jsp
        ├── css/
        │   └── style.css                  ← Single stylesheet
        ├── uploads/                       ← Candidate logos saved here
        ├── WEB-INF/
        │   └── web.xml
        ├── admin/
        │   ├── adminLogin.jsp
        │   ├── adminHome.jsp              ← Admin dashboard
        │   ├── sidebar.jsp                ← Reusable sidebar include
        │   ├── viewVoters.jsp             ← Approve / reject voters
        │   ├── addElection.jsp
        │   ├── addCandidate.jsp
        │   └── viewResults.jsp            ← Live vote counts
        └── user/
            ├── login.jsp
            ├── userHome.jsp               ← Elections list
            ├── votingPage.jsp             ← Candidate selection
            ├── voteSuccess.jsp
            └── alreadyVoted.jsp
```

---

## Setup Instructions

### 1. Import into Eclipse

1. Open Eclipse → **File → Import → Existing Maven Projects**
2. Browse to the `EVotingSystem` folder → Finish
3. Eclipse will download all dependencies via Maven automatically

### 2. Set Up MySQL Database

Open MySQL Workbench (or any MySQL client) and run:

```sql
source /path/to/EVotingSystem/evoting_db.sql
```

Or via command line:
```bash
mysql -u root -p < evoting_db.sql
```

This creates:
- Database: `evoting_db`
- Tables: `admin`, `voters`, `elections`, `candidates`, `votes`
- Default admin: **username:** `admin` | **password:** `admin123`
- Sample elections and candidates

### 3. Configure Database Connection

Edit `src/main/java/com/evoting/util/DBConnection.java`:

```java
private static final String URL      = "jdbc:mysql://localhost:3306/evoting_db?useSSL=false&serverTimezone=UTC";
private static final String USERNAME = "root";
private static final String PASSWORD = "your_mysql_password";  // ← change this
```

### 4. Configure Tomcat in Eclipse

1. Window → Show View → Servers
2. Right-click Servers panel → New → Server → Apache Tomcat v9.0
3. Point to your Tomcat installation directory
4. Add the `EVotingSystem` project to the server
5. Click **Start**

### 5. Access the Application

```
http://localhost:8080/EVotingSystem/
```

---

## Default Credentials

| Role  | Field    | Value      |
|-------|----------|------------|
| Admin | Username | `admin`    |
| Admin | Password | `admin123` |

*(Voter accounts are created via the registration form)*

---

## User Flows

### Voter Flow
```
Register → (Wait for Admin Approval) → Login → Select Election → Vote → "Vote Submitted Successfully"
```

If voter tries to vote again:
```
Login → Dashboard → Election (shows "Voted" badge) → Cannot click
```

### Admin Flow
```
Login → Dashboard → View Voters → Approve/Reject
                  → Add Election (name + end date)
                  → Add Candidate (select election, details, logo)
                  → View Results (live vote bars + table)
```

---

## Database Tables

### `voters`
| Column   | Type         | Notes                          |
|----------|--------------|--------------------------------|
| id       | INT PK AI    |                                |
| name     | VARCHAR(100) |                                |
| dob      | DATE         |                                |
| email    | VARCHAR(100) | UNIQUE                         |
| gender   | VARCHAR(10)  |                                |
| phone    | VARCHAR(15)  |                                |
| address  | VARCHAR(255) |                                |
| password | VARCHAR(100) |                                |
| status   | ENUM         | `pending` / `approved` / `rejected` |

### `admin`
| Column   | Type        |
|----------|-------------|
| id       | INT PK AI   |
| username | VARCHAR(50) |
| password | VARCHAR(100)|

### `elections`
| Column   | Type         |
|----------|--------------|
| id       | INT PK AI    |
| name     | VARCHAR(150) |
| end_date | DATE         |

### `candidates`
| Column      | Type         | Notes                         |
|-------------|--------------|-------------------------------|
| id          | INT PK AI    |                               |
| election_id | INT FK       | → elections(id)               |
| name        | VARCHAR(100) |                               |
| party_name  | VARCHAR(100) |                               |
| address     | VARCHAR(255) |                               |
| phone       | VARCHAR(15)  |                               |
| logo_path   | VARCHAR(255) | Relative path to uploads/     |

### `votes`
| Column       | Type | Notes                                        |
|--------------|------|----------------------------------------------|
| id           | INT PK AI |                                         |
| voter_id     | INT FK    | → voters(id)                            |
| election_id  | INT FK    | → elections(id)                         |
| candidate_id | INT FK    | → candidates(id)                        |
| voted_at     | TIMESTAMP |                                         |
| **UNIQUE**   |           | **(voter_id, election_id)** ← prevents duplicate votes |

---

## Servlet URL Mappings

| URL             | Servlet              | Method |
|-----------------|----------------------|--------|
| `/register`     | RegisterServlet      | POST   |
| `/userLogin`    | UserLoginServlet     | POST   |
| `/adminLogin`   | AdminLoginServlet    | POST   |
| `/approveVoter` | ApproveVoterServlet  | GET    |
| `/addElection`  | AddElectionServlet   | POST   |
| `/addCandidate` | AddCandidateServlet  | POST   |
| `/vote`         | VoteServlet          | POST   |
| `/logout`       | LogoutServlet        | GET    |

---

## Key Security Points

- **Session guard** on every protected page — redirects to login if no session
- **Duplicate vote prevention** at two levels:
  - Application: `VoteDAO.hasVoted()` checked before insert
  - Database: `UNIQUE KEY (voter_id, election_id)` on `votes` table
- **Only `approved` voters** can reach the voting page
- **Admin session** separate from voter session (`adminUser` vs `voter` attribute)
- **File upload** limited to 5 MB per logo, saved to `uploads/` folder
