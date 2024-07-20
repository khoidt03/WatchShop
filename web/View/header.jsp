 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
 
<!--header area start-->
<header class="header_area header_three">
    <!--header start-->
    <style>
        .text-logo{
            color: red;
            font-size: 40px;
        }
        .dropbtn-acc {
            background: inherit;
            font-size: 15px;
            font-weight: 400;
            text-transform: capitalize;
            color: black;
            border: 1px solid #ddd;
            padding: 10px 17px 8px;
            border-radius: 20px;
            display: block;
        } 
        .dropdown-acc { 
            color: #FFF;
            position: relative;
            display: inline-block;
        } 
        .dropdown-acc-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 2;
        } 
        .dropdown-acc-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        } 
        .dropdown-acc-content a:hover {
            background-color: #f1f1f1;
        } 
        .dropdown-acc:hover .dropdown-acc-content {
            display: block;
        }
        .dropdown-acc:hover .dropbtn-acc {
            color: #ff6a28;
        }
        .cart-count {
            color: red;
            font-weight: 600;
            font-size: 11px;
            position: absolute;
            top: -2px;
            right: 5px;
        }
    </style>
    <div class="header_middel">
        <div class="container-fluid">
            <div class="middel_inner">
                <div class="row align-items-center">
                    <div class="col-lg-4">
                        <div class="text-logo">
                            <a href="home">WATCHSTORE</a>
                        </div>
                        <!--<a href="home"><img src="https://www.g-store.vn/wp-content/uploads/2024/01/logoweb_whirte_c-min-1.png" style="width: 200px"></a>-->   
                    </div> 
                    <div class="col-lg-4"> 
                        <div class="search_bar">
                            <form action="product?action=search" method="POST">
                                <input name="textSearch" value="${requestScope.textSearch}" placeholder="Tìm kiếm..." type="text">
                                <button type="submit"><i class="ion-ios-search-strong"></i></button>
                            </form>
                        </div>
                    </div> 
                    <div class="col-lg-4"> 
                        <div class="cart_area">
                            <div class="cart_link">
                                <a href="cart"><i class='bx bx-cart'></i>Giỏ Hàng</a>
                                <c:if test="${cartSize != 0}"> 
                                    <span class="cart-count">${cartSize}+</span>
                                </c:if>
                            </div> 
                            
                            <div class="cart_link">
                                <c:if test="${acc.customerName == null}">
                                    <a href="login"><i class='bx bx-user'></i>Đăng Nhập</a>
                                </c:if> 
                            </div> 
                            <c:if test="${acc.customerName != null}">
                                <div class="dropdown-acc">
                                    <button class="dropbtn-acc"><i class='bx bx-user' ></i>${acc.customerName}</button>
                                    <div class="dropdown-acc-content">
                                        <a href="profile">Profile</a>
                                        <c:if test="${acc.role == 1}">
                                            <a href="dashboard">Admin Panel</a>
                                        </c:if>
                                        <a href="logout">Đăng Xuất</a>
                                    </div>
                                </div>
                            </c:if> 
                        </div>
                        </div>   
                    </div>
                </div>
            </div> 
            <div class="horizontal_menu">
                <div class="left_menu">
                    <div class="main_menu"> 
                        <nav>  
                            <ul>
                                <li><a href="home">Trang chủ<i class="fa"></i></a>
                                </li>
                                <li class="mega_items"><a href="product">Sản phẩm</a>
                                </li>
                            </ul> 
                        </nav> 
                    </div>
                </div> 
            </div>
        </div>
    </div>
    <!--header middel end-->

    <!--header bottom satrt-->
    <div class="header_bottom sticky-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12">
                    <div class="main_menu_inner">
                        <div class="main_menu"> 
                            <nav>  
                                <ul>
                                    <li class="active"><a href="home">Trang chủ</a></li>
                                    <li><a href="product">Sản phẩm</a></li> 
                                </ul>   
                            </nav> 
                        </div>
                    </div> 
                </div>
            </div>
        </div>
    </div>
    <!--header bottom end-->
</header>