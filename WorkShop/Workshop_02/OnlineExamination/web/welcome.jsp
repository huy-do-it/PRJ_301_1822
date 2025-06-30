<%-- 
    Document   : welcome
    Created on : Jun 27, 2025, 2:00:26 PM
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
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <div class="user-name">WELCOME ${user.name}!!</div>

                <a href="MainController?action=logout" >Logout</a>

                <div>Hello welcome to this PAGE.</div>
                
                <div>
                    
                </div>

            </c:when>
            <c:otherwise>
                Che* may roi cam nick vinh vien, virus xam nhap may!!
            </c:otherwise>
        </c:choose>
    </body>
</html>
