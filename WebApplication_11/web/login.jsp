<%-- 
    Document   : login
    Created on : May 23, 2025, 9:50:40 AM
    Author     : ddhuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@page import="model.UserDTO"%>
<%@page import="utils.AuthUtils" %>--%>
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
        <%
            if(AuthUtils.isLoggedIn(request)){
                response.sendRedirect("welcome.jsp");
            }else{
                Object objMS = request.getAttribute("message");
                String msg = (objMS==null)?"":(objMS+"");
            %>
            <form action="MainController" method="get">
                <input type="hidden" name="action" value="login"/>
                UserID : <input type="text" name="strUserID" /> <br/> 
                Password : <input type="password" name="strPassword" /> </br>
                <input type="submit" value="Login"/>
            </form>
            <span style="color: red"><%=msg%></span>

        <%}%>
    </body>
</html>
