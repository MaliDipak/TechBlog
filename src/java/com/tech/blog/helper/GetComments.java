package com.tech.blog.helper;

import com.tech.blog.dao.CommentDao;
import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Comment;
import com.tech.blog.entities.User;
import java.util.List;

public class GetComments {

    public static String getReplyComments(int pid, int parent_id, int marginLeft) {
        String output = "";

        CommentDao cdao = new CommentDao(ConnectionProvider.getConnection());

        List<Comment> cmtlst = cdao.getAllCommentByParentId(parent_id, pid);

        int count = cmtlst.size();

        if (parent_id == 0) {
            marginLeft = 0;
        } else {
            marginLeft = marginLeft + 48;
        }

        String ancmt;

        String l1;
        String l2;
        String l3;
        String l4;
        String l5;
        UserDao udao = new UserDao(ConnectionProvider.getConnection());
        if (count > 0) {
            for (Comment c : cmtlst) {
                User u = udao.getUserByUserId(c.getUserId());
                l1 = "\n <div class='panel panel-default' style='margin-left: " + marginLeft + "px;'>";
                l2 = "<div class='d-flex flex-row user-info'><img class='rounded-circle' src='pics/" + u.getProfile() + "' width='40'><div class='panel-heading'><div class='d-flex flex-column justify-content-start ml-2'><span class='d-block font-weight-bold name'>" + c.getCommenter_name() + "</span><span class='date text-black-50'>Shared publicly - " + c.getComment_date().toLocaleString().substring(3, 12) + "</span></div></div> </div>";
                l3 = "<br><div class='mt-2'> <p class='comment-text'>" + c.getComment() + "</p> </div>";
                l4 = "<div class='like p-2 cursor panel-footer' align='right'> <span class='ml-1'><button type='button' class='btn btn-outline-primary btn-sm reply' id='" + u.getName() + "_.|._" + c.getComment_id() + "'> <i class='fa fa-share'> </i> Reply </button></span> <span class='ml-1 delete_span' id='uid" + u.getId() + "'> <button type='button' class='btn btn-outline-primary btn-sm delete' id='" +u.getName()+"_.|._"+c.getComment_id() + "'> <i class='fa fa-trash-o'></i> </button> </span> </div>";
                l5 = "</div><hr> \n";

                ancmt = l1 + "\n" + l2 + "\n" + l3 + "\n" + l4 + "\n" + l5;

                output = output + ancmt;

                output = output + GetComments.getReplyComments(pid, c.getComment_id(), marginLeft);
            }
        }
        return output;
    }

}
