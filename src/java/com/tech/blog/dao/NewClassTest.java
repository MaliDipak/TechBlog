package com.tech.blog.dao;

import com.tech.blog.helper.ConnectionProvider;

import java.sql.*;

public class NewClassTest {

    static Connection con = ConnectionProvider.getConnection();

    public static void main(String[] args) {

        System.out.println("hiiii");

        int pid = 235, cid = 185;

        NewClassTest t = new NewClassTest();
        t.fun(pid, cid);
    }

    public void fun(int pid, int cid) {
        System.out.println("we are in fun");

        try {
            String query1 = "delete from tbl_comment where postId=? and comment_id=?";
            PreparedStatement pstmt1 = con.prepareStatement(query1);
            pstmt1.setInt(1, pid);
            pstmt1.setInt(2, cid);
            pstmt1.executeUpdate();

            String query2 = "select comment_id from tbl_comment where postid=? and parent_comment_id=?";
            PreparedStatement pstmt2 = con.prepareStatement(query2);
            pstmt2.setInt(1, pid);
            pstmt2.setInt(2, cid);
            ResultSet set = pstmt2.executeQuery();

            while (set.next()) {
                int commentId = set.getInt("comment_id");
                fun(pid, commentId);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
