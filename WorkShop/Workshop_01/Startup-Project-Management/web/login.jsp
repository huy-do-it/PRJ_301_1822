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
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                overflow: hidden;
            }

            /* Animated background elements */
            body::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
                background-size: 50px 50px;
                animation: backgroundMove 20s linear infinite;
                z-index: 1;
            }

            @keyframes backgroundMove {
                0% {
                    transform: translate(0, 0) rotate(0deg);
                }
                100% {
                    transform: translate(50px, 50px) rotate(360deg);
                }
            }

            .container {
                position: relative;
                z-index: 2;
                width: 100%;
                max-width: 400px;
                padding: 20px;
            }

            .login-form {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(20px);
                border-radius: 20px;
                padding: 40px;
                box-shadow:
                    0 20px 40px rgba(0, 0, 0, 0.1),
                    0 0 0 1px rgba(255, 255, 255, 0.2);
                border: 1px solid rgba(255, 255, 255, 0.3);
                animation: slideUp 0.8s ease-out;
            }

            @keyframes slideUp {
                0% {
                    opacity: 0;
                    transform: translateY(30px);
                }
                100% {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .login-form h2 {
                text-align: center;
                margin-bottom: 30px;
                color: #2d3748;
                font-size: 24px;
                font-weight: 700;
                letter-spacing: -0.5px;
                position: relative;
            }

            .login-form h2::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 60px;
                height: 3px;
                background: linear-gradient(90deg, #667eea, #764ba2);
                border-radius: 2px;
            }

            .form-group {
                margin-bottom: 20px;
                position: relative;
            }

            .form-group input {
                width: 100%;
                padding: 16px 20px;
                border: 2px solid #e2e8f0;
                border-radius: 12px;
                font-size: 16px;
                color: #2d3748;
                background: #ffffff;
                transition: all 0.3s ease;
                outline: none;
            }

            .form-group input:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
                transform: translateY(-2px);
            }

            .form-group input::placeholder {
                color: #a0aec0;
                font-weight: 400;
            }

            .submit-btn {
                width: 100%;
                padding: 16px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 12px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
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
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
                transition: left 0.5s ease;
            }

            .submit-btn:hover::before {
                left: 100%;
            }

            .submit-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
            }

            .submit-btn:active {
                transform: translateY(0);
            }

            .error {
                margin-top: 20px;
                padding: 12px 16px;
                background: rgba(245, 101, 101, 0.1);
                border: 1px solid rgba(245, 101, 101, 0.3);
                border-radius: 12px;
                color: #e53e3e;
                text-align: center;
                font-size: 14px;
                animation: shake 0.5s ease-in-out;
            }

            @keyframes shake {
                0%, 100% {
                    transform: translateX(0);
                }
                25% {
                    transform: translateX(-5px);
                }
                75% {
                    transform: translateX(5px);
                }
            }

            /* Floating elements */
            .floating-shapes {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: 1;
            }

            .shape {
                position: absolute;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 50%;
                animation: float 6s ease-in-out infinite;
            }

            .shape:nth-child(1) {
                width: 80px;
                height: 80px;
                top: 20%;
                left: 10%;
                animation-delay: 0s;
            }

            .shape:nth-child(2) {
                width: 120px;
                height: 120px;
                top: 60%;
                right: 10%;
                animation-delay: 2s;
            }

            .shape:nth-child(3) {
                width: 60px;
                height: 60px;
                bottom: 20%;
                left: 20%;
                animation-delay: 4s;
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0) rotate(0deg);
                }
                50% {
                    transform: translateY(-20px) rotate(180deg);
                }
            }

            /* Responsive design */
            @media (max-width: 480px) {
                .container {
                    padding: 10px;
                }

                .login-form {
                    padding: 30px 20px;
                }

                .login-form h2 {
                    font-size: 20px;
                }
            }

            /* Enhanced hover effects for form groups */
            .form-group {
                transition: transform 0.2s ease;
            }

            .form-group:hover {
                transform: scale(1.02);
            }
        </style>
    </style>
</head>
<body>
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