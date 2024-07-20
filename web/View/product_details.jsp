 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Product details</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">  
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'> 
        <link rel="stylesheet" href="assets/css/plugins.css"> 
        <link rel="stylesheet" href="assets/css/style.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

    </head> 
    <body> 
        <!-- Main Wrapper Start --> 
        <div class="off_canvars_overlay"></div>
        <jsp:include page="header.jsp"/> 
        <!--breadcrumbs area start-->
        <div class="breadcrumbs_area product_bread">
            <div class="container">   
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb_content">
                            <ul>
                                <li><a href="home">Trang chủ</a></li>
                                <li>/</li>
                                <li><a href="product">Product</a></li>
                                <li>/</li>
                                <li>${ProductData.product_name}</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>         
        </div>
        <!--breadcrumbs area end--> 
        <!--product details start-->
        <div class="product_details">
            <div class="container"> 
                <div class="row">
                    <div class="col-lg-5 col-md-5">
                        <div class="product-details-tab"> 
                            <div id="img-1">
                                <a href="#">
                                    <img src="${ProductData.img}" data-zoom-image="${ProductData.img}" alt="product">
                                </a>
                            </div>
                        </div>
                    </div> 
                    <div class="col-lg-7 col-md-7">
                        <div class="product_d_right">
                            <form id="formCart" action="cart?action=add&pID=${ProductData.product_id}" method="POST">
                                <h1>${ProductData.product_name}</h1>
                                <div style="color:red" class="product_desc">
                                    <span class="current_price">
                                        <fmt:formatNumber value="${ProductData.product_price}"/> VNĐ 
                                    </span>
                                </div>
                                <div class="product_desc">
                                    <p>${ProductData.describe}</p>
                                </div> 
                                <div class="product_variant quantity">  
                                    <label>quantity</label>  
                                    <input id="inputQuantity" value="1" name="quantity" type="number">
                                    <button id="addCart" class="button" type="button"> <i class='bx bx-cart-add'></i>Thêm vào giỏ hàng</button>  
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>    
        </div>
        <!--product details end-->
        <!--product info end-->

        <!--product section area start-->
        <section class="product_section related_product">
            <div class="container">
                <div class="row">   
                    <div class="col-12">
                        <div class="section_title">
                            <h2>Sản phẩm tương tự</h2>
                        </div>
                    </div> 
                </div>     
                <div class="product_area"> 
                    <div class="row">
                        <div class="product_carousel product_three_column4 owl-carousel">
                            <c:forEach items="${ProductByCategory}" var="pc">
                                <div class="col-lg-3">
                                    <div class="single_product">
                                        <div class="product_thumb">
                                            <a class="primary_img" href="productdetails?pdetails_id=${pc.product_id}"><img src="${pc.img}" width="10px;" alt=""></a> 
                                        </div> 
                                        <div class="product_content">
                                            <h3><a href="productdetails?pdetails_id=${pc.product_id}">${pc.product_name}</a></h3>
                                            <div style="text-align: center"> 
                                                <span class="current_price">
                                                    <fmt:formatNumber value="${pc.product_price}"/> VNĐ  
                                                </span>
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
        <script>
            document.getElementById('inputQuantity').addEventListener('keydown', function(event) {
                if (event.key === 'Enter') {
                    event.preventDefault(); // Ngăn chặn hành động mặc định của phím Enter
                    document.getElementById('addCart').click(); // Kích hoạt sự kiện click trên nút "Thêm vào giỏ hàng"
                }
            });
            document.getElementById('addCart').addEventListener('click', function(){
                var form = document.getElementById('formCart');
                var message = "";
                var inputQuantity =  Number(document.getElementById('inputQuantity').value);
                var quantityCart = Number(${quantityCart});
                var quantityProduct = Number(${ProductData.quantity}); 
                console.log("cart: " + ( inputQuantity + quantityCart));
                console.log("product " + quantityProduct); 
                if(inputQuantity < 1){
                    message = "Số lượng sản phầm phải lớn hơn 0";
                } 
                else if(inputQuantity + quantityCart > quantityProduct){
                    message = "Số lượng sản phẩm trong kho chỉ còn " + quantityProduct;
                } 
                else if(inputQuantity + quantityCart <= quantityProduct){
                    message = "OK";
                    form.submit();
                    return;
                }
                Swal.fire({
                    title: "Thông Báo",
                    text: message,
                    icon: "error",
                    timer: 1500
                }); 
            })
        </script>
        <!--footer area start-->
        <jsp:include page="footer.jsp"/>
        <!--footer area end--> 
        <!-- Plugins JS -->
        <script src="assets/js/plugins.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 
        <!-- Main JS -->
        <script src="assets/js/main.js"></script> 
    </body>
    
</html>
