<%-- 
    Document   : load_posts_homepage
    Created on : 10 Aug, 2022, 6:10:56 PM
    Author     : Dipak Chandrakant Mali
--%>

<%@page import="com.tech.blog.dao.CommentDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<div class="row">
    <%
        LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
        PostDao d = new PostDao(ConnectionProvider.getConnection());
        CommentDao cdao = new CommentDao(ConnectionProvider.getConnection());

        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = null;
        if (cid == 0) {
            posts = d.getAllPosts();
        } else {
            posts = d.getAllPostsByCatId(cid);
        }

        if (posts.size() == 0) {
            out.println("<h3 class='display-3 text-center'>No Posts Yet</h3>");
            return;
        }

        for (Post p : posts) {

//post content
            String content = p.getpContent();
            String firstFewContent;
            if (content.length() > 50) {
                firstFewContent = content.substring(0, 50) + "...";
            } else {
                firstFewContent = content;
            }
    %>

    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="blog_pics/<%= p.getpPic()%>" alt="Card image cap">
            <div class="card-body">
                <h5 class="card-title"><%= p.getpTitle()%></h5>
                <p class="card-text"><%= firstFewContent%></p>
            </div>
            <div class="card-footer primary-background text-center">
                <a href="show_blog_page.jsp?post_id=<%= p.getpId()%>" class="btn btn-outline-light btn-sm"> Read more </a>
                <a href="login_page.jsp" class="btn btn-outline-light btn-sm">  <i class="fa fa-thumbs-o-up">  </i>  <span >  <%= ldao.countLikeOnPost(p.getpId())%> </span> </a>
                <a href="show_blog_page.jsp?post_id=<%= p.getpId()%>" class="btn btn-outline-light btn-sm">  <i class="fa fa-commenting-o">  </i>  <span>  <%= cdao.countCommentOnPost(p.getpId())%> </span> </a>
            </div>
        </div>
    </div>

    <%        }
    %>
</div>

