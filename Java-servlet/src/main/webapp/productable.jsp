
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="business.Product" %>
<%@ page import="Data.ProductDB" %>
<%@ page import="java.util.List" %>
<%@ page import="business.Admin" %>
<%@ page import="Data.AdminDB" %>
<!DOCTYPE html>
<html dir="ltr" lang="en">
<%
    response.addHeader("Cache-Control", "no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0");
    response.addHeader("Pragma", "no-cache");
    response.addDateHeader ("Expires", 0);
%>
<%Admin admin1 = (Admin) session.getAttribute("admin");
    String url;
    if(admin1==null){
        url ="/index.jsp";
        response.sendRedirect(request.getContextPath() + url);
    }
%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords"
          content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, Ample lite admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, Ample admin lite dashboard bootstrap 5 dashboard template">
    <meta name="description"
          content="Ample Admin Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
    <meta name="robots" content="noindex,nofollow">
    <title>Fruitka Admin</title>
    <link rel="canonical" href="https://www.wrappixel.com/templates/ample-admin-lite/" />
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="plugins/images/favicon.png">
    <!-- Custom CSS -->
    <link href="assets/cssforadmin/style.min.css" rel="stylesheet">

    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div class="preloader">
    <div class="lds-ripple">
        <div class="lds-pos"></div>
        <div class="lds-pos"></div>
    </div>
</div>

<div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5" data-sidebartype="full"
     data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">
    <header class="topbar" data-navbarbg="skin5">
        <nav class="navbar top-navbar navbar-expand-md navbar-dark">
            <div class="navbar-header" data-logobg="skin6">
                <a class="navbar-brand" href="dashboard.jsp">
                    <b class="logo-icon">
                        <img src="plugins/images/logo-icon.png" alt="homepage" />
                    </b>
                    <span class="logo-text">
                            <img src="plugins/images/logo-text.png" alt="homepage" />
                        </span>
                </a>
                <a class="nav-toggler waves-effect waves-light text-dark d-block d-md-none"
                   href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
            </div>
             -->
            <div class="navbar-collapse collapse" id="navbarSupportedContent" data-navbarbg="skin5">
                <ul class="navbar-nav d-none d-md-block d-lg-none">
                    <li class="nav-item">
                        <a class="nav-toggler nav-link waves-effect waves-light text-white"
                           href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto d-flex align-items-center">

                    <!-- ============================================================ -->
                    <li>
                        <form class="logout-form" action="logout" method="post">
                            <%--              <input type="hidden" name="csrf_token" value="your_csrf_token_here">--%>
                            <input type="submit" value="Logout">
                        </form>
                    </li>

                    <!-- ============================================================= -->
                   <%Admin admin = AdminDB.selectadmin("A001"); %>
          <%request.setAttribute("admin",admin); %>
          <li>
            <a class="profile-pic" href="#">
              <img src="plugins/images/users/varun.jpg" alt="user-img" width="36"
                   class="img-circle"><span class="text-white font-medium">${admin.userName}</span></a>
          </li>
                    <!-- ============================================================ -->
                </ul>
            </div>
        </nav>
    </header>
    <!-- ========================= -->
    <aside class="left-sidebar" data-sidebarbg="skin6">
        <!-- Sidebar scroll-->
        <div class="scroll-sidebar">
            <!-- Sidebar navigation-->
            <nav class="sidebar-nav">
                <ul id="sidebarnav">
                    <!-- User Profile-->
                    <li class="sidebar-item pt-2">
                        <a class="sidebar-link waves-effect waves-dark sidebar-link" href="dashboard.jsp"
                           aria-expanded="false">
                            <i class="far fa-clock" aria-hidden="true"></i>
                            <span class="hide-menu">Dashboard</span>
                        </a>
                    </li>
                    <li class="sidebar-item">
                        <a class="sidebar-link waves-effect waves-dark sidebar-link" href="profile.jsp"
                           aria-expanded="false">
                            <i class="fa fa-user" aria-hidden="true"></i>
                            <span class="hide-menu">Custom page</span>
                        </a>
                    </li>
                    <li class="sidebar-item">
                        <a class="sidebar-link waves-effect waves-dark sidebar-link" href="basic-table.jsp"
                           aria-expanded="false">
                            <i class="fa fa-table" aria-hidden="true"></i>
                            <span class="hide-menu">Customer Table</span>
                        </a>
                    </li>
                    <li class="sidebar-item">
                        <a class="sidebar-link waves-effect waves-dark sidebar-link" href="productable.jsp"
                           aria-expanded="false">
                            <i class="fa fa-table" aria-hidden="true"></i>
                            <span class="hide-menu">Product Table</span>
                        </a>
                    </li>


                </ul>

            </nav>
            <!-- End Sidebar navigation -->
        </div>
        <!-- End Sidebar scroll-->
    </aside>
    <!-- ========================================================= -->
    <div class="page-wrapper">
        <!-- ====================================================== -->
        <div class="page-breadcrumb bg-white">
            <div class="row align-items-center">
                <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                    <h4 class="page-title">Product Table</h4>
                </div>
            </div>
        </div>

        <% List<Product> products = ProductDB.getAllProducts();
            request.setAttribute("product",products);
        %>
        <div class="container-fluid">
            <!-- ========================================================== -->
            <div class="row">
                <div class="col-sm-12">
                    <div class="white-box">
                        <h3 class="box-title">Basic Table</h3>
                        <p class="text-muted">Add class <code>.table</code></p>
                        <div class="table-responsive">
                            <table class="table text-nowrap">
                                <thead>
                                <tr>
<%--                                    <th class="border-top-0">id</th>--%>
                                    <th class="border-top-0">Name</th>
                                    <th class="border-top-0">price</th>
                                    <th class="border-top-0">date input</th>
                                    <th class="border-top-0">exp</th>
                                    <th class="border-top-0">origin</th>
                                    <th class="border-top-0">decription</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="product" items="${product}">
                                    <tr>
                                            <%--                                    <td></td>--%>
<%--                                        <td>${product.fruitID}</td>--%>
                                        <td>${product.name}</td>
                                        <td>${product.price}</td>
                                        <td>${product.dateInput}</td>
                                        <td>${product.exp}</td>
                                        <td>${product.origin}</td>
                                        <td>${product.description}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ============================================= -->
        </div>
        <!-- ================================================= -->
        <footer class="footer text-center"> 2021 © Ample Admin brought to you by <a
                href="https://www.wrappixel.com/">wrappixel.com</a>
        </footer>
        <!-- ================================================ -->
    </div>
    <!-- ===================================== -->
</div>
<!-- ============================================= -->
<script src="plugins/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap tether Core JavaScript -->
<script src="assets/bootstrapForAdmin/dist/js/bootstrap.bundle.min.js"></script>
<script src="assets/jsForAdmin/app-style-switcher.js"></script>
<!--Wave Effects -->
<script src="assets/jsForAdmin/waves.js"></script>
<!--Menu sidebar -->
<script src="assets/jsForAdmin/sidebarmenu.js"></script>
<!--Custom JavaScript -->
<script src="assets/jsForAdmin/custom.js"></script>
</body>

</html>