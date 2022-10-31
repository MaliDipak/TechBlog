package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.tech.blog.dao.CommentDao;
import com.tech.blog.entities.Comment;
import com.tech.blog.helper.ConnectionProvider;

public class MakeCommentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

//            fetching values
            String comment_name = request.getParameter("comment_name");
            String comment_content = request.getParameter("comment_content");
            int parent_id = Integer.parseInt(request.getParameter("comment_id"));
            int user_id = Integer.parseInt(request.getParameter("user_id"));
            int post_id = Integer.parseInt(request.getParameter("post_id"));

            CommentDao cdao = new CommentDao(ConnectionProvider.getConnection());
            Comment cmt = new Comment(parent_id, comment_content, comment_name, user_id, post_id);
            boolean f = cdao.saveComment(cmt);
            if (f) {
                out.println(comment_name + " have commented " + comment_content);
            } else {
                out.println("something wend wrong...");
            }
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
