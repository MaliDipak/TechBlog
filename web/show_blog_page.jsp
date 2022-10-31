<%-- 
    Document   : show_blog_page
    Created on : 5 Aug, 2022, 8:28:37 PM
    Author     : Dipak Chandrakant Mali
--%>

<%@page import="com.tech.blog.dao.CommentDao"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>

<%
    int postId = Integer.parseInt(request.getParameter("post_id"));

    PostDao pdao = new PostDao(ConnectionProvider.getConnection());
    Post p = pdao.getPostsByPostId(postId);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TechBlog: <%= p.getpTitle()%></title>
        <!--css-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>

        <!--user icon link-->
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 25px;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            .post-user{
                font-size: 20px;
            }
            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }
            body{
                background: url(img/bg.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>



    </head>
    <body>
        <!--navbar-->

        <nav class="navbar navbar-expand-lg sticky-top navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-book"></span>  Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp"> <span class="fa fa-home"></span> Home </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#contact-modal"> <span class="fa fa-address-book"></span> Contact us </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="profile.jsp"> <span class="fa fa-address-card-o"></span> Profile </a>
                    </li>
                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"> <span class="fa fa-plus"></span> New Post </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"> <span class="fas fa-user-check"></span> <%= user.getName()%> </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"> <span class="fas fa-power-off"></span> LogOut </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!--navbar end-->

        <!--main content of body-->

        <div class="container">
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header primary-background text-white">
                            <h4 class="post-title"><%= p.getpTitle()%></h4>
                        </div>
                        <div class="card-body">
                            <img class="card-img-top my-2" src="blog_pics/<%= p.getpPic()%>" alt="Card image cap">
                            <%
                                UserDao udao = new UserDao(ConnectionProvider.getConnection());
                                //                                User postUser = udao.getUserByUserId(p.getUserId()); try something new here directly put user name below using oops concept
                            %>
                            <div class="row my-3 row-user">
                                <div class="col-md-8">
                                    <p class="post-user"><a href="#!"><%= udao.getUserByUserId(p.getUserId()).getName()%></a> has posted:</p>
                                </div>
                                <div class="col-md-4">
                                    <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                                </div>
                            </div>

                            <p class="post-content"><%= p.getpContent()%></p>
                            <br><!-- comment -->
                            <br><!-- comment -->
                            <div class="post-code">
                                <xmp><%= p.getpCode()%></xmp>
                            </div>
                        </div>

                        <%
                            CommentDao cdao = new CommentDao(ConnectionProvider.getConnection());
                            LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
                            ///like system
                            boolean result = ldao.isUserLikePost(p.getpId(), user.getId());
                            String likeType = "fa fa-thumbs-o-up";
                            if (result == true) {
                                likeType = "fa fa-thumbs-up";
                            }
                            //.....
                        %>

                        <div class="card-footer primary-background text-center"> 
                            <a href="#!" onclick="doLike(<%= p.getpId()%>, <%= user.getId()%>)" class="btn btn-outline-light btn-sm">  <i id="postId_<%= p.getpId()%>" class="<%= likeType%>">  </i>  <span class="likeCounter_<%= p.getpId()%>">  <%= ldao.countLikeOnPost(p.getpId())%> </span> </a>
                            <a href="#!" class="btn btn-outline-light btn-sm" onclick="$('#comment_content').focus()">  <i class="fa fa-commenting-o">  </i>  <span class="count_post_comments">  <%= cdao.countCommentOnPost(p.getpId())%> </span></a>
                            <a href="#!" id="edit_post_btn" class="btn btn-outline-light btn-sm" data-toggle="modal" data-target="#edit-post-modal"><i class="fa fa-edit"></i> Edit </a>
                            <a href="#!" onclick="deletePost()" class="btn btn-outline-light btn-sm" id="delete_post"><i class="fa fa-trash-o"></i> Delete </a>
                        </div>
                        <div class="card-footer">
                            <!--Comments-->
                            <div class="container-fluid" id="post-container">

                                <br />
                                <h4 align="left"><a href="#!" onclick="$('#comment_content').focus()">Add a comment...</a></h4>
                                <br />

                                <div class="container-fluid" id="comments">
                                    <form method="POST" id="comment_form" action="MakeCommentServlet">

                                        <div class="bg-light p-2">
                                            <div class="form-group d-flex flex-row align-items-start">
                                                <img class="rounded-circle" src="pics/<%= user.getProfile()%>" width="40">
                                                <textarea name="comment_content" id="comment_content" class="form-control ml-1 shadow-none textarea"></textarea>
                                            </div>
                                            <div class="mt-2 text-right">
                                                <input type="submit" name="submit" id="submit" class="btn btn-primary btn-sm shadow-none" value="Post comment" />
                                                <button class="btn btn-outline-primary btn-sm ml-1 shadow-none" id="cancel_button" type="button">Cancel</button>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <input type="hidden" name="comment_name" id="comment_name"  value="<%= user.getName()%>" />
                                            <input type="hidden" name="comment_id" id="comment_id" value="0" />
                                            <input type="hidden" name="user_id" value="<%= user.getId()%>" />
                                            <input type="hidden" name="post_id" value="<%= postId%>" />
                                        </div>
                                    </form>
                                    <div class=" text-center" id="loader">
                                        <i class="fa fa-refresh fa-4x fa-spin"></i>
                                        <h3 class="mt-2">Loading...</h3>
                                    </div>
                                    <span id="comment_message">

                                    </span>
                                    <br />
                                    <div id="display_comment">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--end of main content of body-->




        <!--contact modal-->

        <!-- Modal -->
        <div class="modal fade" id="contact-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Contact us</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img class="img-fluid" style="border-radius: 50%; max-width: 150px" alt="Developer: Dipak Mali" src="https://avatars.githubusercontent.com/u/96681905?v=4">
                            <div class="title">
                                <a target="_blank" href="https://malidipak.github.io/portfolio/">Dipak Mali</a>
                            </div>
                            <div class="desc">Passionate coder</div>
                            <div class="desc">Curious developer</div>
                            <div class="desc">Tech geek</div>
                        </div>
                    </div>
                    <div class="modal-footer text-center">
                        <div class="container text-center">
                            <a class="btn btn-primary btn-sm" rel="publisher"
                               href="https://linkedin.com/in/malidipak">
                                <i class="fa fa-linkedin"></i>
                            </a>
                            <a class="btn btn-secondary btn-sm" rel="publisher" href="https://github.com/malidipak">
                                <i class="fa fa-github"></i>
                            </a>
                            <a class="btn btn-danger btn-sm" rel="publisher"
                               href="https://instagram.com/__dipakmali__">
                                <i class="fab fa-instagram"></i>
                            </a>
                            <a class="btn btn-primary btn-twitter btn-sm" href="https://twitter.com/dipakma84471679">
                                <i class="fa fa-twitter"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--end contact modal-->


        <!--profile modal-->

        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel"> TechSoft._.Blog </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">

                            <img src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius: 50%; max-width: 150px">

                            <h5 class="modal-title mt-0" id="exampleModalLabel"> <i><b><%= user.getName()%></b></i> </h5>

                            <!--details-->

                            <div id="profile-detail">
                                <br>
                                <table class="table table-hover">

                                    <tbody>
                                        <tr>
                                            <th scope="row"> USER ID </th>
                                            <td> <%= user.getId()%> </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"> EMAIL </th>
                                            <td> <%= user.getEmail()%> </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"> GENDER </th>
                                            <td> <%= user.getGender()%> </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"> ABOUT </th>
                                            <td> <%= user.getAbout()%> </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"> JOIN DATE </th>
                                            <td> <%= user.getDatetime().toString()%> </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!--end details-->

                            <!--profile edit-->

                            <div id="profile-edit" style="display: none;">
                                <!--<h3 class="mt-2">Edit Mode On</h3>-->
                                <br>
                                <form action="EditServlet" method="post" enctype="multipart/form-data"> 
                                    <table class="table">
                                        <tr>
                                            <th scope="row"> USER ID </th>
                                            <td> <%= user.getId()%> </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"> NAME </th>
                                            <td> <input type="text" name="user_name" value="<%= user.getName()%>" class="form-control"></td>
                                            <td><span class="fas fa-pen"></span> </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"> EMAIL </th>
                                            <td> <input type="email" name="user_email" value="<%= user.getEmail()%>" class="form-control"></td>
                                            <td><span class="fas fa-pen"></span> </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"> PASSWORD </th>
                                            <td> <input type="password" name="user_password" value="<%= user.getPassword()%>" class="form-control"></td>
                                            <td><span class="fas fa-pen"></span> </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"> GENDER </th>
                                            <td> <%= user.getGender().toUpperCase()%> </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"> ABOUT </th>
                                            <td><textarea rows="3" class="form-control" name="user_about"><%= user.getAbout()%> </textarea></td>
                                            <td><span class="fas fa-pen"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"> SELECT NEW PROFILE </th>
                                            <td><input type="file" name="image" class="form-control"></td>
                                            <td><span class="fas fa-pen"></span></td>
                                        </tr>
                                    </table>

                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary">Save</button>
                                    </div>  

                                </form>
                            </div>

                            <!--profile edit end-->

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary"><span class="fas fa-edit"></span> Edit </button>
                        <button onclick="deleteAccount()" type="button" class="btn btn-danger">Delete account</button>
                    </div>
                </div>
            </div>
        </div>

        <!--profile modal end-->

        <!--new post modal-->

        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Make post</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form id="add-post-form" action="AddPostServlet" method="post">

                            <div class="form-group">

                                <select class="form-control" name="cid" required>
                                    <option value="" selected disabled>---Select Category---</option>

                                    <%
                                        PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postd.getAllCategories();
                                        for (Category c : list) {
                                    %>

                                    <option value="<%= c.getCid()%>"><%= c.getName()%></option>

                                    <%
                                        }
                                    %>

                                </select>

                            </div>

                            <div class="form-group">
                                <input id="post_title_input_element" name="pTitle" type="text" placeholder="Enter Post Title" class="form-control" required/>
                            </div>  

                            <div class="form-group">
                                <textarea name="pContent" class="form-control" style="height:200px" placeholder="Make your post here...."></textarea>
                            </div>

                            <div class="form-group">
                                <textarea name="pCode" class="form-control" style="height:200px" placeholder="Enter your program (if any)"></textarea>
                            </div>

                            <div class="form-group">
                                <label> Add image..,</label>
                                <input id="imgload" name="pic" type="file" class="form-control"/>
                            </div>
                            <div class="container text-center"> 
                                <button type="submit" class="btn btn-outline-primary"> Post </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--end of new post modal-->

        <!--edit post modal-->

        <div class="modal fade" id="edit-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Edit post</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form id="edit-post-form" action="EditPostServlet" method="post">

                            <div class="form-group">

                                <select class="form-control" name="cid">
                                    <option selected value="<%= p.getCatId()%>" > <%= pdao.getCategories(p.getCatId())%> </option>

                                    <%
                                        for (Category c : list) {
                                    %>

                                    <option value="<%= c.getCid()%>"><%= c.getName()%></option>

                                    <%
                                        }
                                    %>

                                </select>

                            </div>

                            <div class="form-group">
                                <input id="new_post_title" name="pTitle" type="text" value="<%= p.getpTitle()%>" class="form-control"/>
                            </div>  

                            <div class="form-group">
                                <textarea name="pContent" class="form-control" style="height:200px"><%= p.getpContent()%></textarea>
                            </div>

                            <div class="form-group">
                                <textarea name="pCode" class="form-control" style="height:200px"><%= p.getpCode()%></textarea>
                            </div>

                            <div class="form-group">
                                <label> Add image..,</label>
                                <input id="newimgload" name="pic" type="file" class="form-control"/>
                            </div>

                            <div class="form-group">
                                <input name="pid" type="hidden" value="<%= p.getpId()%>"/>
                                <input name="old_pic_name" type="hidden" value="<%= p.getpPic()%>"/>
                            </div>

                            <div class="container text-center"> 
                                <button type="submit" class="btn btn-outline-primary"> Save changes </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--edit of  post modal-->

        <!--javaScript-->

        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script src="js/myscript.js" type="text/javascript"></script> <!<!-- loading externer javascript -->  

        <!--jquery for new psot modal only for sweet alert-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>





        <!--jquery for edit profile-->
        <script>

                            $(document).ready(function () {
                                let editStatus = false;
                                $('#edit-profile-button').click(function () {
                                    //                    alert("button clicked!")
                                    //                    $("#profile-detail").hide();
                                    //                    $("#profile-edit").show();
                                    if (editStatus === false) {
                                        $("#profile-detail").hide();
                                        $("#profile-edit").show();
                                        editStatus = true;
                                        $(this).text("Back");
                                    } else {
                                        $("#profile-detail").show();
                                        $("#profile-edit").hide();
                                        editStatus = false;
                                        $(this).text("Edit");
                                    }

                                });
                            });
        </script>


        <!--java script for new post-->

        <script>
            var newpi;
            $('document').ready(function () {
                $("#imgload").change(function () {
                    if (this.files && this.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            // $('#imgshow').attr('src', e.target.result);
                            newpi = e.target.result;
                        },
                                reader.readAsDataURL(this.files[0]);
                    }
                });
            });
            $(document).ready(function (e) {
                //                asynchronus request through ajax
                $("#add-post-form").on("submit", function (event) {
                    //this code gets called when form is submitted...
                    event.preventDefault();
                    //                    console.log("you have clicked on submit...");

                    let form = new FormData(this);
                    $.ajax({
                        url: "AddPostServlet",
                        type: "post",
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            //success......
                            console.log(data);
                            if (data.trim() === 'done') {
                                Swal.fire({
                                    title: document.getElementById("post_title_input_element").value,
                                    text: 'Technical._.blog posted successfully!',
                                    imageUrl: newpi,
                                    imageWidth: 400,
                                    imageHeight: 200,
                                    imageAlt: 'Custom image'
                                }).then(function () {
                                    window.location = "profile.jsp";
                                });
                            } else {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Oops...',
                                    text: 'Something went wrong!'
                                });
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //error...
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: 'Something went wrong!'
                            });
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>


        <!--script edit post-->
        <script>

            var newpi;
            $('document').ready(function () {
                $("#newimgload").change(function () {
                    if (this.files && this.files[0]) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            // $('#imgshow').attr('src', e.target.result);
                            newpi = e.target.result;
                        },
                                reader.readAsDataURL(this.files[0]);
                    }
                });
            });
            $(document).ready(function (e) {
                //                asynchronus request through ajax
                $("#edit-post-form").on("submit", function (event) {
                    //this code gets called when form is submitted...
                    event.preventDefault();
                    //                    console.log("you have clicked on submit...");

                    let form = new FormData(this);
                    $.ajax({
                        url: "EditPostServlet",
                        type: "post",
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            //success......
                            console.log(data);
                            if (data.trim() === 'done') {
                                Swal.fire({
                                    title: document.getElementById("new_post_title").value,
                                    text: 'Your changes have been saved.',
                                    imageUrl: newpi,
                                    imageWidth: 400,
                                    imageHeight: 200,
                                    imageAlt: 'Custom image'
                                }).then(function () {
                                    window.location = "profile.jsp";
                                });
                            } else {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Oops...',
                                    text: 'Something went wrong!'
                                });
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //error...
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: 'Something went wrong!'
                            });
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>
        <!--end of edit post-->


        <script>
            //seriously is not goot practice but I don't any soulution yet so I use this jugaad for balance situation
            window.addEventListener("pageshow", function (event) {
                var historyTraversal = event.persisted || (typeof window.performance !== "undefined" && window.performance.navigation.type === 2);
                if (historyTraversal) {
                    // Handle page restore.
                    //alert('refresh');
                    window.location.reload();
                }
            });
        </script>

        <!--script for comments-->
        <script>
            $(document).ready(function () {


                $("#delete_post").hide();
                $("#edit_post_btn").hide();
                if (<%= user.getId()%> === <%= p.getUserId()%>) {
                    $("#delete_post").show();
                    $("#edit_post_btn").show();
                }


                $("#loader").show();
                $("#display_comment").hide();
                load_comment();
                $('#comment_form').on('submit', function (event) {

                    $('#comment_content').attr('placeholder', 'Enter comment');
                    //----
                    //increase comments without refreshing the page
                    let c_count = $('.count_post_comments').html();
                    c_count++;
                    $('.count_post_comments').html(c_count);
                    //----

                    event.preventDefault();
                    var form_data = $(this).serialize();
                    $.ajax({
                        url: "MakeCommentServlet",
                        data: form_data,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            if (data.error !== '') {
                                $('#comment_form')[0].reset();
                                $('#comment_message').html(data.error);
                                $('#comment_id').val('0');
                                load_comment();
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log("error");
                            console.log(data);
                        }
                    });
                });
            });


            function load_comment() {
                $.ajax({
                    url: "FetchCommentsServlet",
                    method: "POST",
                    data: {"pid": "<%= postId%>"},
                    success: function (data) {

                        $('#display_comment').html(data);
                        $("#loader").hide();
                        $("#display_comment").show();

                        $(".delete_span").hide();

                        if (<%= p.getUserId()%> === <%= user.getId()%>) {
                            $(".delete_span").show();
                        }

                        $("#uid<%= user.getId()%>").show();

                    }
                });
            }

            $(document).on('click', '.reply', function () {

                var testxyz = $(this).attr("id");
                const myArray = testxyz.split("_.|._");
                var name = myArray[0];
                var comment_id = myArray[1];
                $('#comment_id').val(comment_id);
                $('#comment_content').attr('placeholder', 'Replay @' + name);
                $('#comment_content').focus();
            });
            $(document).on('click', '#cancel_button', function () {
                $('#comment_content').attr('placeholder', 'Enter comment');
            });


            $(document).on('click', '.delete', function () {

                var testxyz = $(this).attr("id");
                const myArray = testxyz.split("_.|._");

                var comment_id = myArray[1];

                $.ajax({
                    url: "DeleteCommentServlet",
                    data: {"cid": comment_id, "pid":<%= p.getpId()%>},
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        if (data.error !== '') {

                            load_comment();
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("error");
                        console.log(data);
                    }
                });
            });


            $(document).on('click', '#cancel_button', function () {
                $('#comment_content').attr('placeholder', 'Enter comment');
            });


//            all below script for delete post...

            function deletePostByPostId() {
                $.ajax({
                    url: "DeletePostServlet",
                    method: "POST",
                    data: {"pid": "<%= postId%>"},
                    success: function (data) {
                        window.location = "profile.jsp";
                    }, error: function (jqXHR, textStatus, errorThrown) {
                        alert("Something went wrong...");
                    }
                });
            }
            function deletePost() {
                swal({
                    title: "Are you sure?",
                    text: "Once deleted, you will not be able to recover this post!",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                deletePostByPostId();
                            }
                        });
            }

        </script>

        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


        <script>
//            all below script for delete account...

            function deleteUserAccount() {
                $.ajax({
                    url: "DeleteUserAccountServlet",
                    method: "POST",
                    data: {"uid": "<%= user.getId()%>"},
                    success: function (data) {
                        window.location = "login_page.jsp";
                    }, error: function (jqXHR, textStatus, errorThrown) {
                        alert("Something went wrong...");
                    }
                });
            }
            function deleteAccount() {
                swal({
                    title: "Are you sure?",
                    text: "All your data and account will be permanently deleted!",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true
                })
                        .then((willDelete) => {
                            if (willDelete) {
                                deleteUserAccount();
                            }
                        });
            }

        </script>
    </body>
</html>
