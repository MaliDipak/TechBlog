/* 
    Document   : User class
    Created on : 23 Jul, 2022, 1:52:37 AM
    Author     : Dipak Chandrakant Mali
 */
package com.tech.blog.dao;

import com.tech.blog.entities.User;
import java.sql.*;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    // method to insert user to data base:
    public int saveUser(User user) {

        int f = 0;

        try {
            //user-->database

            String query = "insert into user(name,email,password,gender,about) values (?,?,?,?,?)";

            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());

            pstmt.executeUpdate();

            f = 1;

        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) {
                return 3;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;

    }

    //get user by useremail and userpassword
    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;

        try {

            String query = "select * from user where email = ? and password = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            ResultSet set = pstmt.executeQuery();

            if (set.next()) {
                user = new User();
                String name = set.getString("name");
                user.setName(name);  //here we get data from database and set it to our user object

                user.setEmail(set.getString("email"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setId(set.getInt("id"));
                user.setPassword(set.getString("password"));
                user.setDatetime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    //to get user by the their user id
    public User getUserByUserId(int userId) {
        User user = null;

        try {

            String query = "select * from user where id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, userId);

            ResultSet set = pstmt.executeQuery();

            if (set.next()) {
                user = new User();
                String name = set.getString("name");
                user.setName(name);  //here we get data from database and set it to our user object

                user.setEmail(set.getString("email"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setId(set.getInt("id"));
                user.setPassword(set.getString("password"));
                user.setDatetime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    //update user
    public boolean updateUser(User user) {
        boolean f = false;
        try {
            String query = "update user set name=?, email=?, password=?, gender=?, about=?, profile=? where id=?";
            PreparedStatement p = con.prepareStatement(query);
            p.setString(1, user.getName());
            p.setString(2, user.getEmail());
            p.setString(3, user.getPassword());
            p.setString(4, user.getGender());
            p.setString(5, user.getAbout());
            p.setString(6, user.getProfile());
            p.setInt(7, user.getId());

            p.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    //update user
    public boolean deleteUser(int uid) {
        boolean f = false;
        try {
            String query = "delete from user where id=" + uid;
            PreparedStatement p = con.prepareStatement(query);
            p.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
