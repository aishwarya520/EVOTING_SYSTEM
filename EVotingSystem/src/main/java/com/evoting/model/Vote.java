package com.evoting.model;

import java.io.Serializable;

/** Maps to the `votes` table. */
public class Vote implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private int voterId;
    private int electionId;
    private int candidateId;

    public Vote() {}

    public Vote(int id, int voterId, int electionId, int candidateId) {
        this.id = id; this.voterId = voterId;
        this.electionId = electionId; this.candidateId = candidateId;
    }

    public int getId()          { return id; }
    public int getVoterId()     { return voterId; }
    public int getElectionId()  { return electionId; }
    public int getCandidateId() { return candidateId; }

    public void setId(int v)          { this.id          = v; }
    public void setVoterId(int v)     { this.voterId     = v; }
    public void setElectionId(int v)  { this.electionId  = v; }
    public void setCandidateId(int v) { this.candidateId = v; }
}
