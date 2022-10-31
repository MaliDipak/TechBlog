function doLike(pid, uid) {
    console.log(pid + "," + uid);
    const d = {
        uid: uid,
        pid: pid
    };

    $.ajax({
        url: "LikeServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            if (data.trim() === 'liked') {
                let c = $('.likeCounter_' + pid).html();
                c++;
                $('.likeCounter_' + pid).html(c);

                $("#postId_" + pid).removeClass("fa fa-thumbs-o-up");
                $("#postId_" + pid).addClass("fa fa-thumbs-up");
            }
            if (data.trim() === 'disliked') {
                let c = $('.likeCounter_' + pid).html();
                c--;
                $('.likeCounter_' + pid).html(c);

                $("#postId_" + pid).removeClass("fa fa-thumbs-up");
                $("#postId_" + pid).addClass("fa fa-thumbs-o-up");
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    });
}