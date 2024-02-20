
<%@ page import="business.Cart" %>
<%@ page import="business.Customer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

  <!-- title -->
  <title>Check Out</title>

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
  <style>
    body {font-family: Arial, Helvetica, sans-serif;}

    /* The Modal (background) */
    .modal {
      display: none; /* Hidden by default */
      position: fixed; /* Stay in place */
      z-index: 1; /* Sit on top */
      padding-top: 300px; /* Location of the box */
      left: 0;
      top: 0;
      width: 100%; /* Full width */
      height: 100%; /* Full height */
      overflow: auto; /* Enable scroll if needed */
      background-color: rgb(0,0,0); /* Fallback color */
      background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }

    /* Modal Content */
    .modal-content {
      background-color: #fefefe;
      margin: auto;
      padding: 20px;
      border: 1px solid #888;
      width: 80%;
    }

    /* The Close Button */
    .close {
      color: #aaaaaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }

    .close:hover,
    .close:focus {
      color: #000;
      text-decoration: none;
      cursor: pointer;
    }

    #myBtn {
    font-family: 'Poppins', sans-serif;
      display: inline-block;
      background-color: #F28123;
      color: #FFFFFF;
      padding: 10px 20px;
      border:none;
      border-radius: 50px;
    }

    #myBtn:hover {
      background-color: #E06800; /* Darker orange on hover */
    }

    .section {
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 20px;
      margin-bottom: 20px;
    }

    .section-header {
      border-bottom: 1px solid #ddd;
      padding-bottom: 10px;
      margin-bottom: 15px;
    }

    .section-title {
      font-size: 15px;
      margin: 0;
    }

    .section-content {
      margin-top: 20px;
    }

    .content-box {
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 15px;
    }


    .radio-content-input {
      display: inline-flex; /* Set to inline-flex to make it inline */
      align-items: center;
    }

    .main-img {
      width: 50px;
      height: auto;
      margin-right: 10px;
    }

    .radio-label-primary {
      /*font-weight: bold;*/
      display: inline; /* Set to inline to make it inline */
    }


  </style>
</head>
<body>
<%
  response.addHeader("Cache-Control", "no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0");
  response.addHeader("Pragma", "no-cache");
  response.addDateHeader ("Expires", 0);
%>
<!--PreLoader-->
<div class="loader">
  <div class="loader-inner">
    <div class="circle"></div>
  </div>
</div>
<!--PreLoader Ends-->

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
          <!-- logo -->
          <a class="mobile-show search-bar-icon" href="/index.jsp"><i class="fa-regular fa-circle-user"></i></a>
          <!-- menu start -->
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
                  <!-- Add the user login icon -->
                  <%--                                    <a class="user-login-icon" href="index.jsp"><i class="fas fa-user-lock"></i></a>--%>
                  <a href="#"class="user-login-icon" onclick="event.preventDefault(); showLoginPop()"><i class="fas fa-user-lock"></i></a>                                </div>
              </li>

            </ul>
          </nav>

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
          <h1>Check Out Product</h1>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- end breadcrumb section -->

