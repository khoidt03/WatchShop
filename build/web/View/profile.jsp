 

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>My Account</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico"> 
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="assets/css/plugins.css"> 
        <link rel="stylesheet" href="assets/css/style.css"> 
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    </head> 
    <body> 
        <div class="off_canvars_overlay"> 
        </div>
        <jsp:include page="header.jsp"/> 
        <div class="breadcrumbs_area other_bread">
            <div class="container">   
                <div class="row">
                    <div class="col-12">
                        <div class="breadcrumb_content">
                            <ul>
                                <li><a href="home">home</a></li>
                                <li>/</li>
                                <li>My Account</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>         
        </div>
        <!--breadcrumbs area end--> 
        <!-- my account start  -->
        <section class="main_content_area">
            <div class="container">   
                <div class="account_dashboard"> 
                    <div class="row">
                        <div class="col-sm-12 col-md-3 col-lg-3">
                            <!-- Nav tabs -->
                            <div class="dashboard_tab_button">
                                <ul role="tablist" class="nav flex-column dashboard-list">
                                    <li class="active"><a href="#account-details" data-toggle="tab" class="nav-link">Tài khoản của tôi</a></li>
                                    <li> <a href="#orders" data-toggle="tab" class="nav-link">Đơn hàng</a></li>
                                    <li><a href="logout" class="nav-link">Đăng xuất</a></li>
                                </ul>
                            </div>    
                        </div>
                        <div class="col-sm-12 col-md-12 col-lg-9">
                            <!-- Tab panes -->
                            <div class="tab-content dashboard_content"> 
                                <div class="tab-pane fade" id="orders"> 
                                    <div class="table-responsive">
                                        <c:if test="${requestScope.orderList.isEmpty()}">
                                            <i style=" display: flex; justify-content: center;align-items: center; ; font-size: 40px" class='bx bx-cart-alt'></i>
                                            <h4 style="text-align: center; color: red; font-size: 16px">Đơn hàng trống!</h4>
                                        </c:if>
                                        <c:if test="${!requestScope.orderList.isEmpty()}"> 
                                        <table class="table"> 
                                            <thead>
                                                <tr>
                                                    <th style="width: 30px">Mã đơn hàng</th>
                                                    <th>Ngày khởi tạo</th> 
                                                    <th>Total</th>
                                                    <th>Trạng thái</th>
                                                    <th>Hành Động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${orderList}" var="o">
                                                    <tr>
                                                        <td onclick="showDetail(${o.orderID})">${o.orderID}</td>
                                                        <td>${o.orderDate}</td> 
                                                        <td><fmt:formatNumber value="${o.total}"/></td>
                                                        <td>${o.orderStatus.getName()}</td>
                                                        <td> 
                                                            <c:if test="${o.orderStatus.getId() == 1}">
                                                                <form id="cancelOrder" method="post" >
                                                                    <button type="button" onclick="cancelOrder(${o.orderID})" class="btn btn-danger">Hủy Đơn</button>
                                                                </form>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" id="${o.orderID}" style="color: chocolate; display: none">
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
                                        </c:if>
                                    </div>
                                </div> 
                                <div class="tab-pane fade show active" id="account-details"> 
                                    <div class="login_form_container">
                                            <div class="account_login_form">
                                                <label><i class='bx bx-user-circle'></i>Username</label>
                                                <input readonly type="text" name="user_name" value="${sessionScope.acc.customerName}">
                                                <label><i class='bx bx-envelope' ></i>Email</label>
                                                <input type="text" readonly name="user_email" value="${sessionScope.acc.customerEmail}">
                                                <label><i class='bx bx-lock' ></i>Password</label>
                                                <input readonly type="password" name="user_pass" value="${sessionScope.acc.customerPass}"> 
                                                <c:if test="${requestScope.message != null}">
                                                    <label style="color: red">${requestScope.message}</label><br>
                                                </c:if>
                                                <div class="button">
                                                    <a data-toggle="modal" data-target="#myModal">Đổi mật khẩu</a>
                                                </div> 
                                            </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>  
            </div>        	
        </section>                          
        <!-- my account end   --> 
        <!--footer area start--> 
        <!--footer area end--> 
        <div class="modal" id="myModal">
            <div class="modal-dialog">
                <div class="modal-content">  
                    <div class="modal-header">
                        <h4 class="modal-title">Thay đổi mật khẩu</h4> 
                    </div>  
                    <div class="modal-body account_login_form">
                        <form method="post" action="profile">
                            <label>Mật khẩu cũ </label>
                            <input type="password"name="oldpass"> 
                            <label>Mật khẩu mới </label>
                            <input type="text" name="newpass""> 
                            <label>Xác nhận mật khẩu </label>
                            <input type="text" name="repass"> 
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-info" >Lưu thay đổi</button>
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                            </div> 
                        </form> 
                    </div>   
                </div>
            </div>
        </div>
        <script>
                function showDetail(detailTable){
                    var detailsRow  = document.getElementById(detailTable);
                    detailsRow.style.display = (detailsRow.style.display === 'none' || detailsRow.style.display === '') ? 'table-row' : 'none';
                }
                function cancelOrder (orderID){
                var form = document.getElementById('cancelOrder');
                form.action = "ordermanager?oID=" + orderID + "&type=4";
                Swal.fire({
                  title: "Thông Báo",
                  text: "Bạn có chắc muốn hủy đơn hàng này không ?",
                  icon: "warning",
                  showCancelButton: true,
                  confirmButtonColor: "#3085d6",
                  cancelButtonColor: "#d33",
                  confirmButtonText: "OK"
                }).then((result) => {
                  if (result.isConfirmed) { 
                    Swal.fire({
                      title: "Thông Báo",
                      text: "Hủy đơn hàng thành công !",
                      icon: "success",
                      timer: 1500,
                      onClose: () =>{
                           form.submit(); 
                      }
                    }); 
                  }
                });
            };
        </script>
        <script src="assets/js/plugins.js"></script> 
        <script src="assets/js/main.js"></script> 
    </body>

</html>
