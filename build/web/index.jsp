<%-- 
    Document   : index
    Created on : 19 Jul, 2022, 4:28:36 PM
    Author     : Dipak Chandrakant Mali
--%>

<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <!--css-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>


        <style>
            #newclip{
                clip-path: polygon(0 0, 100% 2%, 100% 92%, 70% 100%, 31% 95%, 0 100%);
            }
        </style>

        <script src = "/scripts/jquery.min.js"></script>
        <script src = "/bootstrap/js/bootstrap.min.js"></script>

    </head>
    <body>


        <!--navbar-->
        <%@include file="normal_navbar.jsp" %>


        <!--banner-->

        <div class="container-fluid p-0 m-0" id="newclip">
            <div class="jumbotron primary-background text-white"> 
                <div class="container">
                    <h3 class="display-3">Technical._.Blog</h3>
                    <p>Programming is an intriguing sector as it gives us the superpower to regulate computer programs on the go. It can be used for ships, traffic control, robotics, self-driving vehicles, smartphone applications, websites, and many other things.</p>
                    <p>To ensure that you remain up to date on standards and protocols, and even more so in the field of coding, it is important to track developments in your field. Programmers of all specialties can easily benefit from keeping track of the new developments & following industry-leading blogs and websites.</p>
                    <p>These Tech._.Blog have made a name for themselves in the programming world by posting important, high-quality data and tips for coders. You can learn tricks and shortcuts you would never have dreamed of doing otherwise by following programming blogs.</p>
                    <a href="register_page.jsp" class="btn btn-outline-light btn-lg"> <span class="fa fa-user-plus"></span> Start ! it's Free </a>
                    <a href="login_page.jsp" class="btn btn-outline-light btn-lg"> <span class="fa fa-user-circle-o fa-spin"></span> Login </a>

                </div>   
            </div>
        </div>   

        <!--cards-->
        <!--main page body-->
        <main>
            <div class="container">
                <div class="row mt-4">
                    <!--first col-->
                    <div class="col-md-4">
                        <!--categories-->

                        <div class="list-group">
                            <a href="#" onclick="getPosts(0, this)" class="c-link list-group-item list-group-item-action flex-column align-items-start active">
                                <div class="d-flex w-100 justify-content-between">
                                    <h5 class="mb-1">All Posts</h5>
                                </div>
                            </a>
                            <%
                                PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list = postd.getAllCategories();
                                for (Category c : list) {
                            %>
                            <a href="#" onclick="getPosts(<%= c.getCid()%>, this)" class="c-link list-group-item list-group-item-action flex-column align-items-start">
                                <div class="d-flex w-100 justify-content-between">
                                    <h5 class="mb-1"><%= c.getName()%></h5>
                                </div>
                                <p class="mb-1"><%= c.getDescription()%></p>
                            </a>

                            <%
                                }
                            %>
                        </div>

                    </div>
                    <!--second col-->
                    <div class="col-md-8">
                        <!--post-->
                        <div class="container text-center" id="loader">
                            <i class="fa fa-refresh fa-4x fa-spin"></i>
                            <h3 class="mt-2">Loading...</h3>
                        </div>

                        <div class="container-fluid" id="post-container">

                        </div>

                    </div>
                </div>
            </div>
        </main>
        <!--end of main page body-->


        <!--javaScript-->

        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script src="js/myscript.js" type="text/javascript"></script>

        <!--loading post using ajax-->
        <%
            User user = (User) session.getAttribute("currentUser");
            String loadingPosts = "load_posts_homepage.jsp";
            if (user != null) {
                loadingPosts = "load_posts_homepage2.jsp"; //this page contain posts with user.........after user login
            }
        %>
        <script>
                                function getPosts(catid, temp) {
                                    $("#loader").show();
                                    $("#post-container").hide();

                                    $(".c-link").removeClass('active primary-background');

                                    $.ajax({
                                        url: "<%= loadingPosts%>",
                                        data: {cid: catid},
                                        success: function (data, textStatus, jqXHR) {

                                            $("#loader").hide();
                                            $("#post-container").show();

                                            $("#post-container").html(data);

                                            $(temp).addClass('active primary-background');
                                        }
                                    });
                                }
                                $(document).ready(function (e) {
                                    let allPostRef = $('.c-link')[0];
                                    getPosts(0, allPostRef);
                                });
        </script>
        <script>
            //seriously is not goot practice but I don't any soulution yet so I use this jugaad for balance situation
            window.addEventListener("pageshow", function (event) {
                var historyTraversal = event.persisted || (typeof window.performance != "undefined" && window.performance.navigation.type === 2);
                if (historyTraversal) {
                    // Handle page restore.
                    //alert('refresh');
                    window.location.reload();
                }
            });
        </script>
    </body>
</html>
