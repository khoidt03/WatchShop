 

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="no-js" lang="en"> 
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>All Product</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">  
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'> 
        <link rel="stylesheet" href="assets/css/plugins.css"> 
        <link rel="stylesheet" href="assets/css/style.css"> 
    </head> 
    <body> 
        <!-- Main Wrapper Start -->
        <!--Offcanvas menu area start-->
        <div class="off_canvars_overlay"></div>
        <jsp:include page="header.jsp"/> 
        <!--breadcrumbs area start-->
        <div class="breadcrumbs_area">
            <div class="container">   
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb_content">
                            <ul>
                                <li><a href="home">Trang chủ</a></li>
                                <li>/</li>
                                <li>Product</li> 
                            </ul>
                        </div>
                    </div>
                </div>
            </div>         
        </div>
        <!--breadcrumbs area end--> 
        <!--shop  area start-->
        <div class="shop_area shop_reverse">
            <div class="container">
                <div class="shop_inner_area">
                    <div class="row"> 
                        <div class="col-lg-3 col-md-12">
                            <!--sidebar widget start-->
                            <div class="sidebar_widget">
                                <div class="widget_list widget_categories">
                                    <h2>Danh mục</h2>
                                    <ul>
                                        <li><a href="product">TẤT CẢ</a></li>
                                            <c:forEach items="${categoryAll}" var="c">
                                            <li><a href="product?action=listByCategory&cID=${c.category_id}">${c.category_name}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <!--sidebar widget end-->
                        </div>
                        <div class="col-lg-9 col-md-12">
                            <!--shop wrapper start-->
                            <!--shop toolbar start--> 
                            <div class="shop_toolbar_wrapper" style="border:none">
                                <div class="dropdown ">
                                    <button style="color: #000; background-color: #ffffff;border:none; font-family: sans-serif;" class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                         <i class='bx bx-filter-alt'></i> Bộ lọc
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <a class="dropdown-item" href="product?action=sort&type=low">Giá từ thấp đến cao</a>
                                        <a class="dropdown-item" href="product?action=sort&type=high">Giá từ cao xuống thấp</a>
                                        <a class="dropdown-item" href="product?action=sort&type=a-z">A-Z</a>
                                    </div>
                                </div>
                            </div>
                            <div class="row shop_wrapper">
                                <c:forEach items="${productAll}" var="p">
                                    <div class="col-lg-4 col-md-4 col-12 ">
                                        <div class="single_product">
                                            <div class="product_thumb">
                                                <a class="primary_img" href="productdetails?pdetails_id=${p.product_id}"><img src="${p.img}" alt=""></a> 
                                                <div class="quick_button">
                                                    <a href="productdetails?pdetails_id=${p.product_id}"title="quick_view">Xem sản phẩm</a>
                                                </div>
                                            </div>
                                            <div class="product_content grid_content">
                                                <h3><a href="productdetails?pdetails_id=${p.product_id}">${p.product_name}</a></h3>
                                                <div style="text-align: center"> 
                                                    <span class="current_price"><fmt:formatNumber value="${p.product_price}"/> VNĐ</span>
                                                </div> 
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div> 
                            <c:set var="page" value="${page}"/>
                            <div class="shop_toolbar t_bottom" style="border: none;">
                                <div class="pagination">
                                    <ul>
                                        <c:forEach begin="${1}" end="${num}" var="i">
                                            <li class="${i==page?"current":""}"><a href="product?page=${i}">${i}</a></li>
                                            </c:forEach> 
                                    </ul>
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--shop  area end--> 
        <!--footer area start-->
        <jsp:include page="footer.jsp"/>
        <!--footer area end--> 
        <!-- Plugins JS -->
        <script src="assets/js/plugins.js"></script> 
        <!-- Main JS -->
        <script src="assets/js/main.js"></script>
    </body>

</html>