<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exam Dashboard</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="MainController?action=logout">Logout</a>
                <div class="user-name">WELCOME ${user.name}!!</div>
                <c:if test="${sessionScope.user.role eq 'Instructor'}">
                    <a href="ExamCategoriesController?action=create-form">Create Exam</a>
                </c:if>

                <!-- Show exam categories for everyone -->
                <h2>Exam Categories</h2>
                <c:if test="${not empty categories}">
                    <table border="1">
                        <thead>
                            <tr>
                                <th>Category Name</th>
                                <th>Description</th>
                                <th>View Exams</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cat" items="${categories}">
                                <tr>
                                    <td>${cat.categoryName}</td>
                                    <td>${cat.description}</td>
                                    <td>
                                        <form method="get" action="ExamCategoriesController" style="display:inline">
                                            <input type="hidden" name="action" value="view-exams"/>
                                            <input type="hidden" name="category_id" value="${cat.categoryId}"/>
                                            <input type="submit" value="View Exams"/>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>

                <!-- Show filtered exams for selected category (if any) -->
                <c:if test="${not empty examsByCategory}">
                    <h3>Exams in Category: ${selectedCategoryName}</h3>
                    <table border="1">
                        <thead>
                            <tr>
                                <th>Exam Title</th>
                                <th>Subject</th>
                                <th>Total Marks</th>
                                <th>Duration</th>
                                <th>Action</th>
                                <!-- Nếu cần: thêm nút Take Exam (cho Student), Add Question (cho Instructor) -->
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="exam" items="${examsByCategory}">
                                <tr>
                                    <td>${exam.examTitle}</td>
                                    <td>${exam.subject}</td>
                                    <td>${exam.totalMarks}</td>
                                    <td>${exam.duration}</td>
                                    <c:if test="${sessionScope.user.role eq 'Instructor'}">
                                        <td>
                                            <form action="ExamCategoriesController" method="get" style="display:inline">
                                                <input type="hidden" name="action" value="add-question-form"/>
                                                <input type="hidden" name="examId" value="${exam.examId}"/>
                                                <input type="submit" value="Add Question"/>
                                            </form>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${sessionScope.user.role eq 'Instructor'}">
                        <c:if test="${not empty success}">
                            <h3>${success}</h3>
                        </c:if>
                        <c:if test="${not empty errorMess}">
                            <h3>${errorMess}</h3>
                        </c:if>
                    </c:if>
                </c:if>

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