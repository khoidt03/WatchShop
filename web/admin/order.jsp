 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en"> 
    <head>
        <title>Quản Lí Đơn Hàng</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico"> 
        <link rel="stylesheet" type="text/css" href="admin/css/main.css">
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
                <img class="app-sidebar__user-avatar" src="admin/images/user.png" width="50px"alt="User Image">
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
                    <li class="breadcrumb-item active"><a href="#"><b>Danh sách đơn hàng</b></a></li>
                </ul> 
            </div>
            
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <div class="row">
                        <!-- col-6 -->
                        <div class="col-md-3">
                            <div class="widget-small info coloured-icon"><i class='icon bx bxs-shopping-bag fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng đơn chưa giao</h4>
                                    <p><b>${requestScope.orderPending} đơn hàng</b></p> 
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">   
                            <div class="widget-small info coloured-icon"><i class='icon bx bxs-shopping-bag fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng đơn đang giao</h4>
                                    <p><b>${requestScope.orderDelivery} đơn hàng</b></p> 
                                </div>
                            </div>
                        </div>              
                        <!-- col-6 -->
                        <div class="col-md-3">
                            <div class="widget-small info coloured-icon"><i class='icon bx bxs-shopping-bag fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng đơn thành công</h4>
                                    <p><b>${requestScope.orderSuccess} đơn hàng</b></p> 
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">  
                            <div class="widget-small info coloured-icon"><i class='icon bx bxs-shopping-bag fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng đơn bị hủy</h4>
                                    <p><b>${requestScope.orderCancel} đơn hàng</b></p> 
                                </div>
                            </div>
                        </div> 
                        <!-- col-6 -->  
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="tile"> 
                        <table class="table table-hover table-bordered" id="sampleTable">
                            <thead>
                                <tr>
                                    <th>Mã đơn hàng</th>
                                    <th>Khách hàng</th>
                                    <th>Số điện thoại</th>
                                    <th>Địa chỉ</th>
                                    <th>Ngày mua</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th> 
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orderList}" var="o">
                                    <tr>
                                        <td onclick="showDetail(${o.orderID})">${o.orderID}</td>
                                        <td>${acc.customerName}</td>
                                        <td>${o.phoneNumber}</td>
                                        <td>${o.address}</td>
                                        <td>${o.orderDate}</td>
                                        <td><fmt:formatNumber value="${o.total}"/></td>
                                        <td style="text-align: center">
                                            <form id="updateStatus" method="post">
                                                <select ${(o.orderStatus.getId() == 3 || o.orderStatus.getId() == 4  ) ? "disabled":""} onchange="dialogStatus(${o.orderID}, this)">
                                                <c:forEach items="${orderStatus}" var="od"> 
                                                    <option value="${od.id}" ${od.id == o.orderStatus.getId() ? "selected":""}>${od.name}</option>
                                                </c:forEach> 
                                            </select>
                                            </form>
                                        </td>    
                                    </tr>
                                    <tr>
                                        <td id="${o.orderID}" style="color: chocolate; display: none">
                                            <table id="sampleTable" >
                                                <thead>
                                                    <tr>
                                                        <th>Mã Đặt Hàng</th>
                                                        <th>Mã Sản Phẩm</th>
                                                        <th>Giá</th>
                                                        <th>Số Lượng</th> 
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${orderDetail}" var="od">
                                                        <c:if test="${od.orderID == o.orderID}">
                                                            <tr>
                                                                <td>${od.orderdetail_id}</td>
                                                                <td>${od.productID}</td>
                                                                <td><fmt:formatNumber value="${od.price}"/></td>  
                                                                <td>${od.quantity}</td>  
                                                            </tr>
                                                        </c:if> 
                                                    </c:forEach>
                                                </tbody>
                                            </table>
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
            function showDetail(detailTable){
                var detailsRow  = document.getElementById(detailTable);
                detailsRow.style.display = (detailsRow.style.display === 'none' || detailsRow.style.display === '') ? 'table-row' : 'none';
            }
            function dialogStatus(oID, selectElement) {
                var form = document.getElementById("updateStatus");  
                var selectedValue = selectElement.value; 
                form.action = "ordermanager?oID=" + oID + "&type=" + selectedValue; 
                Swal.fire({ 
                    title: "Thông Báo",
                    text: "Thay đổi trạng thái đơn hàng thành công !",
                    icon: "success",
                    timer: 1000,
                    onClose: () =>{
                        form.submit(); 
                    }
                });   
            } 
    </script>
         
    <script src="admin/js/jquery-3.2.1.min.js"></script>
    <script src="admin/js/popper.min.js"></script>
    <script src="admin/js/bootstrap.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="admin/js/main.js"></script> 
    <script src="admin/js/plugins/pace.min.js"></script> 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
    <!-- Data table plugin-->
    <script type="text/javascript" src="admin/js/plugins/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="admin/js/plugins/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript">$('#sampleTable').DataTable();</script> 
</body>

</html>
