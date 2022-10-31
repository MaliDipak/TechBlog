package com.tech.blog.helper;

import java.sql.*;

public class ConnectionProvider {

    private static Connection con;  //con is a static variable by default it consist NULL value

    public static Connection getConnection() {

        try {
            if (con == null) {
                //driver class load
                Class.forName("com.mysql.jdbc.Driver");

                //create a connection..
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog", "root", "");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}
