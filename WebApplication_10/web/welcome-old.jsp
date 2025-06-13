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
        <title>Product Management</title>

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 20px;
            }
            h1 {
                color: #333;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                background-color: #fff;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #4CAF50;
                color: white;
            }
            tr:hover {
                background-color: #f1f1f1;
            }
            .btn {
                padding: 5px 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                text-decoration: none;
                font-size: 14px;
            }
            .btn-group a {
                display: inline-block;
                margin-right: 8px;
            }

            .btn-edit {
                background-color: #2196F3;
                color: white;
            }
            .btn-delete {
                background-color: #f44336;
                color: white;
            }
        </style>

    </head>
    <body>
        <%
    if(AuthUtils.isLoggedIn(request)){
        UserDTO user = AuthUtils.getCurrentUser(request);
        String keyword = (String)request.getAttribute("keyword");
        %>
        <h1>Hello && Welcome <%= user.getFullName() %></h1>
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
                <tr>
            <th>id</th>
            <th>Name</th>
            <th>Image</th>
            <th>Description</th>
            <th>Price</th>
            <th>Size</th>
            <th>Status</th>
            <%if(AuthUtils.isAdmin(request)) 
            %>
            <th>Action</th>
            <% }%>
        </tr>
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

            <td>
                <div class="btn-group">
                    <a class="btn btn-edit" href="MainController?action=editProduct&id=<%= pro.getId() %>">Edit ✏️</a>
                    <a class="btn btn-delete" href="MainController?action=deleteProduct&id=<%= pro.getId() %>" onclick="return confirm('Are you sure you want to delete this product?');">Delete  🗑️</a>
                </div>
            </td>
        </tr>

        <%
        }
        %>
    </tbody>                <!--if(pro.istatus()) is false hidden in the list search products-->
</table>
<%
    }
%>
<% } else { %>
<%=AuthUtils.getAccessDeniedMessage("welcome.jsp")%> <br/>
(Or <a href="<%=AuthUtils.getLoginURL()%>">Login</a>)
<% } %>
</body>
</html>
