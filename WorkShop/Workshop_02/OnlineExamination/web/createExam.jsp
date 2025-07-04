<%-- 
    Document   : createExam
    Created on : Jul 2, 2025, 11:06:11 PM
    Author     : ddhuy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Online Exam</title>
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
                padding: 20px;
                color: #333;
            }

            .container {
                max-width: 800px;
                margin: 0 auto;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                padding: 40px;
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            .header {
                text-align: center;
                margin-bottom: 40px;
            }

            .header h1 {
                color: #2d3748;
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 10px;
                background: linear-gradient(135deg, #667eea, #764ba2);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .header p {
                color: #718096;
                font-size: 1.1rem;
            }

            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                color: #667eea;
                text-decoration: none;
                font-weight: 600;
                padding: 12px 24px;
                border: 2px solid #667eea;
                border-radius: 12px;
                transition: all 0.3s ease;
                margin-bottom: 30px;
                background: transparent;
            }

            .back-link:hover {
                background: #667eea;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            }

            .back-link::before {
                content: "←";
                font-size: 1.2rem;
            }

            .form-container {
                background: white;
                padding: 35px;
                border-radius: 16px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                border: 1px solid rgba(0, 0, 0, 0.05);
            }

            .form-group {
                margin-bottom: 25px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #2d3748;
                font-size: 1rem;
            }

            input[type="text"],
            input[type="number"],
            select {
                width: 100%;
                padding: 15px 20px;
                border: 2px solid #e2e8f0;
                border-radius: 12px;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: #f8fafc;
                color: #2d3748;
            }

            input[type="text"]:focus,
            input[type="number"]:focus,
            select:focus {
                outline: none;
                border-color: #667eea;
                background: white;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
                transform: translateY(-1px);
            }

            select {
                cursor: pointer;
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
                background-position: right 12px center;
                background-repeat: no-repeat;
                background-size: 16px;
                padding-right: 50px;
            }

            input[type="submit"] {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                padding: 16px 40px;
                border: none;
                border-radius: 12px;
                font-size: 1.1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                width: 100%;
                margin-top: 15px;
            }

            input[type="submit"]:hover {
                transform: translateY(-2px);
                box-shadow: 0 12px 35px rgba(102, 126, 234, 0.4);
            }

            input[type="submit"]:active {
                transform: translateY(0);
            }

            .error {
                color: #e53e3e;
                font-size: 0.9rem;
                margin-top: 5px;
                display: block;
                padding: 8px 12px;
                background: rgba(229, 62, 62, 0.1);
                border-radius: 6px;
                border-left: 4px solid #e53e3e;
            }

            .success {
                color: #38a169;
                font-size: 1rem;
                margin-top: 20px;
                padding: 15px 20px;
                background: rgba(56, 161, 105, 0.1);
                border-radius: 12px;
                border-left: 4px solid #38a169;
                font-weight: 600;
            }

            .access-denied {
                text-align: center;
                padding: 60px 40px;
                background: white;
                border-radius: 16px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            }

            .access-denied h2 {
                color: #e53e3e;
                font-size: 2rem;
                margin-bottom: 20px;
                font-weight: 700;
            }

            .access-denied p {
                color: #718096;
                font-size: 1.1rem;
                margin-bottom: 30px;
            }

            .login-link {
                display: inline-block;
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                padding: 15px 35px;
                text-decoration: none;
                border-radius: 12px;
                font-weight: 600;
                transition: all 0.3s ease;
                font-size: 1.1rem;
            }

            .login-link:hover {
                transform: translateY(-2px);
                box-shadow: 0 12px 35px rgba(102, 126, 234, 0.4);
            }

            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 20px;
                    margin: 10px;
                }

                .form-container {
                    padding: 20px;
                }

                .header h1 {
                    font-size: 2rem;
                }

                .form-row {
                    grid-template-columns: 1fr;
                }
            }

            .icon {
                display: inline-block;
                width: 20px;
                height: 20px;
                margin-right: 8px;
                vertical-align: middle;
            }

            .floating-shapes {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: -1;
            }

            .floating-shapes::before,
            .floating-shapes::after {
                content: '';
                position: absolute;
                width: 200px;
                height: 200px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 50%;
                animation: float 6s ease-in-out infinite;
            }

            .floating-shapes::before {
                top: 10%;
                left: 10%;
                animation-delay: 0s;
            }

            .floating-shapes::after {
                bottom: 10%;
                right: 10%;
                animation-delay: 3s;
            }

            @keyframes float {
                0%, 100% { transform: translateY(0px); }
                50% { transform: translateY(-20px); }
            }
        </style>
    </head>
    <body>
        <div class="floating-shapes"></div>
        
        <c:if test="${sessionScope.user.role eq 'Instructor'}">
            <div class="container">
                <div class="header">
                    <h1>Create Online Exam</h1>
                    <p>Design and configure your examination</p>
                </div>
                
                <a href="ExamCategoriesController" class="back-link">Back To Dashboard</a>
                
                <div class="form-container">
                    <form method="get" action="ExamCategoriesController">
                        <input type="hidden" name="action" value="create"/>
                        
                        <div class="form-group">
                            <label>📝 Exam Title:</label>
                            <input type="text" name="title" value="${param.title}" placeholder="Enter exam title"/>
                            <c:if test="${not empty errors.title}"><span class="error">${errors.title}</span></c:if>
                        </div>
                        
                        <div class="form-group">
                            <label>📚 Subject:</label>
                            <input type="text" name="subject" value="${param.subject}" placeholder="Enter subject name"/>
                            <c:if test="${not empty errors.subject}"><span class="error">${errors.subject}</span></c:if>
                        </div>
                        
                        <div class="form-group">
                            <label>🏷️ Category:</label>
                            <select name="category_id">
                                <c:forEach var="cat" items="${categories}">
                                    <c:choose>
                                        <c:when test="${param.category_id == cat.categoryId}">
                                            <option value="${cat.categoryId}" selected>
                                                ${cat.categoryName}
                                            </option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${cat.categoryId}">
                                                ${cat.categoryName}
                                            </option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                            <c:if test="${not empty errors.category_id}"><span class="error">${errors.category_id}</span></c:if>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label>🎯 Total Marks:</label>
                                <input type="number" name="total_marks" value="${param.total_marks}" placeholder="100"/>
                                <c:if test="${not empty errors.total_marks}"><span class="error">${errors.total_marks}</span></c:if>
                            </div>
                            
                            <div class="form-group">
                                <label>⏱️ Duration (minutes):</label>
                                <input type="number" name="duration" value="${param.duration}" placeholder="60"/>
                                <c:if test="${not empty errors.duration}"><span class="error">${errors.duration}</span></c:if>
                            </div>
                        </div>
                        
                        <input type="submit" value="Create Exam"/>
                    </form>
                    
                    <c:if test="${not empty success}">
                        <p class="success">✅ ${success}</p>
                    </c:if>
                </div>
            </div>
        </c:if>
        
        <c:if test="${empty sessionScope.user or sessionScope.user.role eq 'Student'}">
            <div class="container">
                <div class="access-denied">
                    <h2>🚫 Access Denied</h2>
                    <p>You need to login as an instructor to access this page.</p>
                    <a href="MainController?action=login" class="login-link">Login Now</a>
                </div>
            </div>
        </c:if>
    </body>
</html>