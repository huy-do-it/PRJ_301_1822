<%-- 
    Document   : login
    Created on : May 23, 2025, 9:50:40 AM
    Author     : ddhuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Object objMS = request.getAttribute("message");
            String msg = (objMS == null) ? "" : (objMS+"");
            %>
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="login"/>
            UserID: <input type="text" name="strUserID"/> <br/><!-- comment -->
            Password: <input type="password" name="strPassword"> <br/><!-- comment -->
            <input type="submit" name="Login"/>
            <form/>
            <span style="color: red"><%= msg %> </span>
    </body>
</html>
