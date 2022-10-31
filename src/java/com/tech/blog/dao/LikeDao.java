package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {

    Connection con;

    //constructor....
    public LikeDao(Connection con) {
        this.con = con;
    }

    //function which insert likes...
    public boolean insertLike(int pid, int uid) {
        try {
            String q = "insert into postLikes(uid, pid) values(?,?)";
            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1, uid);
            p.setInt(2, pid);
            p.execute();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //function to return count like on post
    public int countLikeOnPost(int pid) {
        int count = 0;
        try {
            String q = "select count(*) from postLikes where pid=?";
            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1, pid);
            ResultSet s = p.executeQuery();
            if (s.next()) {
                count = s.getInt("count(*)");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    //function is user like a post or not 
    public boolean isUserLikePost(int pid, int uid) {
        try {
            String q = "select * from postLikes where pid=? and uid=?";
            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1, pid);
            p.setInt(2, uid);
            ResultSet s = p.executeQuery();
            if (s.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //function for dislike post
    public boolean disLike(int pid, int uid) {
        try {
            String q = "delete from postLikes where uid=? and pid=?";
            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1, uid);
            p.setInt(2, pid);
            p.execute();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
