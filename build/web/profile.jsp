<%-- 
    Document   : profile
    Created on : 24 Jul, 2022, 12:22:35 PM
    Author     : Dipak Chandrakant Mali
--%>

<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import ="com.tech.blog.entities.User" %>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <!--css-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>

        <!--user icon link-->
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
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

        <%//script let tag
            Message m = (Message) session.getAttribute("msg");
            if (m != null) {
        %>

        <div class="alert <%= m.getCssClass()%>" role="alert">
            <%= m.getContent()%><!<!-- expression tag -->
        </div>

        <%
                session.removeAttribute("msg"); //refress karne par bar bar msg na dikhe isliye ham use session se remove kar rahe he
            }
        %>

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

                        <div class="container-fluid text-center" id="post-container">

                        </div>

                    </div>
                </div>
            </div>
        </main>
        <!--end of main page body-->


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
                        <h5 class="modal-title" id="exampleModalLabel">Make Post</h5>
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

        <!--javaScript-->

        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script src="js/myscript.js" type="text/javascript"></script>

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

        <!--loading post using ajax-->
        <script>
            function getPosts(catid, temp) {
                $("#loader").show();
                $("#post-container").hide();

                $(".c-link").removeClass('active primary-background');

                $.ajax({
                    url: "load_posts.jsp",
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

        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    </body>
</html>
