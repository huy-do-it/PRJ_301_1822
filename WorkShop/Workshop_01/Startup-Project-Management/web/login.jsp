<%-- 
    Document   : login
    Created on : Jun 22, 2025, 9:34:50 PM
    Author     : ddhuy
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cosmic Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            overflow: hidden;
            background: linear-gradient(135deg, #0c0c0c 0%, #1a1a2e 25%, #16213e 50%, #0f3460 75%, #533a7d 100%);
            position: relative;
        }

        /* Animated Stars Background */
        .stars {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
        }

        .star {
            position: absolute;
            background: white;
            border-radius: 50%;
            animation: twinkle 3s infinite;
        }

        .star:nth-child(1) { top: 20%; left: 20%; width: 2px; height: 2px; animation-delay: 0s; }
        .star:nth-child(2) { top: 80%; left: 80%; width: 1px; height: 1px; animation-delay: 1s; }
        .star:nth-child(3) { top: 40%; left: 70%; width: 3px; height: 3px; animation-delay: 2s; }
        .star:nth-child(4) { top: 60%; left: 10%; width: 2px; height: 2px; animation-delay: 0.5s; }
        .star:nth-child(5) { top: 10%; left: 60%; width: 1px; height: 1px; animation-delay: 1.5s; }
        .star:nth-child(6) { top: 90%; left: 30%; width: 2px; height: 2px; animation-delay: 2.5s; }
        .star:nth-child(7) { top: 30%; left: 90%; width: 1px; height: 1px; animation-delay: 0.3s; }
        .star:nth-child(8) { top: 70%; left: 50%; width: 2px; height: 2px; animation-delay: 1.8s; }
        .star:nth-child(9) { top: 50%; left: 20%; width: 1px; height: 1px; animation-delay: 0.8s; }
        .star:nth-child(10) { top: 25%; left: 40%; width: 3px; height: 3px; animation-delay: 2.2s; }

        @keyframes twinkle {
            0%, 100% { opacity: 0.3; transform: scale(1); }
            50% { opacity: 1; transform: scale(1.2); }
        }

        /* Floating Planets */
        .planet {
            position: absolute;
            border-radius: 50%;
            animation: float 20s infinite linear;
        }

        .planet1 {
            top: 10%;
            left: -100px;
            width: 60px;
            height: 60px;
            background: radial-gradient(circle at 30% 30%, #ff6b6b, #ee5a24);
            box-shadow: 0 0 30px rgba(255, 107, 107, 0.5);
            animation-duration: 25s;
        }

        .planet2 {
            top: 70%;
            left: -80px;
            width: 40px;
            height: 40px;
            background: radial-gradient(circle at 30% 30%, #4834d4, #686de0);
            box-shadow: 0 0 25px rgba(72, 52, 212, 0.5);
            animation-duration: 30s;
            animation-delay: -10s;
        }

        .planet3 {
            top: 45%;
            left: -120px;
            width: 80px;
            height: 80px;
            background: radial-gradient(circle at 30% 30%, #f0932b, #eb4d4b);
            box-shadow: 0 0 35px rgba(240, 147, 43, 0.5);
            animation-duration: 35s;
            animation-delay: -20s;
        }

        @keyframes float {
            0% { transform: translateX(0) rotate(0deg); }
            100% { transform: translateX(calc(100vw + 200px)) rotate(360deg); }
        }

        /* Main Container */
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            position: relative;
            z-index: 10;
        }

        /* Login Form */
        .login-form {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 40px;
            width: 400px;
            box-shadow: 
                0 8px 32px rgba(0, 0, 0, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.2);
            animation: slideIn 1s ease-out;
            position: relative;
            overflow: hidden;
        }

        .login-form::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        @keyframes slideIn {
            0% { 
                opacity: 0; 
                transform: translateY(50px) scale(0.9);
            }
            100% { 
                opacity: 1; 
                transform: translateY(0) scale(1);
            }
        }

        .login-form h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #fff;
            font-size: 28px;
            font-weight: 300;
            text-shadow: 0 0 20px rgba(255, 255, 255, 0.5);
            animation: glow 2s ease-in-out infinite alternate;
        }

        @keyframes glow {
            from { text-shadow: 0 0 20px rgba(255, 255, 255, 0.5); }
            to { text-shadow: 0 0 30px rgba(255, 255, 255, 0.8), 0 0 40px rgba(255, 255, 255, 0.3); }
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group input {
            width: 100%;
            padding: 15px 20px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 12px;
            color: #fff;
            font-size: 16px;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .form-group input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .form-group input:focus {
            outline: none;
            border-color: rgba(255, 255, 255, 0.6);
            box-shadow: 
                0 0 20px rgba(255, 255, 255, 0.3),
                inset 0 0 20px rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }

        .submit-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
            position: relative;
            overflow: hidden;
        }

        .submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .submit-btn:hover::before {
            left: 100%;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 25px rgba(102, 126, 234, 0.6);
        }

        .submit-btn:active {
            transform: translateY(-1px);
        }

        .error{
            margin-top: 20px;
            padding: 15px;
            background: rgba(255, 82, 82, 0.1);
            border: 1px solid rgba(255, 82, 82, 0.3);
            border-radius: 8px;
            color: #ff5252;
            text-align: center;
            backdrop-filter: blur(10px);
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(10px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        /* Cosmic Dust Effect */
        .cosmic-dust {
            position: absolute;
            width: 100%;
            height: 100%;
            pointer-events: none;
        }

        .dust-particle {
            position: absolute;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 50%;
            animation: drift 15s infinite linear;
        }

        .dust-particle:nth-child(1) { top: 10%; left: 0%; width: 1px; height: 1px; animation-delay: 0s; animation-duration: 20s; }
        .dust-particle:nth-child(2) { top: 30%; left: 0%; width: 2px; height: 2px; animation-delay: 2s; animation-duration: 25s; }
        .dust-particle:nth-child(3) { top: 50%; left: 0%; width: 1px; height: 1px; animation-delay: 4s; animation-duration: 18s; }
        .dust-particle:nth-child(4) { top: 70%; left: 0%; width: 3px; height: 3px; animation-delay: 6s; animation-duration: 22s; }
        .dust-particle:nth-child(5) { top: 90%; left: 0%; width: 1px; height: 1px; animation-delay: 8s; animation-duration: 26s; }

        @keyframes drift {
            0% { 
                transform: translateX(-10px) translateY(0px);
                opacity: 0;
            }
            10% { opacity: 1; }
            90% { opacity: 1; }
            100% { 
                transform: translateX(100vw) translateY(-100px);
                opacity: 0;
            }
        }

        /* Responsive */
        @media (max-width: 480px) {
            .login-form {
                width: 90%;
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Stars Background -->
    <div class="stars">
        <div class="star"></div>
        <div class="star"></div>
        <div class="star"></div>
        <div class="star"></div>
        <div class="star"></div>
        <div class="star"></div>
        <div class="star"></div>
        <div class="star"></div>
        <div class="star"></div>
        <div class="star"></div>
    </div>

    <!-- Floating Planets -->
    <div class="planet planet1"></div>
    <div class="planet planet2"></div>
    <div class="planet planet3"></div>

    <!-- Cosmic Dust -->
    <div class="cosmic-dust">
        <div class="dust-particle"></div>
        <div class="dust-particle"></div>
        <div class="dust-particle"></div>
        <div class="dust-particle"></div>
        <div class="dust-particle"></div>
    </div>

    <div class="container">
        <div class="login-form">
            <h2>HAVE A NICE DAY!</h2>
            <form action="MainController" method="post">
                <input type="hidden" name="action" value="login">
                
                <div class="form-group">
                    <input type="text" name="userName" placeholder="Username" required>
                </div>
                
                <div class="form-group">
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                
                <button type="submit" class="submit-btn">Login</button>
            </form>
            
            <c:if test="${not empty message}">
                <div class="error">${message}</div>
            </c:if>
        </div>
    </div>
</body>
</html>