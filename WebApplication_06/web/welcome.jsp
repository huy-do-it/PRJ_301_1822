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
            UserDTO user = (UserDTO)session.getAttribute("user"); 
            if(user == null){
                response.sendRedirect("MainController");
            }else{
        %>
        <h1>Hello anh zaiiii <%= user.getFullName() %>!</h1>
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="logout"/>
            <!--<a href="MainController?action=logout">Logout </a> chơi trực tiếp với Controller-->
            <input type="submit" value="Logout"/>
        </form>
        <%}%>
    </body>
</html>
