package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
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
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");

            //fetch all data from request
            String user_email = request.getParameter("user_email");
            String user_name = request.getParameter("user_name");
            String user_password = request.getParameter("user_password");
            String user_about = request.getParameter("user_about");
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();

            //get the suer from the session...
            HttpSession s = request.getSession();
            User user = (User) s.getAttribute("currentUser");
            
            
            user.setName(user_name);
            user.setEmail(user_email);
            user.setPassword(user_password);
            user.setAbout(user_about);
            String oldPicName = user.getProfile();

            if (imageName.equals("") == false) {
                user.setProfile("userId" + user.getId() + "picName" + imageName);//Creating a unique name for pic to avoiding duplication
            }

            //update data in database....
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            boolean ans = userDao.updateUser(user);
            if (ans) {
                out.println("Information successfully added to databse");
//                generating path
                String newPicPath = request.getRealPath("/") + "pics" + File.separator + user.getProfile();//to save new pic
                String oldPicPath = request.getRealPath("/") + "pics" + File.separator + oldPicName;//to delete old pic
                if (!oldPicName.equals("default.jpg")) {
                    Helper.deleteFile(oldPicPath);//here we try to delete if file is exist
                }
                if (Helper.saveFile(part.getInputStream(), newPicPath)) {
                    out.println("Profile Updated Successfully!");

                    Message msg = new Message("Prifle Details Updated", "success", "alert-success");
                    s.setAttribute("msg", msg);

                } else {
                    out.println("File not saved successfully!");
                    Message msg = new Message("File not saved, Something Went Wrong...", "error", "alert-danger");
                    s.setAttribute("msg", msg);
                }
            } else {
                out.println("Not Updated....");
                Message msg = new Message("Something Went Wrong...", "error", "alert-danger");
                s.setAttribute("msg", msg);
            }

            response.sendRedirect("profile.jsp");
            out.println("</body>");
            out.println("</html>");
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