<!-- check out section -->
<div class="checkout-section mt-150 mb-150">
  <div class="container">
    <div class="row">
      <div class="col-lg-8">
        <div class="checkout-accordion-wrap">
          <div class="accordion" id="accordionExample">
            <div class="card single-accordion">
              <div class="card-header" id="headingOne">
                <h5 class="mb-0">
                  <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                    Billing Address
                  </button>
                </h5>
              </div>

              <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                <div class="card-body">
                  <div class="billing-address-form">
                    <form action="sendEmail" method="post" >
                      <p><input name="Name" type="text" placeholder="Name" value="${customer.name}" required></p>
                      <p><input name="Email" type="email" placeholder="Email" value="${sessionScope.emailOTP}" required></p>
                      <p><input name="Address" type="text" placeholder="Address" value="${customer.address}" required></p>
                      <p><input name="Phone" type="tel" placeholder="Phone" value="${customer.name}" required></p>
                      <p><input name="Credit" type="text" placeholder="Paypal,Visa,..." value="${customer.creditCard}" required></p>
                      <p><textarea name="bill" id="bill" cols="30" rows="10" placeholder="Say Something"></textarea></p>
                      <div id="section-payment-method" class="section">
                        <div class="order-checkout__loading--box">
                          <div class="order-checkout__loading--circle"></div>
                        </div>
                        <div class="section-header">
                          <h2 class="section-title" _msttexthash="264121" _msthash="121">Payment methods</h2>
                        </div>
                        <div class="section-content">
                          <div class="content-box">
                            <div class="radio-wrapper content-box-row">
                              <label class="radio-label">
                                <div class="radio-input payment-method-checkbox"></div>
                                <div class="radio-content-input">
                                  <img class="main-img" src="https://hstatic.net/0/0/global/design/seller/image/payment/cod.svg?v=6" alt="COD Icon">
                                  <div>
                                    <span class="radio-label-primary" _msttexthash="322322" _msthash="122">Pay on delivery (COD)</span>
                                    <span class="quick-tagline hidden"></span>
                                  </div>
                                </div>
                              </label>
                            </div>
                          </div>
                        </div>
                      </div>
                      <input type="submit" value="ORDER NOW">
                    </form>

                  </div>
                </div>
              </div>
            </div>

            <!-- Trigger/Open The Modal -->

          </div>

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
        <div class="order-details-wrap">
          <table class="order-details">
            <thead>
            <tr>
              <th>Your order Details</th>
              <th>Price</th>
            </tr>
            </thead>
            <tbody class="order-details-body">

            <c:forEach var="i" items="${cart.items}">
              <tr>
                <td>${i.item.name} </td>
                <td>${i.totalCurrencyFormat}</td>
              </tr>
            </c:forEach>
            </tbody>
            <tbody class="checkout-details">
            <tr>
              <td>Subtotal</td>
              <td><%=totalBillWithoutShip%></td>
            </tr>
            <tr>
              <td>Shipping</td>
              <td><%=Ship%></td>
            </tr>
            <tr>
              <td>Total</td>
              <td><%=totalBill%></td>
            </tr>
            </tbody>
          </table>
<%--          <a href="#" class="boxed-btn">Place Order</a>--%>
          <div style="padding: 20px;"></div>
          <button id="myBtn" class="boxed-btn" >ORDER FULFILLMENT</button>
          <!-- The Modal -->
          <div id="myModal" class="modal">
            <!-- Modal content -->
            <div class="modal-content">
              <span class="close" onclick="closeModal()">&times;</span>
              <form id="otpForm" action="<%= request.getContextPath() %>/otpForm" method="post">
                <label for="otpInput">Enter OTP:</label>
                <input type="text" id="otpInput" name="otpInput" required>
                <button type="submit">Submit OTP</button>
              </form>
            </div>

          </div>

        </div>
      </div>
    </div>
  </div>
</div>
<!-- end check out section -->

<!-- logo carousel -->
<div class="logo-carousel-section">
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <div class="logo-carousel-inner">
          <div class="single-logo-item">
            <img src="assets/img/company-logos/1.png" alt="">
          </div>
          <div class="single-logo-item">
            <img src="assets/img/company-logos/2.png" alt="">
          </div>
          <div class="single-logo-item">
            <img src="assets/img/company-logos/3.png" alt="">
          </div>
          <div class="single-logo-item">
            <img src="assets/img/company-logos/4.png" alt="">
          </div>
          <div class="single-logo-item">
            <img src="assets/img/company-logos/5.png" alt="">
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

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
            <li><a href="about.jsp">About</a></li>
            <li><a href="news.html">News</a></li>
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
<script>
  // Get the modal
  var modal = document.getElementById("myModal");
  var btn = document.getElementById("myBtn");
  var span = document.getElementsByClassName("close")[0];
  btn.onclick = function() {
    modal.style.display = "block";
  }
  span.onclick = function() {
    modal.style.display = "none";
  }

  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }

  }
  // Function to close the modal
  function closeModal() {
    var modal = document.getElementById("myModal");
    modal.style.display = "none";
  }

 function submitOTP() {
    var otpValue = document.getElementById("otpInput").value;

    closeModal();
  }

  function showMessage(message) {
    alert(message);
  }

  // Check if the retryMessage is present and show the pop-up
  <% String retryMessage = (String) request.getAttribute("retryMessage");
     if (retryMessage != null) { %>
  window.onload = function() {
    showMessage("<%= retryMessage %>");
  }
  <% } %>

  <% String Message = (String) request.getAttribute("Message");
       if (Message != null) { %>
  window.onload = function() {
    showMessage("<%= Message %>");
  }
  <% } %>
</script>
</body>
</html>