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
        
        <style>
            /* ===== SPACE THEME CSS - FORM PROJECT ===== */
            /* Reset và thiết lập cơ bản */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Arial', sans-serif;
                background: linear-gradient(135deg, #0c0c0c 0%, #1a0033 50%, #000814 100%);
                color: #ffffff;
                min-height: 100vh;
                position: relative;
                overflow-x: hidden;
                padding: 20px;
            }

            /* Hiệu ứng sao nhấp nháy */
            body::before {
                content: '';
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image:
                    radial-gradient(2px 2px at 20px 30px, #eee, transparent),
                    radial-gradient(2px 2px at 40px 70px, rgba(255,255,255,0.8), transparent),
                    radial-gradient(1px 1px at 90px 40px, #fff, transparent),
                    radial-gradient(1px 1px at 130px 80px, rgba(255,255,255,0.6), transparent);
                background-size: 200px 200px;
                animation: twinkle 4s ease-in-out infinite alternate;
                pointer-events: none;
                z-index: -1;
            }

            @keyframes twinkle {
                0% {
                    opacity: 0.3;
                }
                100% {
                    opacity: 1;
                }
            }

            /* Container chính */
            .container {
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
            }

            /* Header actions */
            .header-actions {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
                padding: 20px 0;
            }

            .back-link {
                background: linear-gradient(45deg, #667eea, #764ba2);
                color: white;
                padding: 12px 20px;
                text-decoration: none;
                border-radius: 25px;
                font-weight: bold;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .back-link:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
                filter: brightness(1.1);
            }

            /* Tiêu đề */
            h1 {
                font-size: 2.2em;
                background: linear-gradient(45deg, #00d4ff, #ff0080, #ffff00);
                background-clip: text;
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                text-shadow: 0 0 30px rgba(0, 212, 255, 0.5);
                animation: glow 2s ease-in-out infinite alternate;
                text-align: center;
            }

            @keyframes glow {
                from {
                    filter: drop-shadow(0 0 20px rgba(0, 212, 255, 0.3));
                }
                to {
                    filter: drop-shadow(0 0 30px rgba(255, 0, 128, 0.6));
                }
            }

            /* Thông báo thành công */
            .success {
                background: linear-gradient(45deg, #32cd32, #228b22);
                color: white;
                padding: 15px 25px;
                border-radius: 15px;
                margin: 20px 0;
                text-align: center;
                font-weight: bold;
                box-shadow: 0 4px 15px rgba(50, 205, 50, 0.3);
                animation: slideIn 0.5s ease-out;
            }

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

            /* Form chính */
            .search-form {
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 20px;
                padding: 40px;
                margin: 30px 0;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
                max-width: 700px;
                margin-left: auto;
                margin-right: auto;
            }

            /* Form group */
            .form-group {
                margin-bottom: 25px;
            }

            .form-group label {
                display: block;
                margin-bottom: 10px;
                font-size: 1.1em;
                color: #00d4ff;
                font-weight: bold;
            }

            .required {
                color: #ff4757;
                font-size: 1.1em;
            }

            /* Input text và textarea */
            .form-group input[type="text"],
            .form-group input[type="date"],
            .form-group textarea,
            .form-group select {
                width: 100%;
                padding: 15px 20px;
                border: 2px solid transparent;
                border-radius: 15px;
                background: rgba(255, 255, 255, 0.1);
                color: white;
                font-size: 1em;
                transition: all 0.3s ease;
            }

            .form-group input[type="text"]:focus,
            .form-group input[type="date"]:focus,
            .form-group textarea:focus,
            .form-group select:focus {
                outline: none;
                border-color: #00d4ff;
                box-shadow: 0 0 20px rgba(0, 212, 255, 0.3);
                background: rgba(255, 255, 255, 0.15);
            }

            .form-group input::placeholder,
            .form-group textarea::placeholder {
                color: rgba(255, 255, 255, 0.6);
            }

            /* Textarea riêng */
            .form-group textarea {
                resize: vertical;
                min-height: 120px;
                font-family: inherit;
            }

            /* Select dropdown */
            .form-group select {
                cursor: pointer;
            }

            .form-group select option {
                background: #1a0033;
                color: white;
                padding: 10px;
            }

            /* Error messages */
            .form-error {
                color: #ff4757;
                font-size: 0.9em;
                margin-top: 8px;
                padding: 8px 12px;
                background: rgba(255, 71, 87, 0.1);
                border-left: 3px solid #ff4757;
                border-radius: 5px;
            }

            /* Submit và Reset buttons */
            .search-form > div:last-child {
                display: flex;
                gap: 20px;
                justify-content: center;
                margin-top: 40px;
            }

            .submit-btn {
                background: linear-gradient(45deg, #32cd32, #228b22);
                color: white;
                padding: 15px 40px;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                font-weight: bold;
                font-size: 1.1em;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(50, 205, 50, 0.3);
            }

            .submit-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(50, 205, 50, 0.5);
                filter: brightness(1.1);
            }

            .reset-btn {
                background: linear-gradient(45deg, #ff4757, #ff3838);
                color: white;
                padding: 15px 40px;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                font-weight: bold;
                font-size: 1.1em;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(255, 71, 87, 0.3);
            }

            .reset-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(255, 71, 87, 0.5);
                filter: brightness(1.1);
            }

            /* Access Denied giống như trước */
            .access-denied {
                text-align: center;
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 20px;
                padding: 50px 30px;
                margin: 100px auto;
                max-width: 500px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            }

            .access-denied h2 {
                color: #ff4757;
                margin-bottom: 20px;
                font-size: 2em;
            }

            .access-denied p {
                font-size: 1.2em;
                margin-bottom: 30px;
                color: rgba(255, 255, 255, 0.8);
            }

            .login-link {
                background: linear-gradient(45deg, #00d4ff, #0099cc);
                color: white;
                padding: 15px 30px;
                text-decoration: none;
                border-radius: 25px;
                font-weight: bold;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(0, 212, 255, 0.3);
                display: inline-block;
            }

            .login-link:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(0, 212, 255, 0.5);
            }

            /* Responsive cho mobile */
            @media (max-width: 768px) {
                body {
                    padding: 10px;
                }

                .header-actions {
                    flex-direction: column;
                    gap: 20px;
                    text-align: center;
                }

                h1 {
                    font-size: 1.8em;
                }

                .search-form {
                    padding: 25px;
                    margin: 20px 0;
                }

                .search-form > div:last-child {
                    flex-direction: column;
                    gap: 15px;
                }

                .submit-btn,
                .reset-btn {
                    width: 100%;
                    padding: 15px 20px;
                }

                .back-link {
                    align-self: center;
                }
            }

            /* Hiệu ứng loading cho button */
            .submit-btn:active,
            .reset-btn:active,
            .back-link:active,
            .login-link:active {
                transform: scale(0.98);
            }

            /* Hiệu ứng cho form khi load */
            .search-form {
                animation: fadeInUp 0.6s ease-out;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Custom date picker */
            input[type="date"]::-webkit-calendar-picker-indicator {
                filter: invert(1);
                cursor: pointer;
            }

            /* Focus ring cho accessibility */
            *:focus {
                outline: 2px solid #00d4ff;
                outline-offset: 2px;
            }
        </style>
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
                        <c:if test="${not empty errorName}">
                            <div class="form-error">${errorName}</div>
                        </c:if>
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label for="description">Description: </label>
                        <textarea id="description" name="description" placeholder="Enter project description (min 5 characters)" 
                                  rows="4">${not empty inputDescription ? inputDescription : ( project != null ? project.description : '')}
                        </textarea>
                        <c:if test="${not empty errorDescription}">
                            <div class="form-error">${errorDescription}</div>
                        </c:if>
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
                        <c:if test="${not empty errorStatus}">
                            <div class="form-error">${errorStatus}</div>
                        </c:if>
                    </div>

                    <!-- Estimated Launch Date -->
                    <div class="form-group">
                        <label for="estimatedLaunch">Estimated Launch Date: <span class="required">*</span></label>
                        <input type="date" id="estimatedLaunch" name="estimatedLaunch" required 
                               value="${not empty inputEstimatedLaunch ? inputEstimatedLaunch : ( project != null ? project.estimatedLaunch : '')}"
                               />
                        <c:if test="${not empty errorEstimatedLaunch}">
                            <div class="form-error">${errorEstimatedLaunch}</div>
                        </c:if>
                    </div>
                    <!-- submit button -->
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
                        <p>You need to login with 'Admin' role to access this page. Please contact manager for more infomation!!</p>
                        <a href="login.jsp" class="login-link">Login Now</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </body>
</html>
