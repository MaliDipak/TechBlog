<%-- 
    Document   : normal_navbar
    Author     : Dipak Chandrakant Mali
--%>


<nav class="navbar navbar-expand-lg sticky-top navbar-dark primary-background">
    <a class="navbar-brand" href="index.jsp"><span class="fa fa-book"></span>  Tech Blog </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="login_page.jsp"> <span class="fa fa-user-circle-o"></span> Login</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="register_page.jsp"> <span class="fa fa-user-plus"></span> Sign Up</a>
            </li>
          
            <li class="nav-item">
                <a class="nav-link" href="#!" data-toggle="modal" data-target="#contact-modal"> <span class="fa fa-address-book"></span> Contact us </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="profile.jsp"> <span class="fa fa-address-card-o"></span> Profile </a>
            </li>

        </ul>
        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-light my-2 my-sm-0" type="submit"> <span class="fa fa-search"></span> Search</button>
        </form>
    </div>
</nav>


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
                        <i class="fa fa-instagram"></i>
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