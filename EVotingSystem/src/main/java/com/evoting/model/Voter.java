package com.evoting.model;

import java.io.Serializable;

/** Maps to the `voters` table. */
public class Voter implements Serializable {

    private static final long serialVersionUID = 1L;

    private int    id;
    private String name;
    private String dob;
    private String email;
    private String gender;
    private String phone;
    private String address;
    private String password;
    private String status;   // "pending" | "approved" | "rejected"

    /* ── Constructors ─────────────────────────────────────── */
    public Voter() {}

    public Voter(int id, String name, String dob, String email,
                 String gender, String phone, String address,
                 String password, String status) {
        this.id = id; this.name = name; this.dob = dob;
        this.email = email; this.gender = gender; this.phone = phone;
        this.address = address; this.password = password; this.status = status;
    }

    /* ── Getters ──────────────────────────────────────────── */
    public int    getId()       { return id; }
    public String getName()     { return name; }
    public String getDob()      { return dob; }
    public String getEmail()    { return email; }
    public String getGender()   { return gender; }
    public String getPhone()    { return phone; }
    public String getAddress()  { return address; }
    public String getPassword() { return password; }
    public String getStatus()   { return status; }

    /* ── Setters ──────────────────────────────────────────── */
    public void setId(int id)            { this.id       = id; }
    public void setName(String v)        { this.name     = v; }
    public void setDob(String v)         { this.dob      = v; }
    public void setEmail(String v)       { this.email    = v; }
    public void setGender(String v)      { this.gender   = v; }
    public void setPhone(String v)       { this.phone    = v; }
    public void setAddress(String v)     { this.address  = v; }
    public void setPassword(String v)    { this.password = v; }
    public void setStatus(String v)      { this.status   = v; }
}
