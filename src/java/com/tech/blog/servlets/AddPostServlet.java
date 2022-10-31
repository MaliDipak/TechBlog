package com.tech.blog.servlets;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class AddPostServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

//            fetching data from request
            int cid = Integer.parseInt(request.getParameter("cid"));
            String pTitle = request.getParameter("pTitle");
            String pContent = request.getParameter("pContent");
            String pCode = request.getParameter("pCode");
            Part part = request.getPart("pic");
            String picName = part.getSubmittedFileName();

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");

            Post p = new Post(pTitle, pContent, pCode, picName, null, cid, user.getId());
            PostDao pdao = new PostDao(ConnectionProvider.getConnection());
            String unique_blog_pic_name;

            if (pdao.savePost(p)) {

                /**
                 * Here first we save the post so. So after post was
                 * successfully saved we gate their unique id for create unique
                 * pic name for that we fire query for max post id and once post
                 * saved it will never return 0 then we rename pic with unique
                 * name..
                 */
                int uniquePicId = pdao.uniquePostIdForPic();
                if (uniquePicId != 0) {

                    unique_blog_pic_name = "postId" + uniquePicId + "blogPicName" + picName;

                    String PicPath = request.getRealPath("/") + "blog_pics" + File.separator + unique_blog_pic_name;//to save new pic

                    if (picName.equals("") == true) {
                        pdao.renamePicInDb("default_post.png", uniquePicId);
                    } else {
                        Helper.saveFile(part.getInputStream(), PicPath);
                        pdao.renamePicInDb(unique_blog_pic_name, uniquePicId);
                    }

                } else {

                    ///currently  this field is not requeired because uniquePostIdForPic() never return 0......
//                    unique_blog_pic_name = "userId" + user.getId() + "blogPicName" + picName;
//
//                    String PicPath = request.getRealPath("/") + "blog_pics" + File.separator + unique_blog_pic_name;//to save new pic
//                    Helper.saveFile(part.getInputStream(), PicPath);
////                    out.println("pic saved saved with user id");
                }
                out.println("done");
            } else {
                out.println("error");
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
