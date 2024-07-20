
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Quản Lí Khách Hàng</title>
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
            <!-- Sidebar toggle button-->
            <a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
               aria-label="Hide Sidebar"></a>
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
                    <li class="breadcrumb-item active"><a href="#"><b>Danh sách người dùng</b></a></li>
                </ul> 
            </div> 
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body"> 
                            <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0"
                                   id="sampleTable">
                                <thead>
                                    <tr>
                                        <th>ID khách hàng</th>
                                        <th>Tên khách hàng</th>
                                        <th>Email</th>
                                        <th>Role</th>
                                        <th width="90">Tính năng</th>
                                    </tr>
                                </thead>
                                <tbody> 
                                    <c:forEach items="${customerList}" var="c">
                                        <tr>
                                            <td>${c.customerID}</td>
                                            <td>${c.customerName}</td>
                                            <td>${c.customerEmail}</td>
                                            <td>${c.role == 1 ? "Admin":"Customer"}</td>
                                            <td>
                                                <c:if test="${c.customerID != acc.customerID}">
                                                <form id="dialogForm" method="post"> 
                                                <button onclick="showConfirmDialog(${c.customerID},'set')" 
                                                    class="btn btn-primary btn-sm edit" type="button" value="${c.role == 1 ? "setAdmin":"setUser"}"> 
                                                <i class='bx bx-cog'></i>
                                                </button>  
                                                <button onclick="showConfirmDialog(${c.customerID},'delete')" 
                                                    class="btn btn-primary btn-sm trash" type="button"> <i class='fas fa-trash'></i></button>  
                                                </form>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table> 
                        </div>
                    </div>
                </div>
            </div>
        </main> 
        <script>
                function showConfirmDialog(cID, action) {
                var form = document.getElementById("dialogForm");
                var message1 = action == "set" ? "Bạn có muốn thay đổi quyền cho khách hàng này ?":"Bạn có chắc chắn muốn xóa khách hàng này ?";
                var message2 = action == "set" ? "Thay đổi thông tin khách hàng thành công !":"Xóa khách hàng thành công !";
                form.action = "customer?action=" + action + "&cID=" + cID;   
                Swal.fire({
                  title: "Thông Báo",
                  text: message1,
                  icon: "warning",
                  showCancelButton: true,
                  confirmButtonColor: "#3085d6",
                  cancelButtonColor: "#d33",
                  confirmButtonText: "OK"
                }).then((result) => {
                  if (result.isConfirmed) { 
                    Swal.fire({
                      title: "Thông Báo",
                      text: message2,
                      icon: "success",
                      timer: 1500,
                      onClose: () =>{
                           form.submit(); 
                      }
                    }); 
                  }
                });
              }
        </script>        
        <script src="admin/js/jquery-3.2.1.min.js"></script>
        <script src="admin/js/popper.min.js"></script>
        <script src="admin/js/bootstrap.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="admin/js/main.js"></script>
        <!-- The javascript plugin to display page loading on top-->
        <script src="admin/js/plugins/pace.min.js"></script>
        <!-- Page specific javascripts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!-- Data table plugin-->
        <script type="text/javascript" src="admin/js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="admin/js/plugins/dataTables.bootstrap.min.js"></script>
        <script type="text/javascript">$('#sampleTable').DataTable();</script> 
    </body>

</html>
