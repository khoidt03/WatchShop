 
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Thêm Sản Phẩm</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico"> 
        <link rel="stylesheet" type="text/css" href="admin/css/main.css"> 
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css"> 
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css"> 
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="http://code.jquery.com/jquery.min.js" type="text/javascript"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
        
    </head> 
    <body class="app sidebar-mini rtl"> 
        </style>
        <!-- Navbar-->
        <header class="app-header">
            <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a> 
            <ul class="app-nav">  
                <li>
                    <a class="app-nav__item" href="dashboard"><i class='bx bx-log-out bx-rotate-180'></i></a>
                </li>
            </ul>
        </header> 
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
                <div class="app-sidebar__user">
                    <img class="app-sidebar__user-avatar" src="admin/images/user.png" width="50px" alt="User Image">
                <div>
                    <p class="app-sidebar__user-name"><b>Xin chào, ${sessionScope.acc.customerName}</b></p> 
                </div>
            </div>
            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item" href="dashboard"><i class='app-menu__icon bx bxs-dashboard'></i><span
                            class="app-menu__label">Bảng điều khiển</span></a></li>
                <li><a class="app-menu__item" href="customer"><i class='app-menu__icon bx bxs-user-detail'></i><span
                            class="app-menu__label">Quản lý khách hàng</span></a></li>
                <li><a class="app-menu__item" href="productmanager"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a>
                </li>
                <li><a class="app-menu__item" href="ordermanager"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Quản lý đơn hàng</span></a></li> 
            </ul>
        </aside>
        <main class="app-content">  
            <c:if test="${message != null}">
            <script>
                    Swal.fire({
                    title: "Thông Báo",
                    text: "Thêm sản phẩm mới thành công.",
                    icon: "success",
                    timer: 1000
           });
            </script> 
            </c:if>
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="productmanager">Danh sách sản phẩm</a></li>
                    <li class="breadcrumb-item"><a href="#">Thêm sản phẩm</a></li>
                </ul>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Thêm sản phẩm</h3> 
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" data-toggle="modal" data-target="#adddanhmuc"><i
                                            class="fas fa-folder-plus"></i> Thêm danh mục</a>
                                </div> 
                            </div>   
                            <form class="row" action="addproduct?type=product" method="POST" enctype="multipart/form-data">
                                <div class="form-group col-md-3">
                                    <label class="control-label">Mã sản phẩm </label>
                                    <input class="form-control" name="product_id" type="text" placeholder="Nhập mã sản phẩm" required>
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="exampleSelect1" class="control-label">Danh mục</label> 
                                    <select name="category_id" class="form-control" id="exampleSelect1">
                                        <option>-- Chọn danh mục --</option>
                                        <c:forEach items="${categoryAll}" var="c">
                                            <option value="${c.category_id}">${c.category_name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Tên sản phẩm</label>
                                    <input class="form-control" name="product_name" type="text" placeholder="Nhập tên sản phẩm" required>
                                </div>
                                <div class="form-group  col-md-3">
                                    <label class="control-label">Giá bán</label>
                                    <div id="validationPrice" style="color: red;"></div>
                                    <input id="inputPrice" class="form-control" name="price" type="number"placeholder="Nhập giá sản phẩm" required >
                                </div>  
                                <div class="form-group  col-md-3">
                                    <label class="control-label">Số lượng </label>
                                    <div id="validationQuantity"style="color: red;"></div>
                                    <input id="inputQuantity" class="form-control" name="quantity" type="number" placeholder="Nhập số lượng" required>
                                </div> 
                                <div class="form-group col-md-3">
                                    <label class="control-label">Ảnh sản phẩm</label> 
                                    <input class="form-control" name="image" type="file" onchange="previewImage(event)" accept="image/*" required >  
                                </div>
                                <img id="preview" src="#" alt="Ảnh mô tả" style="display: none; max-width: 100px; max-height: 100px;">
                                <div class="form-group col-md-12">
                                    <label class="control-label">Mô tả sản phẩm</label>
                                    <textarea class="form-control" name="describe" id="describe" placeholder="Nhập mô tả sản phẩm" required></textarea>
                                </div>
                                <button id="saveProduct"  class="btn btn-save" type="submit">Lưu lại</button>
                                &nbsp;
                                <a class="btn btn-cancel" href="productmanager">Hủy bỏ</a>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </main> 
        <div class="modal fade" id="adddanhmuc">
            <div class="modal-dialog modal-dialog-centered" >
                <div class="modal-content"> 
                    <div class="modal-body">
                        <div class="row">
                            <div class="form-group  col-md-12">
                                <span class="thong-tin-thanh-toan">
                                    <h5>Thêm mới danh mục </h5>
                                </span>
                            </div> 
                            <div class="form-group col-md-12" >

                                <h2 style="color: red; padding-left: 10px">
                                    ${error}</h2>
                                <label class="control-label">Nhập tên danh mục mới</label>
                                <form action="addproduct?type=category" method="post"> 
                                    <input class="form-control" type="text" name="category_name" required>
                                    <br>
                                    <button class="btn btn-save" type="submit">Lưu lại</button>
                                    <a class="btn btn-cancel" data-dismiss="modal" href="#">Hủy bỏ</a>
                                </form>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label">Danh mục sản phẩm hiện đang có</label>
                                <ul style="padding-left: 20px;">
                                    <c:forEach items="${categoryAll}" var="c">
                                        <li>${c.category_name}</li>
                                        </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                                
        <script>
            document.getElementById('inputQuantity').addEventListener('input', function (){
                var button = document.getElementById('saveProduct');
                var quantity = document.getElementById('inputQuantity');
                var validation = document.getElementById('validationQuantity');
                if(quantity.value < 1){
                    validation.textContent = "Số lượng sản phẩm phải lớn hơn 0";
                    button.disabled = true;
                }
                else{
                    validation.textContent = "";
                    button.disabled = false;
                }
            });
            document.getElementById('inputPrice').addEventListener('input', function (){
                var button = document.getElementById('saveProduct');
                var price = document.getElementById('inputPrice');
                var validation = document.getElementById('validationPrice');
                if(price.value < 1){
                    validation.textContent = "Giá sản phẩm phải lớn hơn 0";
                    button.disabled = true;
                }
                else{
                    validation.textContent = "";
                    button.disabled = false;
                }
            });
            function previewImage(event) {
                var input = event.target;
                var preview = document.getElementById('preview');   
                var reader = new FileReader();
                reader.onload = function(){
                preview.src = reader.result;
                preview.style.display = 'block';
            };
                reader.readAsDataURL(input.files[0]);
            }
            function showMessage(message){
                Swal.fire({
                    position: "top-end",
                    icon: "success",
                    title: message,
                    showConfirmButton: false,
                    timer: 1500
                });
            }
        </script>
        <script src="admin/js/jquery-3.2.1.min.js"></script>
        <script src="admin/js/popper.min.js"></script>
        <script src="admin/js/bootstrap.min.js"></script>
        <script src="admin/js/main.js"></script>
        <script src="admin/js/plugins/pace.min.js"></script> 
    </body>

</html>
