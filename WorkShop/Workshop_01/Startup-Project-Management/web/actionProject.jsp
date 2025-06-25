<%-- 
    Document   : createProject
    Created on : Jun 22, 2025, 9:37:09 PM
    Author     : ddhuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="f" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Action page</title>
        <!--        <style>
                    /* Reset và base styles */
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }
        
                    body {
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        min-height: 100vh;
                        padding: 20px;
                        color: #333;
                    }
        
                    /* Container chính */
                    .container {
                        max-width: 800px;
                        margin: 0 auto;
                        background: rgba(255, 255, 255, 0.95);
                        border-radius: 15px;
                        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                        overflow: hidden;
                    }
        
                    /* Header actions */
                    .header-actions {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 20px 30px;
                        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                        color: white;
                    }
        
                    .header-actions:first-child {
                        padding: 15px 30px;
                        background: rgba(255, 255, 255, 0.1);
                    }
        
                    .header-actions h1 {
                        font-size: 28px;
                        font-weight: 700;
                        text-align: center;
                        flex: 1;
                        margin: 0;
                        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                    }
        
                    /* Navigation links */
                    .back-link, .logout-btn {
                        color: white;
                        text-decoration: none;
                        padding: 10px 20px;
                        border-radius: 25px;
                        background: rgba(255, 255, 255, 0.2);
                        border: 1px solid rgba(255, 255, 255, 0.3);
                        transition: all 0.3s ease;
                        font-weight: 500;
                    }
        
                    .back-link:hover, .logout-btn:hover {
                        background: rgba(255, 255, 255, 0.3);
                        transform: translateY(-2px);
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                    }
        
                    /* Messages */
                    .success, .error {
                        padding: 15px 30px;
                        margin: 20px 30px;
                        border-radius: 8px;
                        font-weight: 500;
                        animation: slideIn 0.5s ease;
                    }
        
                    .success {
                        background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
                        color: #2d5a27;
                        border-left: 4px solid #4caf50;
                    }
        
                    .error {
                        background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
                        color: #c62828;
                        border-left: 4px solid #f44336;
                    }
        
                    /* Form styling */
                    .search-form {
                        padding: 30px;
                    }
        
                    .form-group {
                        margin-bottom: 25px;
                    }
        
                    .form-group label {
                        display: block;
                        font-weight: 600;
                        color: #444;
                        margin-bottom: 8px;
                        font-size: 16px;
                    }
        
                    .required {
                        color: #e74c3c;
                        font-weight: bold;
                    }
        
                    /* Input fields */
                    input[type="text"],
                    input[type="date"],
                    select,
                    textarea {
                        width: 100%;
                        padding: 15px;
                        border: 2px solid #e1e8ed;
                        border-radius: 10px;
                        font-size: 16px;
                        transition: all 0.3s ease;
                        background: #fafbfc;
                        font-family: inherit;
                    }
        
                    input[type="text"]:focus,
                    input[type="date"]:focus,
                    select:focus,
                    textarea:focus {
                        outline: none;
                        border-color: #4facfe;
                        background: white;
                        box-shadow: 0 0 0 3px rgba(79, 172, 254, 0.1);
                        transform: translateY(-2px);
                    }
        
                    /* Textarea specific */
                    textarea {
                        resize: vertical;
                        min-height: 100px;
                        line-height: 1.5;
                    }
        
                    /* Select dropdown */
                    select {
                        cursor: pointer;
                        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
                        background-position: right 12px center;
                        background-repeat: no-repeat;
                        background-size: 16px;
                        padding-right: 45px;
                        appearance: none;
                    }
        
                    /* Button container */
                    .search-form > div:last-child {
                        display: flex;
                        gap: 15px;
                        justify-content: center;
                        margin-top: 35px;
                    }
        
                    /* Buttons */
                    .sumit-btn, .reset-btn {
                        padding: 15px 35px;
                        border: none;
                        border-radius: 25px;
                        font-size: 16px;
                        font-weight: 600;
                        cursor: pointer;
                        transition: all 0.3s ease;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                        min-width: 150px;
                    }
        
                    .sumit-btn {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
                    }
        
                    .sumit-btn:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 8px 25px rgba(102, 126, 234, 0.6);
                    }
        
                    .reset-btn {
                        background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
                        color: #8b4513;
                        box-shadow: 0 4px 15px rgba(252, 182, 159, 0.4);
                    }
        
                    .reset-btn:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 8px 25px rgba(252, 182, 159, 0.6);
                    }
        
                    /* Access Denied styling */
                    .access-denied {
                        text-align: center;
                        padding: 60px 30px;
                        background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
                    }
        
                    .access-denied h2 {
                        color: #c62828;
                        font-size: 32px;
                        margin-bottom: 20px;
                        font-weight: 700;
                    }
        
                    .access-denied p {
                        color: #666;
                        font-size: 18px;
                        margin-bottom: 30px;
                        line-height: 1.6;
                    }
        
                    .login-link {
                        display: inline-block;
                        padding: 15px 30px;
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        text-decoration: none;
                        border-radius: 25px;
                        font-weight: 600;
                        transition: all 0.3s ease;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }
        
                    .login-link:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 8px 25px rgba(102, 126, 234, 0.6);
                    }
        
                    /* Error messages trong form */
                    .form-group .error {
                        margin: 5px 0 0 0;
                        padding: 8px 12px;
                        font-size: 14px;
                        border-radius: 5px;
                        display: block;
                    }
        
                    /* Animations */
                    @keyframes slideIn {
                        from {
                            opacity: 0;
                            transform: translateY(-20px);
                        }
                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }
        
                    /* Responsive design */
                    @media (max-width: 768px) {
                        body {
                            padding: 10px;
                        }
        
                        .container {
                            margin: 0;
                            border-radius: 10px;
                        }
        
                        .header-actions {
                            flex-direction: column;
                            gap: 15px;
                            text-align: center;
                            padding: 20px;
                        }
        
                        .header-actions h1 {
                            font-size: 24px;
                        }
        
                        .search-form {
                            padding: 20px;
                        }
        
                        .search-form > div:last-child {
                            flex-direction: column;
                            align-items: center;
                        }
        
                        .sumit-btn, .reset-btn {
                            width: 100%;
                            max-width: 250px;
                        }
                    }
        
                    @media (max-width: 480px) {
                        .header-actions h1 {
                            font-size: 20px;
                        }
        
                        .back-link, .logout-btn {
                            padding: 8px 16px;
                            font-size: 14px;
                        }
        
                        input[type="text"],
                        input[type="date"],
                        select,
                        textarea {
                            padding: 12px;
                            font-size: 14px;
                        }
        
                        .sumit-btn, .reset-btn {
                            padding: 12px 25px;
                            font-size: 14px;
                        }
                    }
                </style>-->
    </head>
    <body>
        <c:choose>
            <c:when test="${sessionScope.user.role eq 'Founder' }">
                <c:set var="isEdit" value="${requestScope.isEdit != null}" />
                <c:set var="project" value="${requestScope.projects}" />
                <div class="header-actions">
                    <a href="MainController?action=searchProject&keyword=" class="back-link">← Back to project</a>
                    <c:choose>
                        <c:when test="${isEdit}"><h1>EDIT PROJECT</h1></c:when>
                        <c:otherwise><h1>CREATE NEW PROJECT</h1></c:otherwise>
                    </c:choose>

                </div>
                <!-- Success message -->
                <c:if test="${not empty message}">
                    <div class="success">${message}</div>
                </c:if>

                <!-- Error message -->
                <c:if test="${not empty checkError}">
                    <div class="error">${checkError}</div>
                </c:if>

                <form action="MainController" method="post" class="search-form"> 
                    <input type="hidden" name="action" value="${isEdit ? 'updateProject' : 'createProject'  }"/>
                    <!-- Thêm projectId khi edit -->
                    <c:if test="${isEdit && project != null }">
                        <input type="hidden" name="projectId" value="${project.projectId}"/>
                    </c:if>
                    <!-- Project Name -->
                    <div class="form-group">
                        <label for="name">Project Name: <span class="required">*</span></label>
                        <input type="text" id="name" name="name" required 
                               placeholder="Enter project name (3-100 characters)"  
                               value="${not empty inputName ? inputName : ( project != null ? project.projectName : '')}"
                               />
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label for="description">Description: </label>
                        <textarea id="description" name="description" placeholder="Enter project description (min 5 characters)" 
                                  rows="4">${not empty inputDescription ? inputDescription : ( project != null ? project.description : '')}
                        </textarea>

                    </div>

                    <!-- Status -->
                    <div class="form-group">
                        <label for="status">Status: <span class="required">*</span></label>
                        <select id="status" name="status" required>
                            <option value="">Select status</option>
                            <!-- Xác định giá trị hiện tại của status -->
                            <c:set var="currentStatus" value="${not empty inputStatus ? inputStatus : ( project != null ? project.status : '')}" />
                            <option value="Ideation" ${currentStatus eq 'Ideation' ? 'selected' : ''}>Ideation</option>
                            <option value="Development" ${currentStatus eq 'Development' ? 'selected' : ''}>Development</option>
                            <option value="Launch" ${currentStatus eq 'Launch' ? 'selected' : ''}>Launch</option>
                            <option value="Scaling" ${currentStatus eq 'Scaling' ? 'selected' : ''}>Scaling</option>
                        </select>
                    </div>

                    <!-- Estimated Launch Date -->
                    <div class="form-group">
                        <label for="estimatedLaunch">Estimated Launch Date: <span class="required">*</span></label>
                        <input type="date" id="estimatedLaunch" name="estimatedLaunch" required 
                               value="${not empty inputEstimatedLaunch ? inputEstimatedLaunch : ( project != null ? project.estimatedLaunch : '')}"
                               />
                    </div>
                               <c:out value="${project.projectName}" />
                    <div>                    
                        <input type="submit" value="${isEdit ? 'Update Project' : 'Create Project'}" class="submit-btn"/>
                        <input type="reset" value="Clear form" class="reset-btn"/>
                    </div>
                </form>

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
