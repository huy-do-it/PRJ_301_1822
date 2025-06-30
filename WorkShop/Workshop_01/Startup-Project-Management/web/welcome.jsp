<%-- 
    Document   : dashboard
    Created on : Jun 22, 2025, 9:07:14 AM
    Author     : ddhuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            color: #2d3748;
            line-height: 1.6;
        }

        /* Header Section */
        .header {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            padding: 20px 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .welcome-message {
            font-size: 24px;
            font-weight: 700;
            color: #2d3748;
            margin: 0;
        }

        .header-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .logout-btn {
            padding: 10px 20px;
            background: linear-gradient(135deg, #ff6b6b, #ee5a52);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
        }

        /* Main Content */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
        }

        /* Search Section */
        .search-section {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            padding: 30px;
            border-radius: 16px;
            margin-bottom: 30px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .search-form {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: end;
        }

        .search-label {
            font-weight: 600;
            color: #4a5568;
            margin-bottom: 8px;
            display: block;
            width: 100%;
        }

        .search-input {
            flex: 1;
            min-width: 250px;
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: white;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-btn {
            padding: 12px 24px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        /* Create Button */
        .create-btn {
            display: inline-block;
            padding: 15px 30px;
            background: linear-gradient(135deg, #48bb78, #38a169);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            margin-bottom: 30px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(72, 187, 120, 0.3);
        }

        .create-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(72, 187, 120, 0.4);
        }

        /* Table Styles */
        .table-container {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        th {
            padding: 20px 15px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        tbody tr {
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            transition: background-color 0.2s ease;
        }

        tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.05);
        }

        td {
            padding: 18px 15px;
            font-size: 14px;
        }

        /* Status badges */
        td:nth-child(4) {
            font-weight: 600;
        }

        /* Update Form */
        .update-form {
            margin: 0;
        }

        .update-form button {
            padding: 8px 16px;
            background: linear-gradient(135deg, #ffd89b, #19547b);
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 12px;
        }

        .update-form button:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(25, 84, 123, 0.3);
        }

        /* Access Denied Section */
        .container {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }

        .access-denied {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            padding: 50px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            max-width: 500px;
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

        .access-denied h2 {
            color: #e53e3e;
            font-size: 28px;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .access-denied p {
            color: #718096;
            font-size: 16px;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .login-link {
            display: inline-block;
            padding: 15px 30px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .login-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                text-align: center;
            }

            .welcome-message {
                font-size: 20px;
            }

            .search-form {
                flex-direction: column;
                align-items: stretch;
            }

            .search-input {
                min-width: auto;
            }

            .table-container {
                overflow-x: auto;
            }

            table {
                min-width: 600px;
            }

            .access-denied {
                padding: 30px 20px;
            }
        }

        @media (max-width: 480px) {
            .main-content {
                padding: 20px 10px;
            }

            .search-section {
                padding: 20px;
            }

            th, td {
                padding: 12px 8px;
                font-size: 12px;
            }

            .welcome-message {
                font-size: 18px;
            }
        }

        /* Loading states */
        .search-btn:active,
        .create-btn:active,
        .update-form button:active {
            transform: translateY(0);
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 50px 20px;
            color: #718096;
        }

        .empty-state h3 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #4a5568;
        }

        /* Micro animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .table-container {
            animation: fadeIn 0.6s ease-out;
        }

        .search-section {
            animation: fadeIn 0.4s ease-out;
        }
    </style>
    <body>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <div class="header-content">
                    <h2 class="welcome-message">Hello and welcome ${sessionScope.user.name}!</h2>
                    <div class="header-actions">
                        <a href="MainController?action=logout" class="logout-btn">Logout</a>
                    </div>

                </div>
                <div class="main-content">
                    <c:if test="${sessionScope.user.role eq 'Founder'}">
                        <div class="search-section">
                            <form action="MainController" method="get" class="search-form"> 
                                <input type="hidden" name="action" value="searchProject"/>
                                <label class="search-label">Search product by name:</label>
                                <input type="text" name="keyword" value="${not empty requestScope.keyword ? requestScope.keyword : ''}" 
                                       class="search-input" placeholder="Seach project by name..."/> <!-- giữ lại cái keyword khi search -->
                                <input type="submit" value="Search" class="search-btn"/>
                            </form>
                        </div>


                        <a href="actionProject.jsp" class="create-btn">Create Project</a>  
                    </c:if>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                    <th>Launch Date</th>
                                        <c:if test="${sessionScope.user.role eq 'Founder'}">
                                        <th>Action</th>
                                        </c:if>

                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${projects}">
                                    <tr>
                                        <td>${p.projectId}</td>
                                        <td>${p.projectName}</td>
                                        <td>${p.description}</td>
                                        <td>${p.status}</td>
                                        <td>${p.estimatedLaunch}</td>
                                        <c:if test="${sessionScope.user.role eq 'Founder'}">
                                            <td>
                                                <form action="MainController" method="get" class="update-form">
                                                    <input type="hidden" name="action" value="updateProject">
                                                    <input type="hidden" name="projectId" value="${p.projectId}">
                                                    <button type="submit">Edit</button>
                                                </form>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="container">
                    <div class="access-denied">
                        <h2>Access Denied</h2>
                        <p>You need to login to access this page.</p>
                        <a href="MainController?action=login" class="login-link">Login Now</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </body>
</html>
