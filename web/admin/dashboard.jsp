
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en"> 
    <head>
        <title>Dashboard</title>
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
    </head> 
    <body class="app sidebar-mini rtl">
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav"> 
                <!-- User Menu-->
                <li>
                    <a class="app-nav__item" href="home"><i class='bx bx-log-out bx-rotate-180'></i></a> 
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
            <div class="row">
                <div class="col-md-12">
                    <div class="app-title">
                        <ul class="app-breadcrumb breadcrumb">
                            <li class="breadcrumb-item"><a href="#"><b>Control Panel</b></a></li>
                        </ul>
                        <div id="clock"></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <div class="row">
                        <!-- col-6 -->
                        <div class="col-md-3">
                            <div class="widget-small primary coloured-icon"><i class='icon bx bx-user fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng khách hàng</h4>
                                    <p><b>${requestScope.customerList.size()} khách hàng</b></p> 
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">   
                            <div class="widget-small info coloured-icon"><i class='icon bx bx-money-withdraw fa-3x'></i>
                                <div class="info">
                                    <h4>Doanh thu tháng</h4>
                                    <p><b><fmt:formatNumber value="${requestScope.totalMonth}"/> VNĐ</b></p>  
                                </div>
                            </div>
                        </div>              
                        <!-- col-6 -->
                        <div class="col-md-3">
                            <div class="widget-small info coloured-icon"><i class='icon bx bxs-data fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng sản phẩm</h4>
                                    <p><b>${requestScope.productList.size()} sản phẩm</b></p> 
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">  
                            <div class="widget-small info coloured-icon"><i class='icon bx bxs-shopping-bag fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng đơn hàng</h4>
                                    <p><b>${requestScope.totalOrder} đơn hàng</b></p> 
                                </div>
                            </div>
                        </div> 
                        <!-- col-6 -->  
                    </div>
                </div>
                <div style="width: 80%">
                    <canvas id="totalRevenue"></canvas>
                </div>  
            </div>               
        </main>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"> </script>
        <script type="text/javascript">
            document.addEventListener("DOMContentLoaded", function() {
            var chart = document.getElementById("totalRevenue").getContext("2d");
            var myChart = new Chart(chart, {
            type: "bar",
            data: {
            labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", 
                     "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"],
            datasets: [{
                label: "Doanh thu các tháng",
                backgroundColor: "blue",
                data: [${requestScope.t1}, ${requestScope.t2}, ${requestScope.t3}, ${requestScope.t4}, 
                       ${requestScope.t5}, ${requestScope.t6}, ${requestScope.t7}, ${requestScope.t8},
                       ${requestScope.t9}, ${requestScope.t10}, ${requestScope.t11}, ${requestScope.t12}],
                }]
            },
            options: {}
        }); 
        });
        </script>
        <script src="admin/js/jquery-3.2.1.min.js"></script> 
        <script src="admin/js/popper.min.js"></script>
        <script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script> 
        <script src="admin/js/bootstrap.min.js"></script> 
        <script src="admin/js/main.js"></script> 
        <script src="admin/js/plugins/pace.min.js"></script> 
    </body>

</html>