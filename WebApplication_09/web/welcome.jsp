<%-- 
    Document   : welcome
    Created on : May 23, 2025, 10:26:58 AM
    Author     : ddhuy
--%>
<%@page import="java.util.List" %>
<%@page import="model.ProductDTO" %>
<%@page import="utils.AuthUtils" %>
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
    if(AuthUtils.isLoggedIn(request)){
        UserDTO user = AuthUtils.getCurrentUser(request);
        String keyword = (String)request.getAttribute("keyword");
        %>
        <h1>Hello && Welcome <%= user.getFullName() %> to WELCOME PAGE!</h1>
        <hr/>
        <!--<a href="MainController?action=logout">Logout </a> chơi trực tiếp với Controller-->
        <form action="MainController" method="get">
            <input type="hidden" name="action" value="searchProduct"/>
            Search product by name:
            <input type="text" name="keyword" value="<%=keyword != null ? keyword : ""%>" /> 
            <input type="submit" value="search" />
        </form>
        <form action="MainController" method="get">
            <input type="hidden" name="action" value="logout"/>

            <input type="submit" value="Logout"/>
        </form>

        <br/>
        <%List<ProductDTO> list = (List<ProductDTO>)request.getAttribute("list");
            if(list != null && list.isEmpty()){
        %>
        Not things match with your keyword.
        <%
            }else if(list != null && !list.isEmpty()){
        %>
        <table>
            <thead>
            <th>id</th>
            <th>Name</th>
            <th>Image</th>
            <th>Description</th>
            <th>Price</th>
            <th>Size</th>
            <th>Status</th>
        </thead>
        <tbody>

            <%for(ProductDTO pro : list){
            %>
            <tr>
                <td><%=pro.getId()%></td>
                <td><%=pro.getName()%></td>
                <td><%=pro.getImage()%></td>
                <td><%=pro.getDescription()%></td>
                <td><%=pro.getPrice()%></td>
                <td><%=pro.getSize()%></td>
                <td><%=pro.isStatus() ? "Active" : "Inactive"%></td>
            </tr>
            <%
            }
            %>
        </tbody>                <!--if(pro.istatus()) is false hidden in the list search products-->
    </table>
    <%
        }
    %>
    <!--nang cap phan hien thi san pham khi bi inactive-->
    <% } else { %>
    <%=AuthUtils.getAccessDeniedMessage("welcome.jsp")%> <br/>
    (Or <a href="<%=AuthUtils.getLoginURL()%>">Login</a>)
    <% } %>
</body>
</html>
