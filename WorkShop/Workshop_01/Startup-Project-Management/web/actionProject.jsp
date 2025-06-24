<%-- 
    Document   : createProject
    Created on : Jun 22, 2025, 9:37:09 PM
    Author     : ddhuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Action page</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty sessionScope.user.role}">
                <div class="header-actions">
                    <a href="welcom.jsp" class="back-link"></a>
                </div>
                <div class="header-actions">
                    <a href="MainController?action=searchProject" class="logout-btn">← Back to Products</a>
                    <h1>ADD PROJECT</h1>
                </div>
                <form action="MainController" method="get" class="search-form"> 
                    <input type="hidden" name="action" value="createProject"/>

                    <div class="form-group">
                        <label for="name">Name: <span class="required">*</span></label>
                        <input type="text" id="name" name="name" required value="${StartupProject.projectName}"/>
                    </div>

                    <div class="form-group">
                        <label for="description">Description: </label>
                        <textarea id="description" name="description" placeholder="Enter product description..." 
                                  rows="3" >${not empty StartupProject ? StartupProject.description : ''}
                        </textarea>
                        <c:if test="${not empty errorDescription}">
                    <span class="error">${errorDescription}</span>
                </c:if>
                    </div>

                    <div class="form-group">
                        <label for="status">Status: <span class="required">*</span></label>
                        <select id="status" name="status" required>
                            <option value="">Select status</option>
                            <option value="Ideation">Ideation</option>
                            <option value="Development">Development</option>
                            <option value="Launch">Launch</option>
                            <option value="Scaling">Scaling</option>
                        </select>
<!--                        <input type="text" id="status" name="status" required placeholder="Ideation, Development, Launch, Scaling" value="${StartupProject.status}"/>-->
                    </div>

                    <div class="form-group">
                        <label for="name">Estimated Launch: <span class="required">*</span></label>
                        <input type="text" id="name" name="name" required value="${StartupProject.estimatedLaunch}"/>
                    </div>

                    <input type="submit" value="add" class="search-btn"/>
                </form>

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
