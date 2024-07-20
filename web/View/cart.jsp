 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="no-js" lang="en"> 
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Giỏ hàng</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico"> 
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'> 
        <link rel="stylesheet" href="assets/css/plugins.css"> 
        <link rel="stylesheet" href="assets/css/style.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    </head>
    <style>
        button-num {
        background-color: #3498db;
        color: #fff;
        padding: 5px 10px;
        border: none;
        border-radius: 3px;
        cursor: pointer;
    } 
    label {
        display: inline-block;
        margin: 0 5px;
    }
    </style>

    <body>

        <!-- Main Wrapper Start -->
        <!--Offcanvas menu area start-->
        <div class="off_canvars_overlay"></div>
        <jsp:include page="header.jsp"/>
        <!--breadcrumbs area start-->
        <div class="breadcrumbs_area other_bread">
            <div class="container">   
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb_content">
                            <ul>
                                <li><a href="index.html">Trang chủ</a></li>
                                <li>/</li>
                                <li>Giỏ hàng</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>         
        </div>
        <!--breadcrumbs area end--> 
        <!-- shopping cart area start -->
        <div class="shopping_cart_area">
            <div class="container">    
                <form> 
                    <c:if test="${cart.getAllItem().isEmpty()}">
                        <i style=" display: flex; justify-content: center;align-items: center; ; font-size: 40px" class='bx bx-cart-alt'></i>
                        <h4 style="text-align: center; color: red; font-size: 16px">Chưa có sản phẩm nào trong giỏ hàng !</h4>
                    </c:if>
                    <c:if test="${!cart.getAllItem().isEmpty()}">
                        <div class="row">
                            <div class="col-12">
                                <div class="table_desc">
                                    <div class="cart_page table-responsive">  
                                        <table>
                                            <thead>
                                                <tr> 
                                                    <th class="product_thumb"></th>
                                                    <th class="product_name">Sản Phẩm</th>
                                                    <th class="product-price">Giá</th> 
                                                    <th class="product_quantity">Số lượng</th>
                                                    <th class="product_total">Tổng</th>
                                                    <th class="product_remove">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>  
                                                <c:forEach items="${cart.getAllItem()}" var="c"> 
                                                    <tr> 
                                                        <td class="product_thumb">
                                                            <a style="width: 100px" href="productdetails?pdetails_id=${c.product.product_id}"><img src="${c.product.img}" alt=""></a>
                                                        </td>
                                                        <td class="product_name">
                                                            <a href="productdetails?pdetails_id=${c.product.product_id}">${c.product.product_name}</a> 
                                                        </td> 
                                                        <td class="product_price">   
                                                            <label id="price"><fmt:formatNumber value="${c.price}"/></label> 
                                                        </td> 
                                                        <td class="product_quantity">    
                                                            <button type="button"><a href="cart?action=sub&pID=${c.product.product_id}">-</a></button>  
                                                            <label id="inputQuantity" value="2"> ${c.quantity} </label>  
                                                            <button  type="button">
                                                                <c:if test="${c.quantity < c.product.quantity}">
                                                                <a href="cart?action=add&pID=${c.product.product_id}"}>+</a>
                                                                </c:if>
                                                                <c:if test="${c.quantity >= c.product.quantity}"> 
                                                                <a onclick="Notificate(${c.product.quantity})" href="#">+</a> 
                                                                </c:if> 
                                                            </button>
                                                            <div style="margin-top: 15px">  
                                                        </td>
                                                        <td class="product_total" id="total">
                                                            <fmt:formatNumber  value="${c.price * c.quantity }"/>
                                                        </td> 
                                                        <td class="product_remove">
                                                            <a href="cart?action=remove&pID=${c.product.product_id}"><i class="fa fa-trash-o"></i></a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>    
                                    </div>  
                                </div>
                            </div>
                        </div>
                        <!--coupon code area start--> 
                        <div class="coupon_area">
                            <div class="row">
                                <div class="col-lg-12 col-md-12">
                                    <div class="coupon_code right">
                                        <h3>Hóa đơn</h3>
                                        <div class="coupon_inner">
                                            <div class="cart_subtotal">
                                                <p>Tổng mặt hàng: </p>
                                                <p class="cart_amount"><fmt:formatNumber value="${cart.getAllItem().size()}"/></p>
                                            </div> 
                                            <div class="cart_subtotal">
                                                <p>Tổng số tiền cần thanh toán: </p>
                                                <p class="cart_amount"><fmt:formatNumber value="${cart.getTotalMoney()}"/></p>
                                            </div>
                                            <div class="checkout_btn">
                                                <a id="handlePay" >Thanh toán</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> 
                        <!--coupon code area end-->
                    </form> 
                </c:if>

            </div>     
        </div> 
        <script>
            document.getElementById('handlePay').addEventListener('click', function(){
                    sessionStorage.setItem('clickedPay', 'true'); //xác định đã click nút Thanh toán
                    var currentUrl = window.location.href; 
                    window.location.href = currentUrl; 
            });
            window.addEventListener('load', function() {
                var clicked = sessionStorage.getItem('clickedPay');
                if(clicked === 'true'){
                    var message = "${message}";
                    if(message === "can order"){
                        window.location.href = "order";
                    }
                    else{
                        Swal.fire({
                        title: "Thông Báo",
                        text: message,
                        icon: "warning",
                        timer: 1500
                        });
                    }
                    sessionStorage.setItem('clickedPay', 'false');
                } 
            });
            function Notificate(quantity){
                Swal.fire({
                    title: "Thông Báo",
                    text: "Số lượng sản phẩm trong kho chỉ còn " + quantity,
                    icon: "info",
                    timer: 1500
                });
            } 
        </script>
        <!-- shopping cart area end -->  
        <script src="assets/js/plugins.js"></script>  
        <script src="assets/js/main.js"></script> 
    </body>

</html>