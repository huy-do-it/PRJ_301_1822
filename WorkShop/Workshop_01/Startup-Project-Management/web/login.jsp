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
        <title>JSP Page</title>
    </head>
    <body>
        <div> 
            <h2>HAVE A NICE DAY!</h2>
            <form action="MainController" method="get">
                <input type="hidden" name="action" value="login">
                <input type="text" name="userName" placeholder="Username" required><br/>
                <input type="password" name="password" placeholder="Password" required><br/>
                <input type="submit" value="Login">
            </form>
            
            
            <c:if test="${not empty errorNoti}">
                <div>${errorNoti}</div>
            </c:if>
        </div>
    </body>
</html>
