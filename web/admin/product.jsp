 

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en"> 
    <head>
        <title>Quản Lí Sản Phẩm</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <link rel="stylesheet" type="text/css" href="admin/css/main.css">
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico"> 
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css"> 
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css"> 
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css"> 
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    </head> 
    <body class="app sidebar-mini rtl">
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav"> 
                <!-- User Menu-->
                <li><a class="app-nav__item" href="home"><i class='bx bx-log-out bx-rotate-180'></i> </a> 
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
                <li>
                    <a class="app-menu__item" href="dashboard"><i class='app-menu__icon bx bxs-dashboard'></i>
                        <span class="app-menu__label">
                            Bảng điều khiển
                        </span>
                    </a>
                </li>
                <li>
                    <a class="app-menu__item" href="customer"><i class='app-menu__icon bx bxs-user-detail'></i>
                        <span class="app-menu__label">
                            Quản lý khách hàng
                        </span>
                    </a>
                </li>
                <li>
                    <a class="app-menu__item" href="productmanager"><i class='app-menu__icon bx bx-purchase-tag-alt'></i>
                        <span class="app-menu__label">
                            Quản lý sản phẩm</span>
                    </a>
                </li>
                <li>
                    <a class="app-menu__item" href="ordermanager"><i class='app-menu__icon bx bx-task'></i>
                        <span
                            class="app-menu__label">
                            Quản lý đơn hàng
                        </span>
                    </a>
                </li> 
            </ul>
        </aside>
        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a href="#"><b>Danh sách sản phẩm</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" href="addproduct" title="Thêm"><i class="fas fa-plus"></i>
                                        Thêm sản phẩm</a>
                                </div> 
                            </div> 
                            <form action="productmanager?action=updateproduct" method="POST">
                                <table class="table table-hover table-bordered" id="sampleTable">
                                    <thead>
                                        <tr>
                                            <th>Mã sản phẩm</th>
                                            <th>Danh mục</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Giá</th> 
                                            <th>Thông tin</th>
                                            <th>Số lượng</th>
                                            <th>Ảnh</th>
                                            <th>Chức năng</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${productList}" var="p">
                                            <tr>
                                                <td>${p.product_id}</td>
                                                <td>${p.category.category_name}</td>
                                                <td>${p.product_name}</td>
                                                <td><fmt:formatNumber value="${p.product_price}"/></td> 
                                                <td>${p.describe}</td>
                                                <td>${p.quantity}</td>
                                                <td><img src="${p.img}" alt="" width="100px;"></td> 
                                                <td>
                                                    <form id="dialogDelete" method="post">
                                                    <button 
                                                        class="btn btn-primary btn-sm trash" onclick="showConfirmDelete('${p.product_id}')" type="button" title="Xóa"><i class="fas fa-trash"></i>
                                                    </button> 
                                                    <button class="btn btn-primary btn-sm edit" type="button" title="Sửa" id="show-emp"
                                                            data-toggle="modal" data-target="#ModalEdit${p.product_id}"><i class="fas fa-edit"></i>
                                                    </button>
                                                    </form>
                                                </td>
                                            </tr> 
                                            <!-- 
                                        <!<!-- Modal edit -->
                                        <div class="modal fade" id="ModalEdit${p.product_id}">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">  
                                                    <form method="POST" action="productmanager?action=edit&pID=${p.product_id}" enctype="multipart/form-data">
                                                        <div class="modal-body">
                                                            <h3 style="margin: 15px 0 15px 0; text-align: center" class="tile-title">Chỉnh Sửa Sản Phẩm</h3>
                                                            <div class="form-group col-md-6">
                                                                <label class="control-label">Mã sản phẩm </label>
                                                                <input class="form-control" name="productID" type="text" value= ${p.product_id}>
                                                            </div>
                                                            <div class="form-group col-md-6"> 
                                                                <label for="exampleSelect1" class="control-label">Danh mục</label> 
                                                                <select name="categoryID" class="form-control" id="exampleSelect1"> 
                                                                    <c:forEach items="${categoryAll}" var="c">  
                                                                        <option value="${c.category_id}" ${c.category_name.equals(p.category.category_name) ? "selected":""} >${c.category_name}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="form-group col-md-6">
                                                                <label class="control-label">Tên sản phẩm</label>
                                                                <input class="form-control" name="productName" type="text" value= ${p.product_name}>
                                                            </div>
                                                            <div class="form-group  col-md-6">
                                                                <label class="control-label">Giá bán</label>
                                                                <input class="form-control" name="price" type="number"value= ${p.product_price}>
                                                            </div> 
                                                            <div class="form-group  col-md-6">
                                                                <label class="control-label">Số lượng</label>
                                                                <input class="form-control" name="quantity" type="number"value= ${p.quantity}>
                                                            </div>
                                                            <div class="form-group col-md-12">
                                                                <label class="control-label">Ảnh sản phẩm</label>
                                                                <input class="form-control" id="imageInput" name="image" type="file" onchange="previewImage(event)" accept="image/*" >   
                                                            </div>
                                                            <img id="preview" src="${p.img}" alt="Ảnh mô tả" style="max-width: 100px; max-height: 100px;">
                                                            <div class="form-group col-md-12">
                                                                <label class="control-label">Mô tả sản phẩm</label>
                                                                <textarea class="form-control" name="describe" id="describe">${p.describe}</textarea>
                                                            </div> 
                                                            <div>
                                                                <button class="btn btn-save" type="submit">Update</button>
                                                                <a class="btn btn-cancel"  href="productmanager">Hủy bỏ</a> 
                                                            </div>
                                                        </div>
                                                    </form>  
                                                </div>
                                            </div>
                                        </div>     
                                        <!--
                                      MODAL
                                        -->
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main> 
        <script> 
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
                function showConfirmDelete(product_id) {
                var form = document.getElementById("dialogDelete"); 
                form.action = "productmanager?action=delete&pID=" + product_id;
                Swal.fire({
                  title: "Thông Báo",
                  text: "Bạn có chắc chắn muốn xóa sản phẩm này ?",
                  icon: "warning",
                  showCancelButton: true,
                  confirmButtonColor: "#3085d6",
                  cancelButtonColor: "#d33",
                  confirmButtonText: "OK"
                }).then((result) => {
                  if (result.isConfirmed) { 
                    Swal.fire({
                      title: "Thông Báo",
                      text: "Xóa sản phẩm thành công",
                      icon: "success", 
                      timer: 1000,
                      onClose: () =>{
                          form.submit(); 
                      }
                    }); 
                  }
                });
              }
        </script>
        <!-- Essential javascripts for application to work-->
        <script src="admin/js/jquery-3.2.1.min.js"></script>
        <script src="admin/js/popper.min.js"></script>
        <script src="admin/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="admin/js/main.js"></script>
        <!-- The javascript plugin to display page loading on top-->
        <script src="admin/js/plugins/pace.min.js"></script>
        <!-- Page specific javascripts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!-- Data table plugin-->
        <script type="text/javascript" src="admin/js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="admin/js/plugins/dataTables.bootstrap.min.js"></script>  
        <!--<!-- add jQuery và DataTables vào -->
        <script type="text/javascript">$('#sampleTable').DataTable();</script>  
    </body>

</html>