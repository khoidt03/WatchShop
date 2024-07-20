 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge"> 
        <title>Thông Tin Đặt Hàng</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">  
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="assets/css/plugins.css"> 
        <link rel="stylesheet" href="assets/css/style.css"> 
    </head> 
    <body> 
        <div class="off_canvars_overlay"></div>
        <jsp:include page="header.jsp"/>
        <!--breadcrumbs area start-->
        <div class="breadcrumbs_area other_bread">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb_content">
                            <ul>
                                <li><a href="index.html">home</a></li>
                                <li>/</li>
                                <li>Đơn Hàng</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--breadcrumbs area end--> 
        <!--Checkout page section-->
        <div class="Checkout_section" id="accordion">
            <div class="container">
                <div class="checkout_form"> 
                    <form action="order" method="POST">
                        <div class="row">
                            <div class="col-lg-5 col-md-5">
                                <h3>Chi tiết đơn hàng</h3>
                                <div class="row"> 
                                    <div class="col-lg-12 mb-20">
                                        <label>Tên khách hàng<span> *</span></label>
                                        <input readonly value="${sessionScope.acc.customerName}" placeholder="Nhập tên đầy đủ của bạn" type="text">
                                    </div>
                                    <div class="col-lg-12 mb-20">
                                        <label> Email <span> *</span></label>
                                        <input readonly value="${sessionScope.acc.customerEmail}" placeholder="Nhập email của bạn" type="text">
                                    </div>
                                    <div class="col-lg-12 mb-20">
                                        <label>Địa chỉ<span> *</span></label>
                                        <input required name="address" placeholder="Nhập địa chỉ của bạn" type="text">
                                    </div>
                                    <div class="col-lg-12 mb-20">
                                        <label>Số điện thoại<span> *</span></label>
                                        <input required id="phoneInput" name="phone" placeholder="Nhập số điện thoại của bạn" type="text">
                                    </div>
                                    <div id="ValidationMessage" style="color: red;"></div>
                                </div>
                            </div>
                            <div class="col-lg-7 col-md-7"> 
                                <h3>Sản phẩm</h3>
                                <div class="order_table table-responsive">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>Product</th>
                                                <th>Quantity</th> 
                                                <th>Total</th>
                                            </tr>
                                        </thead>
                                        <tbody> 
                                            <c:forEach items="${cart.getAllItem()}" var="c">
                                                <tr>
                                                    <td> ${c.product.product_name}</td>
                                                    <td> ${c.quantity}</td> 
                                                    <td> <fmt:formatNumber value="${c.product.product_price * c.quantity}"/></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                        <tfoot> 
                                            <tr class="order_total">
                                                <th colspan="1">Tổng đơn</th>
                                                <td></td>
                                                <td><strong><fmt:formatNumber value="${cart.getTotalMoney()}"/></strong></td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                                <div class="order_button">
                                    <button id="buttonOrder" type="submit">Đặt hàng</button>
                                </div> 
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>
            document.getElementById('phoneInput').addEventListener('input', function() {
            var phoneNumber = document.getElementById('phoneInput').value;
            var message = document.getElementById('ValidationMessage'); 
            var buttonOrder = document.getElementById('buttonOrder');
            // Kiểm tra xem số điện thoại có đủ số không
            var match = phoneNumber.match(/^(\d{3})(\d{3})(\d{4})$/);
            if (match) {
                message.textContent = ''; 
                buttonOrder.disabled = false;
            } else { 
                message.textContent = 'Số điện thoại không hợp lệ. Vui lòng nhập số điện thoại hợp lệ (10 chữ số)';
                buttonOrder.disabled = true;
            }
        });
        </script>
        <jsp:include page="footer.jsp"/> 
        <script src="assets/js/plugins.js"></script> 
        <script src="assets/js/main.js"></script>
    </body> 
</html>
