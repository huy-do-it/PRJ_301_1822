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
        <title>JSP Page</title>
    </head>
    <body>
        <c:if test="${sessionScope.user.role eq 'Instructor'}">
            <a href="ExamCategoriesController" >Back To Dash Board</a>
            <form  method="get" action="ExamCategoriesController">
            <input type="hidden" name="action" value="create"/>

            <label>Exam Title:</label>
            <input type="text" name="title" value="${param.title}"/>
            <c:if test="${not empty errors.title}"><span class="error">${errors.title}</span></c:if><br/>

                <label>Subject:</label>
                <input type="text" name="subject" value="${param.subject}"/>
            <c:if test="${not empty errors.subject}"><span class="error">${errors.subject}</span></c:if><br/>

                <label>Category:</label>
                <select name="category_id">
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.categoryId}"
                            <c:if test="${param.category_id == cat.categoryId}">selected</c:if>>
                        ${cat.categoryName}
                    </option>
                </c:forEach>
            </select>
            <c:if test="${not empty errors.category_id}"><span class="error">${errors.category_id}</span></c:if><br/>

                <label>Total Marks:</label>
                <input type="number" name="total_marks" value="${param.total_marks}"/>
            <c:if test="${not empty errors.total_marks}"><span class="error">${errors.total_marks}</span></c:if><br/>

                <label>Duration (minutes):</label>
                <input type="number" name="duration" value="${param.duration}"/>
            <c:if test="${not empty errors.duration}"><span class="error">${errors.duration}</span></c:if><br/>

                <input type="submit" value="Create Exam"/>
                
            </form>

        <c:if test="${not empty success}">
            <p class="success">${success}</p>
        </c:if>
    </c:if>
    <c:if test="${empty sessionScope.user or sessionScope.user.role eq 'Student'}">
        <div class="container">

            <div class="access-denied">
                <h2>Access Denied</h2>
                <p>You need to login to access this page.</p>
                <a href="MainController?action=login" class="login-link">Login Now</a>
            </div>

        </div>
    </c:if>
</body>
</html>
