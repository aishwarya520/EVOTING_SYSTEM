package com.evoting.model;

import java.io.Serializable;

/** Maps to the `elections` table. */
public class Election implements Serializable {

    private static final long serialVersionUID = 1L;

    private int    id;
    private String name;
    private String endDate;

    public Election() {}

    public Election(int id, String name, String endDate) {
        this.id = id; this.name = name; this.endDate = endDate;
    }

    public int    getId()      { return id; }
    public String getName()    { return name; }
    public String getEndDate() { return endDate; }

    public void setId(int id)           { this.id      = id; }
    public void setName(String v)       { this.name    = v; }
    public void setEndDate(String v)    { this.endDate = v; }
}
