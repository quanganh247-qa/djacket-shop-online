<%@ page import="business.Cart" %>
<%@ page import="org.w3c.dom.stylesheets.LinkStyle" %>
<%@ page import="business.Product" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

    <!-- title -->
    <title>Cart</title>

    <!-- favicon -->
    <link rel="shortcut icon" type="image/png" href="assets/img/favicon.png">
    <!-- google font -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Poppins:400,700&display=swap" rel="stylesheet">
    <!-- fontawesome -->
    <link rel="stylesheet" href="assets/css/all.min.css">
    <!-- bootstrap -->
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <!-- owl carousel -->
    <link rel="stylesheet" href="assets/css/owl.carousel.css">
    <!-- magnific popup -->
    <link rel="stylesheet" href="assets/css/magnific-popup.css">
    <!-- animate css -->
    <link rel="stylesheet" href="assets/css/animate.css">
    <!-- mean menu css -->
    <link rel="stylesheet" href="assets/css/meanmenu.min.css">
    <!-- main style -->
    <link rel="stylesheet" href="assets/css/main.css">
    <!-- responsive -->
    <link rel="stylesheet" href="assets/css/responsive.css">
    <style>/* Add this CSS to your stylesheet or in a <style> tag in the head of your HTML document */
    .cart-section {
        margin-bottom: 50px; /* Adjust the margin as needed */
    }

    .more-products {
        margin-top: 50px; /* Adjust the margin as needed */
    }


    .my-button {
         font-family: 'Poppins', sans-serif;
         display: inline-block;
         background-color: #F28123;
         color: #fff;
         padding: 10px 25px;
         text-decoration: none; /* Remove underline for anchor tags */
         border: none; /* Remove default button border */
         cursor: pointer; /* Change cursor on hover */
         border-radius: 50px;
     }

    .my-button:hover {
        background-color: #E06800; /* Change background color on hover */
    }
    .table-total-row{
        background-color: #FFFFFF;
    }

    </style>

</head>
<body>

<!--PreLoader-->
<div class="loader">
    <div class="loader-inner">
        <div class="circle"></div>
    </div>
</div>
<!--PreLoader Ends-->
<%
    response.addHeader("Cache-Control", "no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0");
    response.addHeader("Pragma", "no-cache");
    response.addDateHeader ("Expires", 0);
%>
<!-- header -->
<div class="top-header-area" id="sticker">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-sm-12 text-center">
                <div class="main-menu-wrap">
                    <!-- logo -->
                    <div class="site-logo">
                        <a href="index.jsp">
                            <img src="assets/img/logo.png" alt="">
                        </a>
                    </div>
                    <nav class="main-menu">
                        <ul>
                            <li class="current-list-item"><a href="index.jsp">Home</a>
                            </li>
                            <li><a href="about.jsp">About</a></li>
                            <li><a href="#">Pages</a>
                                <ul class="sub-menu">
                                    <li><a href="about.jsp">About</a></li>
                                    <li><a href="cart.jsp">Cart</a></li>
                                    <li><a href="checkout.jsp">Check Out</a></li>
                                    <li><a href="shop.jsp">Shop</a></li>
                                </ul>
                            </li>
                            <li><a href="shop.jsp">Shop</a>
                                <ul class="sub-menu">
                                    <li><a href="shop.jsp">Shop</a></li>
                                    <li><a href="checkout.jsp">Check Out</a></li>
                                    <li><a href="cart.jsp">Cart</a></li>
                                </ul>
                            </li>
                            <li>
                                <div class="header-icons">
                                    <a class="shopping-cart" href="cart.jsp"><i class="fas fa-shopping-cart"></i></a>
                                    <a class="user-login-icon" href="index.jsp"><i class="fas fa-user-lock"></i></a>
                                </div>
                            </li>
                        </ul>
                    </nav>
<%--                    <a class="mobile-show search-bar-icon" href="/index.jsp"><i class="fa-regular fa-circle-user"></i></a>--%>
                    <div class="mobile-menu"></div>
                    <!-- menu end -->
                </div>
            </div>
        </div>
    </div>
</div>
<!-- end header -->


<!-- breadcrumb-section -->
<div class="breadcrumb-section breadcrumb-bg">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
                <div class="breadcrumb-text">
                    <p>Fresh and Organic</p>
                    <h1>Cart</h1>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- end breadcrumb section -->

