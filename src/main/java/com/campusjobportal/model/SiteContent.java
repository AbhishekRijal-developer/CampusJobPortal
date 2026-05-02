package com.campusjobportal.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class SiteContent implements Serializable {
    private static final long serialVersionUID = 1L;

    private int contentId;
    private String pageName;
    private String contentKey;
    private String contentValue;
    private Timestamp updatedDate;

    public SiteContent() {}

    public int getContentId() { return contentId; }
    public void setContentId(int contentId) { this.contentId = contentId; }

    public String getPageName() { return pageName; }
    public void setPageName(String pageName) { this.pageName = pageName; }

    public String getContentKey() { return contentKey; }
    public void setContentKey(String contentKey) { this.contentKey = contentKey; }

    public String getContentValue() { return contentValue; }
    public void setContentValue(String contentValue) { this.contentValue = contentValue; }

    public Timestamp getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(Timestamp updatedDate) { this.updatedDate = updatedDate; }
}
