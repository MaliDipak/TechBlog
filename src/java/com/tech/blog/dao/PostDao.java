package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;

public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> list = new ArrayList<>();
        try {
            String q = "select * from categories";
            Statement st = this.con.createStatement();
            ResultSet set = st.executeQuery(q);
            while (set.next()) {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");
                Category c = new Category(cid, name, description);
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //get category name by cat id
    public String getCategories(int cid) {
        try {
            String q = "select name from categories where cid = " + cid;
            Statement st = this.con.createStatement();
            ResultSet set = st.executeQuery(q);
            if (set.next()) {
                String name = set.getString("name");
                return name;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Select category";
    }
//   method to return all post in list

    public ArrayList<Post> getAllPosts() {
        ArrayList<Post> list = new ArrayList<>();
        try {
            PreparedStatement p = con.prepareStatement("select * from post order by pid desc");
            ResultSet s = p.executeQuery();
            while (s.next()) {
                int pid = s.getInt("pid");
                String pTitle = s.getString("pTitle");
                String pContent = s.getString("pContent");
                String pCode = s.getString("pCode");
                String pPic = s.getString("pPic");
                Timestamp pDate = s.getTimestamp("pDate");
                int catId = s.getInt("catId");
                int userId = s.getInt("userId");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);

                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    //method to return all post by cat id

    public ArrayList<Post> getAllPostsByCatId(int catId) {
        ArrayList<Post> list = new ArrayList<>();
        try {
            PreparedStatement p = con.prepareStatement("select * from post where catId = ? order by pid desc");
            p.setInt(1, catId);
            ResultSet s = p.executeQuery();
            while (s.next()) {
                int pid = s.getInt("pid");
                String pTitle = s.getString("pTitle");
                String pContent = s.getString("pContent");
                String pCode = s.getString("pCode");
                String pPic = s.getString("pPic");
                Timestamp pDate = s.getTimestamp("pDate");
                int userId = s.getInt("userId");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);

                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //method to return  post of user by their user id....
    public ArrayList<Post> getAllPostsByUserId(int userId) {
        ArrayList<Post> list = new ArrayList<>();
        try {
            PreparedStatement p = con.prepareStatement("select * from post where userId = ? order by pid desc");
            p.setInt(1, userId);
            ResultSet s = p.executeQuery();
            while (s.next()) {
                int pid = s.getInt("pid");
                String pTitle = s.getString("pTitle");
                String pContent = s.getString("pContent");
                String pCode = s.getString("pCode");
                String pPic = s.getString("pPic");
                Timestamp pDate = s.getTimestamp("pDate");
                int catId = s.getInt("catId");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);

                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //method to return  post of user by their user id and category id....
    public ArrayList<Post> getAllPostsByUserIdCatId(int userId, int catId) {
        ArrayList<Post> list = new ArrayList<>();
        try {
            PreparedStatement p = con.prepareStatement("select * from post where userId = ? and catId = ? order by pid desc");
            p.setInt(1, userId);
            p.setInt(2, catId);
            ResultSet s = p.executeQuery();
            while (s.next()) {
                int pid = s.getInt("pid");
                String pTitle = s.getString("pTitle");
                String pContent = s.getString("pContent");
                String pCode = s.getString("pCode");
                String pPic = s.getString("pPic");
                Timestamp pDate = s.getTimestamp("pDate");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userId);

                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Post getPostsByPostId(int postId) {
        Post post = null;
        try {
            PreparedStatement p = con.prepareStatement("select * from post where pid = ?");
            p.setInt(1, postId);
            ResultSet s = p.executeQuery();
            if (s.next()) {
                String pTitle = s.getString("pTitle");
                String pContent = s.getString("pContent");
                String pCode = s.getString("pCode");
                String pPic = s.getString("pPic");
                Timestamp pDate = s.getTimestamp("pDate");
                int userId = s.getInt("userId");
                int catId = s.getInt("catId");
                post = new Post(postId, pTitle, pContent, pCode, pPic, pDate, catId, userId);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }

//method to save post to database
    public boolean savePost(Post p) {
        boolean f = false;
        try {
            String q = "insert into post(pTitle, pContent, pCode, pPic, catId, userId) values(?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());
            pstmt.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

//method to update post to database
    public boolean updatePost(Post p) {
        boolean f = false;
        try {
            String q = "update post set pTitle=?, pContent=?, pCode=?, pPic=?, catId=? where pid=?";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getpId());
            pstmt.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public int uniquePostIdForPic() {
        try {
            String q = "select max(pid)from post";
            PreparedStatement pstmt = con.prepareStatement(q);
            ResultSet s = pstmt.executeQuery();
            if (s.next()) {
                return (s.getInt("max(pid)"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean renamePicInDb(String pname, int pid) {
        try {
            String q = "update post set ppic = ? where pid = ?";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, pname);
            pstmt.setInt(2, pid);
            pstmt.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //method to delete post to database
    public boolean deletePost(int p) {
        boolean f = false;
        try {
            String q = "delete from post where pid =" + p;
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
