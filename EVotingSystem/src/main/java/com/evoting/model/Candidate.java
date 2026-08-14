package com.evoting.model;

import java.io.Serializable;

/** Maps to the `candidates` table. */
public class Candidate implements Serializable {

    private static final long serialVersionUID = 1L;

    private int    id;
    private int    electionId;
    private String name;
    private String partyName;
    private String address;
    private String phone;
    private String logoPath;
    private int    voteCount;   // populated by result queries only

    public Candidate() {}

    /* ── Getters ──────────────────────────────────────────── */
    public int    getId()          { return id; }
    public int    getElectionId()  { return electionId; }
    public String getName()        { return name; }
    public String getPartyName()   { return partyName; }
    public String getAddress()     { return address; }
    public String getPhone()       { return phone; }
    public String getLogoPath()    { return logoPath; }
    public int    getVoteCount()   { return voteCount; }

    /* ── Setters ──────────────────────────────────────────── */
    public void setId(int v)           { this.id         = v; }
    public void setElectionId(int v)   { this.electionId = v; }
    public void setName(String v)      { this.name       = v; }
    public void setPartyName(String v) { this.partyName  = v; }
    public void setAddress(String v)   { this.address    = v; }
    public void setPhone(String v)     { this.phone      = v; }
    public void setLogoPath(String v)  { this.logoPath   = v; }
    public void setVoteCount(int v)    { this.voteCount  = v; }
}