<!-- cart -->
<div class="cart-section mt-150 mb-150">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-12">
                <div class="cart-table-wrap">

                    <table class="cart-table">
                        <tr>
                            <th>Quantity</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Amount</th>
                            <th></th>
                        </tr>

                        <c:forEach var="i" items="${cart.items}">
                            <tr class="table-total-row">
                                <td>
                                    <form action="cart" method="post">
                                        <input type="hidden" name="fruitID" value="${i.item.fruitID}">
                                        <input type=text name="quantity" value="${i.quantity}" id="quantity">
                                        <input type="hidden" name="update" value="true">
                                        <button type="submit" class="my-button">Update </button>
                                    </form>

                                </td>
                                <td>${i.item.name}</td>
                                <td>${i.item.priceCurrencyFormat}</td>
                                <td>${i.totalCurrencyFormat}</td>
                                <td>
                                    <a href="cart?fruitID=${i.item.fruitID}&amp;quantity=0">Remove Item</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>

            <%Cart cart = (Cart) session.getAttribute("cart");%>
            <%
                String totalBillWithoutShip;
                String Ship;
                String totalBill;
                if (cart != null){
                    totalBillWithoutShip=cart.getTotalWithoutShipCurrencyFormat();
                    Ship = cart.getShipCurrentFormat();
                    totalBill=cart.getTotalCurrentFormat();}
                else {
                    totalBillWithoutShip = "0";
                    Ship = "0";
                    totalBill = "0";
                }
            %>
            <div class="col-lg-4">
                <div class="total-section">
                    <table class="total-table">
                        <thead class="total-table-head">
                        <tr class="table-total-row">
                            <th>Total</th>
                            <th>Price</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="total-data">
                            <td><strong>Subtotal: </strong></td>
                            <td><%=totalBillWithoutShip%></td>
                        </tr>
                        <tr class="total-data">
                            <td><strong>Shipping: </strong></td>
                            <td><%=Ship %></td>
                        </tr>
                        <tr class="total-data">
                            <td><strong>Total: </strong></td>
                            <td><%=totalBill%></td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="cart-buttons">
                        <a href="checkout.jsp" class="boxed-btn black">Check Out</a>
                    </div>
                </div>
    </div>
</div>

<!-- more products -->
<div class="more-products mb-150">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
                <div class="section-title">
                    <h3><span class="orange-text">Related</span> Products</h3>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid, fuga quas itaque eveniet beatae optio.</p>
                </div>
            </div>
        </div>
        <% List<Product> recommended = (List<Product>) session.getAttribute("productRecommended");
            request.setAttribute("products", recommended);
        %>
        <div class="row">
            <c:forEach var="product" items="${products}">
                <div class="col-lg-4 col-md-6 text-center">
                    <div class="single-product-item">
                        <a href="single-product.jsp?fruitID=${product.fruitID}" ><img src="assets/img/products/product-img-1.jpg" alt="">
                            <h3>${product.name}</h3>
                            <p class="product-price"><span>Per Kg</span> ${product.price} </p>

                            <form class="cart-btn fas" action="cart" method="post">
                                <input type="hidden" name="fruitID" value="${product.fruitID}">
                                <button type="submit" class="my-button">
                                    <i class="fas fa-shopping-cart"></i> Add To Cart
                                </button>
                            </form>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
        </div>
    </div>
</div>

<!-- footer -->
<div class="footer-area">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-6">
                <div class="footer-box about-widget">
                    <h2 class="widget-title">About us</h2>
                    <p>Ut enim ad minim veniam perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae.</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="footer-box get-in-touch">
                    <h2 class="widget-title">Get in Touch</h2>
                    <ul>
                        <li>34/8, East Hukupara, Gifirtok, Sadan.</li>
                        <li>support@fruitkha.com</li>
                        <li>+00 111 222 3333</li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="footer-box pages">
                    <h2 class="widget-title">Pages</h2>
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="services.html">Shop</a></li>
                        <li><a href="contact.html">Contact</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="footer-box subscribe">
                    <h2 class="widget-title">Subscribe</h2>
                    <p>Subscribe to our mailing list to get the latest updates.</p>
                    <form action="index.jsp">
                        <input type="email" placeholder="Email">
                        <button type="submit"><i class="fas fa-paper-plane"></i></button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- end footer -->

<!-- copyright -->
<div class="copyright">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-md-12">
                <p>Copyrights &copy; 2019 - <a href="https://imransdesign.com/">Imran Hossain</a>,  All Rights Reserved.<br>
                    Distributed By - <a href="https://themewagon.com/">Themewagon</a>
                </p>
            </div>
            <div class="col-lg-6 text-right col-md-12">
                <div class="social-icons">
                    <ul>
                        <li><a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
                        <li><a href="#" target="_blank"><i class="fab fa-twitter"></i></a></li>
                        <li><a href="#" target="_blank"><i class="fab fa-instagram"></i></a></li>
                        <li><a href="#" target="_blank"><i class="fab fa-linkedin"></i></a></li>
                        <li><a href="#" target="_blank"><i class="fab fa-dribbble"></i></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- end copyright -->

<!-- jquery -->
<script src="assets/js/jquery-1.11.3.min.js"></script>
<!-- bootstrap -->
<script src="assets/bootstrap/js/bootstrap.min.js"></script>
<!-- count down -->
<script src="assets/js/jquery.countdown.js"></script>
<!-- isotope -->
<script src="assets/js/jquery.isotope-3.0.6.min.js"></script>
<!-- waypoints -->
<script src="assets/js/waypoints.js"></script>
<!-- owl carousel -->
<script src="assets/js/owl.carousel.min.js"></script>
<!-- magnific popup -->
<script src="assets/js/jquery.magnific-popup.min.js"></script>
<!-- mean menu -->
<script src="assets/js/jquery.meanmenu.min.js"></script>
<!-- sticker js -->
<script src="assets/js/sticker.js"></script>
<!-- main js -->
<script src="assets/js/main.js"></script>

</div>
</body>
</html>