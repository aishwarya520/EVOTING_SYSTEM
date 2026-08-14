# E-Voting System — Setup & Run Guide

## Tech Stack
- Java 17 + Servlets + JSP
- MySQL 8.x
- Apache Tomcat 10.x
- Maven (Eclipse Enterprise Edition)

---

## Step 1 – Database Setup
1. Open MySQL Workbench or command line
2. Run the file: `database/evoting_db.sql`
3. Default admin credentials inserted: username=`admin`, password=`admin123`

---

## Step 2 – Eclipse Project Import
1. Open Eclipse Enterprise Edition (with Web Tools Platform)
2. File → Import → Maven → Existing Maven Projects
3. Browse to the `EVotingSystem` folder
4. Click Finish

---

## Step 3 – Configure Database Password
Open: `src/main/java/com/evoting/util/DBConnection.java`
Change `PASSWORD = ""` to your MySQL root password.

---

## Step 4 – Add Tomcat Server
1. Window → Preferences → Server → Runtime Environments → Add
2. Choose Apache Tomcat 10.x, set installation directory
3. Right-click project → Run As → Run on Server → select Tomcat

---

## Step 5 – Run
1. Right-click project → Run As → Run on Server
2. Open browser: `http://localhost:8080/EVotingSystem/`

---

## System Flow

### User Flow
1. Home page → click **User**
2. Register (name, DOB, email, gender, phone, address, password)
3. See "Registration Successful" → go to Login
4. Login → see "Verification Pending" message
5. (After admin approves) Login again → see active elections
6. Click an election → view candidates → cast vote
7. Login again → see "Already Voted" message

### Admin Flow
1. Home page → click **Admin** → login (admin/admin123)
2. **View Voters** → click Approve button for pending voters
3. **Add Election** → fill name + end date → Submit
4. **Add Candidate** → select election, fill details, upload logo → Submit
5. **View Results** → see vote counts with bar chart

---

## Default Credentials
| Role  | Username | Password |
|-------|----------|----------|
| Admin | admin    | admin123 |

---

## Project Structure
```
EVotingSystem/
├── pom.xml
├── database/
│   └── evoting_db.sql
└── src/main/
    ├── java/com/evoting/
    │   ├── util/DBConnection.java
    │   ├── model/Voter.java, Election.java, Candidate.java
    │   ├── dao/VoterDAO.java, ElectionDAO.java, CandidateDAO.java, AdminDAO.java
    │   └── servlet/ (8 servlet classes)
    └── webapp/
        ├── index.jsp (Welcome/Home)
        ├── css/style.css
        ├── WEB-INF/web.xml
        ├── user/
        │   ├── register.jsp, register_success.jsp
        │   ├── login.jsp, userHome.jsp
        │   ├── votingPage.jsp, voteSuccess.jsp, alreadyVoted.jsp
        └── admin/
            ├── adminLogin.jsp, adminHome.jsp
            ├── viewVoters.jsp, addElection.jsp
            ├── addCandidate.jsp, viewResults.jsp
```
