package com.login.visualizationsoftware.model;

import java.util.Date;

public class FileMetadata {
    private int id;
    private String fileName;
    private Date uploadDate;

    public FileMetadata(int id, String fileName, Date uploadDate) {
        this.id = id;
        this.fileName = fileName;
        this.uploadDate = uploadDate;
    }

    public int getId() { return id; }
    public String getFileName() { return fileName; }
    public Date getUploadDate() { return uploadDate; }
}