<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exam Dashboard</title>
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
                color: #333;
                line-height: 1.6;
            }

            .container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 20px;
            }

            /* Header Section */
            .header {
                background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
                color: white;
                padding: 30px;
                border-radius: 15px;
                margin-bottom: 30px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
                position: relative;
                overflow: hidden;
            }

            .header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="exam-pattern" x="0" y="0" width="20" height="20" patternUnits="userSpaceOnUse"><rect fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5" width="20" height="20"/><circle fill="rgba(255,255,255,0.05)" cx="10" cy="10" r="2"/></pattern></defs><rect width="100" height="100" fill="url(%23exam-pattern)"/></svg>');
                opacity: 0.3;
            }

            .header-content {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 20px;
                position: relative;
                z-index: 1;
            }

            .user-name {
                font-size: 28px;
                font-weight: bold;
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .logout-btn {
                background: rgba(255, 255, 255, 0.2);
                color: white;
                padding: 12px 25px;
                text-decoration: none;
                border-radius: 25px;
                font-weight: 600;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 8px;
                border: 2px solid rgba(255, 255, 255, 0.3);
            }

            .logout-btn:hover {
                background: rgba(255, 255, 255, 0.3);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            }

            /* Action Buttons */
            .action-buttons {
                margin-bottom: 30px;
                display: flex;
                gap: 15px;
                flex-wrap: wrap;
            }

            .action-btn {
                background: linear-gradient(135deg, #FF6B6B 0%, #FF8E8E 100%);
                color: white;
                padding: 15px 30px;
                text-decoration: none;
                border-radius: 25px;
                font-weight: 600;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .action-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 25px rgba(255, 107, 107, 0.3);
            }

            .action-btn.create {
                background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            }

            .action-btn.create:hover {
                box-shadow: 0 8px 25px rgba(76, 175, 80, 0.3);
            }

            /* Section Headers */
            .section-header {
                background: white;
                padding: 25px;
                border-radius: 15px;
                margin-bottom: 20px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                border-left: 5px solid #4CAF50;
            }

            .section-header h2,
            .section-header h3 {
                color: #333;
                font-size: 24px;
                display: flex;
                align-items: center;
                gap: 12px;
                margin: 0;
            }

            .section-header h3 {
                font-size: 20px;
                color: #4CAF50;
            }

            /* Filter Section */
            .filter-section {
                background: white;
                padding: 25px;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
            }

            .filter-form {
                display: flex;
                gap: 15px;
                align-items: center;
                flex-wrap: wrap;
            }

            .filter-form select {
                padding: 12px 20px;
                border: 2px solid #e1e5e9;
                border-radius: 10px;
                font-size: 16px;
                background: white;
                cursor: pointer;
                transition: all 0.3s ease;
                min-width: 250px;
            }

            .filter-form select:focus {
                outline: none;
                border-color: #4CAF50;
                box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
            }

            .filter-form input[type="submit"] {
                background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
                color: white;
                padding: 12px 25px;
                border: none;
                border-radius: 25px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .filter-form input[type="submit"]:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
            }

            /* Table Styling */
            table {
                width: 100%;
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
                border-collapse: collapse;
            }

            table thead {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            table th {
                padding: 20px;
                font-weight: 600;
                text-align: left;
                font-size: 16px;
                border: none;
            }

            table td {
                padding: 18px 20px;
                border-bottom: 1px solid #e9ecef;
                transition: background-color 0.3s ease;
                border: none;
            }

            table tbody tr:hover {
                background-color: #f8f9fa;
            }

            table tbody tr:last-child td {
                border-bottom: none;
            }

            /* Form Buttons in Table */
            .table-form {
                display: inline-block;
                margin: 0;
            }

            .table-btn {
                background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
                color: white;
                padding: 8px 16px;
                border: none;
                border-radius: 20px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 5px;
                white-space: nowrap;
            }

            .table-btn:hover {
                transform: translateY(-1px);
                box-shadow: 0 3px 10px rgba(76, 175, 80, 0.3);
            }

            .table-btn.take-exam {
                background: linear-gradient(135deg, #FF6B6B 0%, #FF8E8E 100%);
            }

            .table-btn.take-exam:hover {
                box-shadow: 0 3px 10px rgba(255, 107, 107, 0.3);
            }

            .table-btn.view-exams {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }

            .table-btn.view-exams:hover {
                box-shadow: 0 3px 10px rgba(102, 126, 234, 0.3);
            }

            /* Messages */
            .message-box {
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 12px;
                font-weight: 500;
                font-size: 16px;
            }

            .message-box.success {
                background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
                border: 1px solid #c3e6cb;
                color: #155724;
            }

            .message-box.error {
                background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                border: 1px solid #f5c6cb;
                color: #721c24;
            }

            /* Access Denied Section */
            .access-denied {
                background: white;
                padding: 60px 40px;
                border-radius: 20px;
                text-align: center;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                max-width: 500px;
                margin: 100px auto;
            }

            .access-denied h2 {
                color: #FF6B6B;
                font-size: 32px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 15px;
            }

            .access-denied p {
                color: #666;
                font-size: 18px;
                margin-bottom: 30px;
            }

            .login-link {
                background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
                color: white;
                padding: 15px 30px;
                text-decoration: none;
                border-radius: 25px;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 10px;
                transition: all 0.3s ease;
            }

            .login-link:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(76, 175, 80, 0.3);
            }

            /* Stats Cards */
            .stats-cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                padding: 25px;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                text-align: center;
                transition: transform 0.3s ease;
                border-left: 5px solid #4CAF50;
            }

            .stat-card:hover {
                transform: translateY(-3px);
            }

            .stat-card i {
                font-size: 40px;
                color: #4CAF50;
                margin-bottom: 15px;
            }

            .stat-card h3 {
                color: #333;
                font-size: 18px;
                margin-bottom: 5px;
            }

            .stat-card p {
                color: #666;
                font-size: 14px;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .container {
                    padding: 15px;
                }

                .header-content {
                    flex-direction: column;
                    text-align: center;
                }

                .user-name {
                    font-size: 24px;
                }

                .action-buttons {
                    justify-content: center;
                }

                .filter-form {
                    flex-direction: column;
                    align-items: stretch;
                }

                .filter-form select {
                    min-width: auto;
                }

                table {
                    font-size: 14px;
                }

                table th,
                table td {
                    padding: 12px 15px;
                }

                .access-denied {
                    margin: 50px auto;
                    padding: 40px 30px;
                }

                .stats-cards {
                    grid-template-columns: 1fr;
                }
            }

            /* Animation for page load */
            .container > * {
                animation: fadeInUp 0.6s ease-out;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Exam category badges */
            .category-badge {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 5px 12px;
                border-radius: 15px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            /* Duration and marks styling */
            .duration-badge {
                background: #e3f2fd;
                color: #1976d2;
                padding: 4px 8px;
                border-radius: 10px;
                font-size: 12px;
                font-weight: 600;
            }

            .marks-badge {
                background: #f3e5f5;
                color: #7b1fa2;
                padding: 4px 8px;
                border-radius: 10px;
                font-size: 12px;
                font-weight: 600;
            }
        </style>
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <div class="container">
                    <div class="header">
                        <div class="header-content">
                            <div class="user-name">
                                <i class="fas fa-user-graduate"></i>
                                WELCOME ${user.name}!!
                            </div>
                            <a href="MainController?action=logout" class="logout-btn">
                                <i class="fas fa-sign-out-alt"></i>
                                Logout
                            </a>
                        </div>
                    </div>

                    <c:if test="${sessionScope.user.role eq 'Instructor'}">
                        <div class="action-buttons">
                            <a href="ExamCategoriesController?action=create-form" class="action-btn create">
                                <i class="fas fa-plus"></i>
                                Create Exam
                            </a>
                        </div>
                    </c:if>

                    <div class="section-header">
                        <h2><i class="fas fa-folder-open"></i> Exam Categories</h2>
                    </div>

                    <c:if test="${not empty categories}">
                        <table>
                            <thead>
                                <tr>
                                    <th><i class="fas fa-tag"></i> Category Name</th>
                                    <th><i class="fas fa-file-alt"></i> Description</th>
                                        <c:if test="${sessionScope.user.role eq 'Instructor'}">
                                        <th><i class="fas fa-eye"></i> View Exams</th>
                                        </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cat" items="${categories}">
                                    <tr>
                                        <td>
                                            <span class="category-badge">${cat.categoryName}</span>
                                        </td>
                                        <td>${cat.description}</td>
                                        <c:if test="${sessionScope.user.role eq 'Instructor'}">
                                            <td>
                                                <form method="get" action="ExamCategoriesController" class="table-form">
                                                    <input type="hidden" name="action" value="view-exams"/>
                                                    <input type="hidden" name="category_id" value="${cat.categoryId}"/>
                                                    <input type="submit" value="View Exams" class="table-btn view-exams"/>
                                                </form>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <c:if test="${sessionScope.user.role eq 'Student'}">
                            <div class="filter-section">
                                <form method="get" action="ExamCategoriesController" class="filter-form">
                                    <select name="category_id" required>
                                        <option value="">-- Select Category --</option>
                                        <c:forEach var="cat" items="${categories}">
                                            <c:choose>
                                                <c:when test="${param.category_id == cat.categoryId}">
                                                    <option value="${cat.categoryId}" selected>${cat.categoryName}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${cat.categoryId}">${cat.categoryName}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </select>
                                    <input type="hidden" name="action" value="view-exams"/>
                                    <input type="submit" value="🔍 Filter"/>
                                </form>
                            </div>
                        </c:if>
                    </c:if>

                    <c:if test="${not empty examsByCategory}">
                        <div class="section-header">
                            <h3><i class="fas fa-list-alt"></i> Exams in Category: ${selectedCategoryName}</h3>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <th><i class="fas fa-file-alt"></i> Exam Title</th>
                                    <th><i class="fas fa-book"></i> Subject</th>
                                    <th><i class="fas fa-star"></i> Total Marks</th>
                                    <th><i class="fas fa-clock"></i> Duration</th>
                                    <th><i class="fas fa-cogs"></i> Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="exam" items="${examsByCategory}">
                                    <tr>
                                        <td>${exam.examTitle}</td>
                                        <td>${exam.subject}</td>
                                        <td><span class="marks-badge">${exam.totalMarks} points</span></td>
                                        <td><span class="duration-badge">${exam.duration} mins</span></td>
                                        <td>
                                            <c:if test="${sessionScope.user.role eq 'Instructor'}">
                                                <form action="ExamCategoriesController" method="get" class="table-form">
                                                    <input type="hidden" name="action" value="add-question-form"/>
                                                    <input type="hidden" name="examId" value="${exam.examId}"/>
                                                    <input type="submit" value="Add Question" class="table-btn"/>
                                                </form>
                                            </c:if>
                                            <c:if test="${sessionScope.user.role eq 'Student'}">
                                                <form action="ExamCategoriesController" method="get" class="table-form">
                                                    <input type="hidden" name="action" value="take-exam"/>
                                                    <input type="hidden" name="examId" value="${exam.examId}"/>
                                                    <input type="submit" value="Take Exam" class="table-btn take-exam"/>
                                                </form>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <c:if test="${sessionScope.user.role eq 'Instructor'}">
                            <c:if test="${not empty success}">
                                <div class="message-box success">
                                    <i class="fas fa-check-circle"></i>
                                    ${success}
                                </div>
                            </c:if>
                            <c:if test="${not empty errorMess}">
                                <div class="message-box error">
                                    <i class="fas fa-exclamation-triangle"></i>
                                    ${errorMess}
                                </div>
                            </c:if>
                        </c:if>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div class="container">
                    <div class="access-denied">
                        <h2><i class="fas fa-lock"></i> Access Denied</h2>
                        <p>You need to login to access this page.</p>
                        <a href="MainController?action=login" class="login-link">
                            <i class="fas fa-sign-in-alt"></i> Login Now
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </body>
</html>