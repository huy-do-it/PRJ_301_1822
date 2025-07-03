<%-- 
    Document   : login.jsp
    Created on : Jun 27, 2025, 11:01:13 AM
    Author     : ddhuy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online Examination - Login</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }

            .login-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
                overflow: hidden;
                width: 100%;
                max-width: 450px;
                position: relative;
            }

            .login-header {
                background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
                color: white;
                padding: 40px 30px;
                text-align: center;
                position: relative;
            }

            .login-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="books" x="0" y="0" width="20" height="20" patternUnits="userSpaceOnUse"><rect fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5" width="20" height="20"/><rect fill="rgba(255,255,255,0.05)" x="2" y="2" width="3" height="16"/><rect fill="rgba(255,255,255,0.05)" x="6" y="4" width="3" height="14"/><rect fill="rgba(255,255,255,0.05)" x="10" y="1" width="3" height="17"/></pattern></defs><rect width="100" height="100" fill="url(%23books)"/></svg>');
                opacity: 0.3;
            }

            .login-header h1 {
                font-size: 28px;
                margin-bottom: 10px;
                position: relative;
                z-index: 1;
            }

            .login-header p {
                font-size: 16px;
                opacity: 0.9;
                position: relative;
                z-index: 1;
            }

            .login-icon {
                font-size: 50px;
                margin-bottom: 20px;
                color: rgba(255, 255, 255, 0.9);
            }

            .login-form {
                padding: 40px 30px;
            }

            .form-group {
                margin-bottom: 25px;
                position: relative;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #333;
                font-weight: 600;
                font-size: 14px;
            }

            .input-wrapper {
                position: relative;
            }

            .form-group input {
                width: 100%;
                padding: 15px 20px 15px 50px;
                border: 2px solid #e1e5e9;
                border-radius: 10px;
                font-size: 16px;
                transition: all 0.3s ease;
                background: #f8f9fa;
            }

            .form-group input:focus {
                outline: none;
                border-color: #4CAF50;
                background: white;
                box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
            }

            .input-icon {
                position: absolute;
                left: 18px;
                top: 50%;
                transform: translateY(-50%);
                color: #6c757d;
                font-size: 18px;
            }

            .form-group input:focus + .input-icon {
                color: #4CAF50;
            }

            .login-btn {
                width: 100%;
                padding: 15px;
                background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 18px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .login-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(76, 175, 80, 0.3);
            }

            .login-btn:active {
                transform: translateY(0);
            }

            .login-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                transition: left 0.5s;
            }

            .login-btn:hover::before {
                left: 100%;
            }

            .error-message {
                background: #ffebee;
                border: 1px solid #ffcdd2;
                color: #c62828;
                padding: 15px;
                border-radius: 10px;
                margin-top: 20px;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .error-message i {
                font-size: 18px;
            }

            .features {
                background: #f8f9fa;
                padding: 30px;
                text-align: center;
            }

            .features h3 {
                color: #333;
                margin-bottom: 20px;
                font-size: 20px;
            }

            .feature-list {
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
                gap: 20px;
            }

            .feature-item {
                color: #6c757d;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .feature-item i {
                color: #4CAF50;
                font-size: 16px;
            }

            @media (max-width: 480px) {
                .login-container {
                    margin: 10px;
                    max-width: none;
                }
                
                .login-header {
                    padding: 30px 20px;
                }
                
                .login-header h1 {
                    font-size: 24px;
                }
                
                .login-form {
                    padding: 30px 20px;
                }
                
                .features {
                    padding: 20px;
                }
                
                .feature-list {
                    flex-direction: column;
                    gap: 15px;
                }
            }

            /* Animation for page load */
            .login-container {
                animation: slideUp 0.6s ease-out;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="login-header">
                <div class="login-icon">
                    <i class="fas fa-graduation-cap"></i>
                </div>
                <h1>Online Examination</h1>
                <p>Hệ thống thi trực tuyến</p>
            </div>
            
            <div class="login-form">
                <form action="MainController" method="get">
                    <input type="hidden" name="action" value="login" />
                    
                    <div class="form-group">
                        <label for="userName">Tên đăng nhập</label>
                        <div class="input-wrapper">
                            <input type="text" id="userName" name="userName" placeholder="Nhập tên đăng nhập" required />
                            <i class="fas fa-user input-icon"></i>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <div class="input-wrapper">
                            <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required />
                            <i class="fas fa-lock input-icon"></i>
                        </div>
                    </div>
                    
                    <button type="submit" class="login-btn">
                        <i class="fas fa-sign-in-alt"></i> Đăng nhập
                    </button>
                </form>
                
                <c:if test="${not empty errMessage}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-triangle"></i>
                        ${errMessage}
                    </div>
                </c:if>
            </div>
            
            <div class="features">
                <h3>Tính năng nổi bật</h3>
                <div class="feature-list">
                    <div class="feature-item">
                        <i class="fas fa-clock"></i>
                        <span>Thi theo thời gian</span>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-chart-line"></i>
                        <span>Thống kê kết quả</span>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-shield-alt"></i>
                        <span>Bảo mật cao</span>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
