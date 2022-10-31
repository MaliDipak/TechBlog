package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.tech.blog.entities.Comment;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

public class CommentDao {

    private Connection con;

    public CommentDao(Connection con) {
        this.con = con;
    }

    public boolean saveComment(Comment cmt) {
        try {
            //user-->database

            String query = "insert into tbl_comment(parent_comment_id, comment, comment_sender_name, userId, postId) values (?,?,?,?,?)";

            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, cmt.getParent_comment_id());
            pstmt.setString(2, cmt.getComment());
            pstmt.setString(3, cmt.getCommenter_name());
            pstmt.setInt(4, cmt.getUserId());
            pstmt.setInt(5, cmt.getPostId());

            pstmt.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void deleteComment(int cid, int pid) {
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
                deleteComment(commentId, pid);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    ///fetch all parent comment of id 0
    public ArrayList<Comment> getAll0Comments(int pid) {
        ArrayList<Comment> list = new ArrayList<>();
        try {
            String q = "SELECT * FROM tbl_comment WHERE parent_comment_id = 0 AND postId = " + pid + " ORDER BY comment_id DESC";
            PreparedStatement st = con.prepareStatement(q);
//            st.setInt(1, pid); 
            ResultSet set = st.executeQuery(q);
            while (set.next()) {
                int comment_id = set.getInt("comment_id");
                int parent_comment_id = set.getInt("parent_comment_id");
                String comment_content = set.getString("comment");
                String comment_name = set.getString("comment_sender_name");
                Timestamp comment_date = set.getTimestamp("date");
                int user_id = set.getInt("userId");
                Comment c = new Comment(comment_id, parent_comment_id, comment_content, comment_name, comment_date, user_id, pid);
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
//   method to return all post in list

    public ArrayList<Comment> getAllCommentByParentId(int parent_id, int pid) {
        ArrayList<Comment> list = new ArrayList<>();
        try {
            String q = "SELECT * FROM tbl_comment WHERE parent_comment_id =" + parent_id + " AND postId = " + pid;
            PreparedStatement p = con.prepareStatement(q);
//            p.setInt(1, parent_id);
//            p.setInt(2, pid);
            ResultSet set = p.executeQuery();
            while (set.next()) {
                int comment_id = set.getInt("comment_id");
                String comment_content = set.getString("comment");
                String comment_name = set.getString("comment_sender_name");
                Timestamp comment_date = set.getTimestamp("date");
                int user_id = set.getInt("userId");
                Comment c = new Comment(comment_id, parent_id, comment_content, comment_name, comment_date, user_id, pid);
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //function to return count like on post
    public int countCommentOnPost(int pid) {
        int count = 0;
        try {
            String q = "select count(*) from tbl_comment where postId=?";
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
}
