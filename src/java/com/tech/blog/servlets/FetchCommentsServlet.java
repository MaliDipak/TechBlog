package com.tech.blog.servlets;

import com.tech.blog.dao.CommentDao;
import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Comment;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.GetComments;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FetchCommentsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            int postId = Integer.parseInt(request.getParameter("pid"));

            CommentDao cdao = new CommentDao(ConnectionProvider.getConnection());

            List<Comment> row = cdao.getAll0Comments(postId);

            String output = "";//main output for comments..

            String newCmt;

            String l1;
            String l2;
            String l3;
            String l4;
            String l5;

            UserDao udao = new UserDao(ConnectionProvider.getConnection());

            for (Comment cmt : row) {
                User u = udao.getUserByUserId(cmt.getUserId());
                l1 = " \n <div class='panel panel-default'>";
                l2 = "<div class='d-flex flex-row user-info'><img class='rounded-circle' src='pics/" + u.getProfile() + "' width='40'><div class='panel-heading'><div class='d-flex flex-column justify-content-start ml-2'><span class='d-block font-weight-bold name'>" + cmt.getCommenter_name() + "</span><span class='date text-black-50'>Shared publicly - " + cmt.getComment_date().toLocaleString().substring(3, 12) + "</span></div></div> </div>";
                l3 = "<br><div class='mt-2'> <p class='comment-text'>" + cmt.getComment() + "</p> </div>";
                l4 = "<div class='like p-2 cursor panel-footer' align='right'> <span class='ml-1'> <button type='button' class='btn btn-outline-primary btn-sm reply' id='" + u.getName() + "_.|._" + cmt.getComment_id() + "'> <i class='fa fa-share'></i> Reply </button> </span> <span class='ml-1 delete_span' id='uid" + u.getId() + "'> <button type='button' class='btn btn-outline-primary btn-sm delete' id='" + u.getName() + "_.|._" + cmt.getComment_id() + "'> <i class='fa fa-trash-o'></i> </button> </span></div>";
                l5 = "</div><hr> \n";

                newCmt = l1 + "\n" + l2 + "\n" + l3 + "\n" + l4 + "\n" + l5;

                output = output + newCmt;

                output = output + GetComments.getReplyComments(postId, cmt.getComment_id(), 0);

            }
            out.println(output);//Whoever requested it will get this output.....
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
