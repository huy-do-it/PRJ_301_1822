<%-- 
    Document   : welcome
    Created on : May 23, 2025, 10:26:58 AM
    Author     : ddhuy
--%>
<%@page import="model.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            UserDTO user = (UserDTO)request.getAttribute("user"); 
        %>
        <h1>Hello anh zaiiii <%= user.getFullName() %>!</h1>
        
    </body>
</html>
