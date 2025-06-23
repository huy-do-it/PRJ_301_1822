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
    <body>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <h2>Hello and welcome ${sessionScope.user.name}!</h2>
                <div class="header-actions">
                    <a href="MainController?action=logout" class="logout-btn">Logout</a>
                </div>
                <form action="MainController" method="get" class="search-form"> 
                    <input type="hidden" name="action" value="searchProject"/>
                    <label class="search-label">Search product by name:</label>
                    <input type="text" name="keyword" value="${not empty requestScope.keyword ? requestScope.keyword : ''}" 
                           class="search-input" placeholder="Seach project by name..."/>
                    <input type="submit" value="Search" class="search-btn"/>
                </form>
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
                        <c:forEach var="p" items="${project}">
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
