
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="vi"> 
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>WatchShop | Trang chủ</title> 
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'> 
        <link rel="stylesheet" href="assets/css/plugins.css"> 
        <link rel="stylesheet" href="assets/css/style.css">  
    </head> 
    <style>
        .image-item {
            border: 1px solid #ccc; /* Màu sắc và độ dày của khung viền */
            border-radius: 8px; /* Độ cong của góc, làm cho góc trở nên tròn */
            overflow: hidden; /* Giữ cho hình ảnh không bị tràn ra khỏi khung */
        }
    </style>
    <body> 
        <!-- Main Wrapper Start --> 
        <div class="off_canvars_overlay"></div> 
        <jsp:include page="header.jsp"/> 
        <!--banner area start-->
        <section class="banner_section banner_section_three">
            <div class="container-fluid ">
                <div class="row">   
                    <div class="col-12">
                        <div class="section_title">
                            <a href="product"><h2>THƯƠNG HIỆU NỔI BẬT</h2></a> 
                        </div>
                    </div> 
                </div>
                <div class="row mx-5"> 
                    <div class="col-lg-3 col-md-3">
                        <div class="banner_thumb">
                            <a href="product?action=listByCategory&cID=1"><img src="assets/img/logo/1.jpg" alt="#"></a> 
                        </div>
                    </div> 
                    <div class="col-lg-3 col-md-3">
                        <div class="banner_thumb">
                            <a href="product?action=listByCategory&cID=2"><img src="assets/img/logo/2.jpg" alt="#"></a> 
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3">
                        <div class="banner_thumb">
                            <a href="product?action=listByCategory&cID=3"><img src="assets/img/logo/3.jpg" alt="#"></a> 
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3">
                        <div class="banner_thumb">
                            <a href="product?action=listByCategory&cID=4"><img src="assets/img/logo/4.jpg" alt="#"></a> 
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3">
                        <div class="banner_thumb">
                            <a href="product?action=listByCategory&cID=5"><img src="assets/img/logo/5.jpg" alt="#"></a> 
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3">
                        <div class="banner_thumb">
                            <a href="product?action=listByCategory&cID=6"><img src="assets/img/logo/6.jpg" alt="#"></a> 
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3">
                        <div class="banner_thumb">
                            <a href="product?action=listByCategory&cID=7"><img src="assets/img/logo/7.jpg" alt="#"></a> 
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-3">
                        <div class="banner_thumb">
                            <a href="product?action=listByCategory&cID=8"><img src="assets/img/logo/8.jpg" alt="#"></a> 
                        </div>
                    </div>
                </div>
            </div>
        </section> 
        <!--product section area start-->
        <section class="product_section womens_product bottom">
            <div class="container">
                <div class="row">   
                    <div class="col-12">
                        <div class="section_title">
                            <a href="product"><h2>ĐỒNG HỒ NAM</h2></a> 
                        </div>
                    </div> 
                </div>    
                <div class="product_area"> 
                    <div class="row">
                        <div class="product_carousel product_three_column4 owl-carousel">
                            <c:forEach items="${productList}" var="product">
                                <div class="col-lg-3">
                                    <div class="single_product">
                                        <div class="product_thumb">
                                            <a class="primary_img" href="productdetails?pdetails_id=${product.product_id}"><img src="${product.img}" width="10px;" alt=""></a>
                                            <form action="cart?action=quickadd&pID=${product.product_id}" method="POST">    
                                                <div style="text-align: center" class="quick_button">
                                                    <button id="addquick" type="submit"><i class='bx bx-cart-add'></i>Thêm Giỏ Hàng</button> 
                                                </div>
                                            </form> 
                                        </div>
                                        <div class="product_content">
                                            <h3><a href="productdetails?pdetails_id=${product.product_id}">${product.product_name}</a></h3>
                                            <div style="text-align: center"> 
                                                <span class="current_price">
                                                    <fmt:formatNumber value="${product.product_price}"/> VNĐ
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="row">   
                    <div class="col-12">
                        <div class="button-viewall">
                            <button>
                                <a href="product"><h2>Xem tất cả</h2></a>
                            </button>
                        </div>
                    </div> 
                </div>
            </div>
        </section> 
        <!--product section area start-->
        <section class="product_section womens_product bottom">
            <div class="container">
                <div class="row">   
                    <div class="col-12">
                        <div class="section_title">
                            <a href="product"><h2>TOP 10 SẢN PHẨM BÁN CHẠY</h2></a> 
                        </div>
                    </div> 
                </div>    
                <div class="product_area"> 
                    <div class="row">
                        <div class="product_carousel product_three_column4 owl-carousel">
                            <c:forEach items="${top10product}" var="top">
                                <div class="col-lg-3">
                                    <div class="single_product">
                                        <div class="product_thumb">
                                            <a class="primary_img" href="productdetails?pdetails_id=${top.product_id}"><img src="${top.img}" width="10px;" alt=""></a>
                                            <div class="quick_button">
                                                <a href="productdetails?pdetails_id=${top.product_id}" title="quick_view">Xem sản phẩm</a>
                                            </div>
                                        </div>
                                        <div class="product_content">
                                            <h3><a href="productdetails?pdetails_id=${top.product_id}">${top.product_name}</a></h3>
                                            <div style="text-align: center">
                                                <span class="current_price"><fmt:formatNumber value="${top.product_price}"/> VNĐ</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--product section area end-->
        <!--footer area start-->
        <jsp:include page="footer.jsp"/> 
        <!--footer area end--> 
        <script src="assets/js/plugins.js"></script>  
        <script src="assets/js/main.js"></script>
    </body>

</html>
