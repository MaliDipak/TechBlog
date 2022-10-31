<%-- 
    Document   : load_posts_homepage2
    Created on : 10 Aug, 2022, 6:56:27 PM
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
    <%//this is for like and user connection is he/she like it or not......
        LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
        User user = (User) session.getAttribute("currentUser");
        CommentDao cdao = new CommentDao(ConnectionProvider.getConnection());

//        Thread.sleep(600);//this is for show the loading posts process...
        PostDao d = new PostDao(ConnectionProvider.getConnection());

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
            //below is for like system....
            boolean result = ldao.isUserLikePost(p.getpId(), user.getId());
            String likeType = "fa fa-thumbs-o-up";
            if (result == true) {
                likeType = "fa fa-thumbs-up";
            }
            //.....

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
                <a href="#!" onclick="doLike(<%= p.getpId()%>, <%= user.getId()%>)" class="btn btn-outline-light btn-sm">  <i id="postId_<%= p.getpId()%>" class="<%= likeType%>">  </i>  <span class="likeCounter_<%= p.getpId()%>">  <%= ldao.countLikeOnPost(p.getpId())%> </span> </a>
                <a href="show_blog_page.jsp?post_id=<%= p.getpId()%>" class="btn btn-outline-light btn-sm">  <i class="fa fa-commenting-o">  </i>  <span>   <%= cdao.countCommentOnPost(p.getpId())%> </span> </a>
            </div>
        </div>
    </div>

    <%        }
    %>
</div>
