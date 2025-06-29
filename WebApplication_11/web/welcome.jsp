<%-- 
    Document   : welcome
    Created on : May 23, 2025, 10:26:58 AM
    Author     : ddhuy
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Management System</title>
        <style>
            /* General Styles */
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f4f4f4;
                line-height: 1.6;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            /* Header Styles */
            h1 {
                color: #333;
                margin-bottom: 10px;
                font-size: 28px;
            }

            .header-section {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 2px solid #eee;
            }

            .header-actions {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            .add-product-btn {
                background-color: #28a745;
                color: white;
                padding: 8px 16px;
                text-decoration: none;
                border-radius: 4px;
                font-size: 14px;
                transition: background-color 0.3s;
                border: none;
                cursor: pointer;
            }

            .add-product-btn:hover {
                background-color: #218838;
            }

            .logout-btn {
                background-color: #d32f2f;
                color: white;
                padding: 8px 16px;
                text-decoration: none;
                border-radius: 4px;
                font-size: 14px;
                transition: background-color 0.3s;
            }

            .logout-btn:hover {
                background-color: #b71c1c;
            }

            /* Search Form Styles */
            .search-section {
                margin: 25px 0;
                padding: 20px;
                background-color: #f8f9fa;
                border-radius: 6px;
                border: 1px solid #dee2e6;
            }

            .search-label {
                font-weight: bold;
                color: #495057;
                margin-bottom: 10px;
                display: block;
            }

            .search-form {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            .search-input {
                padding: 10px 12px;
                border: 2px solid #ced4da;
                border-radius: 4px;
                font-size: 14px;
                width: 300px;
                transition: border-color 0.3s;
            }

            .search-input:focus {
                outline: none;
                border-color: #007bff;
                box-shadow: 0 0 5px rgba(0,123,255,0.3);
            }

            .search-btn {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
                transition: background-color 0.3s;
            }

            .search-btn:hover {
                background-color: #0056b3;
            }

            /* Message Styles */
            .no-results {
                text-align: center;
                padding: 30px;
                background-color: #fff3cd;
                border: 1px solid #ffeaa7;
                border-radius: 4px;
                color: #856404;
                font-size: 16px;
                margin: 20px 0;
            }

            /* Access Denied Styles */
            .access-denied {
                text-align: center;
                padding: 40px;
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                border-radius: 4px;
                color: #721c24;
            }

            .login-link {
                display: inline-block;
                margin-top: 15px;
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s;
            }

            .login-link:hover {
                background-color: #0056b3;
            }

            /* Table Styles */
            .table-container {
                margin-top: 25px;
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                background-color: white;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                border-radius: 6px;
                overflow: hidden;
            }

            th {
                background-color: #007bff;
                color: white;
                padding: 15px 12px;
                text-align: left;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 14px;
                letter-spacing: 0.5px;
            }

            td {
                padding: 12px;
                border-bottom: 1px solid #dee2e6;
                vertical-align: middle;
            }

            tbody tr {
                transition: background-color 0.3s ease;
            }

            tbody tr:nth-child(even) {
                background-color: #f8f9fa;
            }

            tbody tr:hover {
                background-color: #e3f2fd;
                cursor: pointer;
            }

            /* Status styling */
            .status-active {
                color: #28a745;
                font-weight: bold;
            }

            .status-inactive {
                color: #dc3545;
                font-weight: bold;
            }

            /* Price styling */
            .price {
                font-weight: bold;
                color: #007bff;
            }

            /* Action buttons */
            .action-buttons {
                display: flex;
                gap: 5px;
                flex-wrap: wrap;
            }

            .edit-btn {
                background-color: #ffc107;
                color: #212529;
                padding: 4px 8px;
                border: none;
                border-radius: 3px;
                cursor: pointer;
                font-size: 12px;
                text-decoration: none;
                display: inline-block;
                transition: background-color 0.3s;
            }

            .edit-btn:hover {
                background-color: #e0a800;
            }

            .delete-btn {
                background-color: #dc3545;
                color: white;
                padding: 4px 8px;
                border: none;
                border-radius: 3px;
                cursor: pointer;
                font-size: 12px;
                transition: background-color 0.3s;
            }

            .delete-btn:hover {
                background-color: #c82333;
            }

            /* Responsive Design */
            @media screen and (max-width: 768px) {
                .container {
                    padding: 15px;
                    margin: 10px;
                }

                .header-section {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }

                .search-form {
                    flex-direction: column;
                    align-items: stretch;
                }

                .search-input {
                    width: 100%;
                }

                table {
                    font-size: 12px;
                }

                th, td {
                    padding: 8px 6px;
                }

                .action-buttons {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <!-- Kiểm tra đăng nhập -->
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <div class="container">
                    <div class="header-section">
                        <h1>Hello and welcome ${sessionScope.user.fullName}!</h1>
                        <div class="header-actions">
                            <a href="MainController?action=logout" class="logout-btn">Logout</a>
                        </div>
                    </div>

                    <div class="content">
                        <div class="search-section">
                            <form action="MainController" method="post" class="search-form">
                                <input type="hidden" name="action" value="searchProduct"/>
                                <label class="search-label">Search product by name:</label>
                                <input type="text" name="keyword" value="${not empty requestScope.keyword ? requestScope.keyword : ''}" 
                                       class="search-input" placeholder="Enter product name..."/>
                                <input type="submit" value="Search" class="search-btn"/>
                            </form>
                        </div>

                        <!-- Hiển thị nút Add Product nếu là admin -->
                        <c:if test="${sessionScope.user.roleID eq 'AD'}">
                            <a href="productForm.jsp" class="add-product-btn">Add Product</a>
                        </c:if>

                        <!-- Xử lý danh sách sản phẩm -->
                        <c:choose>
                            <c:when test="${not empty requestScope.list and fn:length(requestScope.list) == 0}">
                                <div class="no-results">
                                    No products have names that match the keyword!
                                </div>
                            </c:when>
                            <c:when test="${not empty requestScope.list and fn:length(requestScope.list) > 0}">
                                <table class="products-table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Image</th>
                                            <th>Description</th>
                                            <th>Price</th>
                                            <th>Size</th>
                                            <th>Status</th>
                                                <c:if test="${sessionScope.user.roleID eq 'AD'}">
                                                <th>Action</th>
                                                </c:if>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="product" items="${requestScope.list}">
                                            <tr>
                                                <td data-label="ID" class="product-id">${product.id}</td>
                                                <td data-label="Name" class="product-name">${product.name}</td>
                                                <td data-label="Image">
                                                    <c:choose>
                                                        <c:when test="${not empty product.image}">
                                                            <img src="${product.image}" alt="Product Image" style="width: 50px; height: 50px; object-fit: cover;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${product.image}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td data-label="Description">${product.description}</td>
                                                <td data-label="Price" class="product-price price">$${product.price}</td>
                                                <td data-label="Size">${product.size}</td>
                                                <td data-label="Status">
                                                    <span class="product-status ${product.status ? 'status-active' : 'status-inactive'}">
                                                        ${product.status ? 'Active' : 'Inactive'}
                                                    </span>
                                                </td>
                                                <c:if test="${sessionScope.user.roleID eq 'AD'}">
                                                    <td data-label="Action">
                                                        <div class="action-buttons">
                                                            <form action="MainController" method="get" style="display: inline;">
                                                                <input type="hidden" name="action" value="editProduct"/>
                                                                <input type="hidden" name="productId" value="${product.id}"/>
                                                                <input type="hidden" name="keyword" value="${not empty requestScope.keyword ? requestScope.keyword : ''}" />
                                                                <input type="submit" value="Edit" class="edit-btn" />
                                                            </form>
                                                            <form action="MainController" method="get" style="display: inline;">
                                                                <input type="hidden" name="action" value="changeProductStatus"/>
                                                                <input type="hidden" name="productId" value="${product.id}"/>
                                                                <input type="hidden" name="keyword" value="${not empty requestScope.keyword ? requestScope.keyword : ''}" />
                                                                <input type="submit" value="Delete" class="delete-btn" 
                                                                       onclick="return confirm('Are you sure you want to delete this product?')"/>
                                                            </form>
                                                        </div>
                                                    </td>
                                                </c:if>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div class="no-results">
                                    <h3>No products available</h3>
                                    <p>There are no products in the system yet.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="container">
                    <div class="access-denied">
                        <h2>Access Denied</h2>
                        <p>You need to login to access this page.</p>
                        <a href="MainController?action=login" class="login-link">Login Now</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </body>
</html>