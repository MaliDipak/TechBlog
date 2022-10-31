package com.tech.blog.entities;

import java.sql.Timestamp;

public class Comment {

    private int comment_id;
    private int parent_comment_id;
    private String comment;
    private String commenter_name;
    private Timestamp comment_date;
    private int userId;
    private int postId;

    public Comment() {
    }

    public Comment(int comment_id, int parent_comment_id, String comment, String commenter_name, Timestamp comment_date, int userId, int postId) {
        this.comment_id = comment_id;
        this.parent_comment_id = parent_comment_id;
        this.comment = comment;
        this.commenter_name = commenter_name;
        this.comment_date = comment_date;
        this.userId = userId;
        this.postId = postId;
    }

    public Comment(int parent_comment_id, String comment, String commenter_name, int userId, int postId) {
        this.parent_comment_id = parent_comment_id;
        this.comment = comment;
        this.commenter_name = commenter_name;
        this.userId = userId;
        this.postId = postId;
    }

    public int getComment_id() {
        return comment_id;
    }

    public void setComment_id(int comment_id) {
        this.comment_id = comment_id;
    }

    public int getParent_comment_id() {
        return parent_comment_id;
    }

    public void setParent_comment_id(int parent_comment_id) {
        this.parent_comment_id = parent_comment_id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getCommenter_name() {
        return commenter_name;
    }

    public void setCommenter_name(String commenter_name) {
        this.commenter_name = commenter_name;
    }

    public Timestamp getComment_date() {
        return comment_date;
    }

    public void setComment_date(Timestamp comment_date) {
        this.comment_date = comment_date;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }
}
