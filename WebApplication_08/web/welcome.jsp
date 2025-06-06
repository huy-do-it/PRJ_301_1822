<%-- 
    Document   : welcome
    Created on : May 23, 2025, 10:26:58 AM
    Author     : ddhuy
--%>
<%@page import="model.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="utils.AuthUtils" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
    if(AuthUtils.isLoggedIn(request)){
        UserDTO user = AuthUtils.getCurrentUser(request);
        %>
        <h1>Hello anh zaiiii <%= user.getFullName() %>!</h1>
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="logout"/>
<!--            <a href="MainController?action=logout">Logout </a> chơi trực tiếp với Controller-->
            <input type="submit" value="Logout"/>
        </form>
        
        <% } else { %>
        <%=AuthUtils.getAccessDeniedMessage("welcome.jsp")%> <br/>
        (Or <a href="<%=AuthUtils.getLoginURL()%>">Login</a>)
        <% } %>
    </body>
</html>
