 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>WatchShop | Đăng Kí</title>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'> 
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    </head>
    <style>
        @import URL("https://fonts.googleapis.com/css?family=Poppins:wght@300;400;500;600;700;800;900&display=swap");
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", sans-serif;
        }
        body{
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: linear-gradient(44deg, rgba(243, 243, 243, 0.05) 0%, rgba(243, 243, 243, 0.05) 33.333%,rgba(79, 79, 79, 0.05) 33.333%, rgba(79, 79, 79, 0.05) 66.666%,rgba(9, 9, 9, 0.05) 66.666%, rgba(9, 9, 9, 0.05) 99.999%),linear-gradient(97deg, rgba(150, 150, 150, 0.05) 0%, rgba(150, 150, 150, 0.05) 33.333%,rgba(34, 34, 34, 0.05) 33.333%, rgba(34, 34, 34, 0.05) 66.666%,rgba(40, 40, 40, 0.05) 66.666%, rgba(40, 40, 40, 0.05) 99.999%),linear-gradient(29deg, rgba(56, 56, 56, 0.05) 0%, rgba(56, 56, 56, 0.05) 33.333%,rgba(226, 226, 226, 0.05) 33.333%, rgba(226, 226, 226, 0.05) 66.666%,rgba(221, 221, 221, 0.05) 66.666%, rgba(221, 221, 221, 0.05) 99.999%),linear-gradient(90deg, rgb(163, 238, 211),rgb(149, 75, 252));
            background-size: cover;
            background-position: center;
        }
        .wrapper{
            width: 420px;
            background: transparent;
            border: 2px solid rgba(255, 255, 255, .2); 
            box-shadow: 0 0 10px rgba(0, 0, 0, .2);
            color: #FFF;
            border-radius: 10px;
            padding: 30px 40px;
        }
        .wrapper h1{
            font-size: 26px;
            text-align: center;
        }
        .wrapper .input-box{
            position: relative;
            width: 100%;
            height: 50px;
            margin: 20px 0;
        }
        .input-box input{
            width: 100%;
            height: 100%;
            background: transparent;
            border: none;
            outline: none;
            border: 2px solid rgba(255, 255, 255, .2);
            border-radius: 40px;
            color: #fff;
            padding: 20px 40px 20px 20px;
        }
        .input-box input::placeholder{
            color: #fff; 
        }
        .input-box i{
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 20px;
        }
        .wrapper .remember-forgot{
            display: flex;
            justify-content: space-between;
            font-size: 14.5px;
            margin: -5px 0 20px;
        }
        .remember-forgot label input{
            color: #fff;
            margin-right: 3px;
        }
        .remember-forgot a{
            color: #FFF;
            text-decoration: none;
        }
        .remember-forgot a:hover{
            text-decoration: underline;
        }
        .wrapper .btn{
            width: 100%;
            height: 45px;
            background: #5bc0de;
            border: none;
            outline: none;
            border-radius: 40px;
            box-shadow: 0 0 10px rgba(0, 0, 0, .1);
            cursor: pointer;
            font-size: 16px;
            color: #333;
            font-weight: 600;
        }
        .wrapper .register-link{
            font-size: 14.5px;
            text-align: center;
            margin: 20px 0 15px;
        }
        .register-link p a{
            color: #fff;
            text-decoration: none; 
        }
        .register-link p a:hover{
            text-decoration: underline;
        }
        .wrapper .backhome{ 
            text-align: center;
        }
        .backhome a {
            text-decoration: none; 
        }
    </style>
    <body>
        <div class="wrapper">
            <form action="register" method="post">
                <h1>Create new   account</h1>
                <diV class="input-box">
                    <input name="email" type="text" placeholder="Enter email" required>
                    <i class='bx bx-envelope' ></i>
                </div>
                <diV class="input-box">
                    <input name="user" type="text" placeholder="Enter username" required>
                    <i class='bx bxs-user'></i>
                </div>
                <diV class="input-box">
                    <input name="pass" type="password" placeholder="Enter password" required>
                    <i class='bx bx-lock' ></i>
                </div> 
                <diV class="input-box">
                    <input name="re-pass" type="password" placeholder="Enter password again" required>
                    <i class='bx bx-lock' ></i>
                </div> 
                <div class="alert alert-danger" ${requestScope.message == null ? "hidden":""}>
                    ${requestScope.message}
                </div>
                <button type="submit" class="btn"><i class='bx bxs-user-plus'></i> Register</button>
                <div class="register-link">
                    <p>Already have an account ? <a href="login">Login</a></p> 
                </div> 
                <div class="backhome"> 
                    <a href="home"><i class='bx bx-home'></i>Back To Home</a>
                </div>
            </form>
        </div>
    </body>
</html>
