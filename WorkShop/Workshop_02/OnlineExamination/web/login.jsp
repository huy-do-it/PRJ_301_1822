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
        <title>JSP Page</title>
    </head>
    <body>
        <div>
            <form action="MainController" method="get">
                <input type="hidden" name="action" value="login" />
                <input type="text" name="userName" placeholder="User Name" />
                <input type="password" name="password" placeholder="Password"/>
                <input type="submit" value="Login"/>
            </form>
            
            <c:if test="${not empty errMessage}">
                <div>${errMessage}</div>
            </c:if>
            
        </div>
    </body>
</html>
