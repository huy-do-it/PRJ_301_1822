<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Question - Online Exam System</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 20px;
                color: #333;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                padding: 40px;
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            h1 {
                text-align: center;
                color: #2d3748;
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 30px;
                background: linear-gradient(135deg, #667eea, #764ba2);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            h3 {
                color: #2d3748;
                font-size: 1.5rem;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            h3::before {
                content: "📝";
                font-size: 1.2rem;
            }

            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                color: #667eea;
                text-decoration: none;
                font-weight: 600;
                padding: 12px 24px;
                border: 2px solid #667eea;
                border-radius: 12px;
                transition: all 0.3s ease;
                margin-bottom: 30px;
                background: transparent;
            }

            .back-link:hover {
                background: #667eea;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            }

            .back-link::before {
                content: "←";
                font-size: 1.2rem;
            }

            .message {
                padding: 15px 20px;
                border-radius: 12px;
                margin-bottom: 20px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .message.success {
                background: rgba(56, 161, 105, 0.1);
                color: #38a169;
                border-left: 4px solid #38a169;
            }

            .message.success::before {
                content: "✅";
            }

            .message.error {
                background: rgba(229, 62, 62, 0.1);
                color: #e53e3e;
                border-left: 4px solid #e53e3e;
            }

            .message.error::before {
                content: "❌";
            }

            .access-denied {
                text-align: center;
                padding: 60px 40px;
                background: white;
                border-radius: 16px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            }

            .access-denied p {
                color: #e53e3e;
                font-size: 1.2rem;
                margin-bottom: 20px;
            }

            .form-container {
                background: white;
                padding: 30px;
                border-radius: 16px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                border: 1px solid rgba(0, 0, 0, 0.05);
                margin-bottom: 40px;
            }

            form table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background: white;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            }

            form table td {
                padding: 20px;
                border-bottom: 1px solid #e2e8f0;
                vertical-align: top;
            }

            form table td:first-child {
                background: #f8fafc;
                font-weight: 600;
                color: #2d3748;
                width: 200px;
                border-right: 1px solid #e2e8f0;
            }

            form table tr:last-child td {
                border-bottom: none;
                text-align: center;
                background: #f8fafc;
            }

            textarea {
                width: 100%;
                padding: 15px;
                border: 2px solid #e2e8f0;
                border-radius: 8px;
                font-size: 1rem;
                font-family: inherit;
                resize: vertical;
                transition: all 0.3s ease;
                background: #f8fafc;
            }

            textarea:focus {
                outline: none;
                border-color: #667eea;
                background: white;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            input[type="text"] {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid #e2e8f0;
                border-radius: 8px;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: #f8fafc;
            }

            input[type="text"]:focus {
                outline: none;
                border-color: #667eea;
                background: white;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            select {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid #e2e8f0;
                border-radius: 8px;
                font-size: 1rem;
                background: #f8fafc;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            select:focus {
                outline: none;
                border-color: #667eea;
                background: white;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            input[type="submit"] {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                padding: 12px 30px;
                border: none;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-right: 15px;
            }

            input[type="submit"]:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            }

            input[type="reset"] {
                background: transparent;
                color: #718096;
                padding: 12px 30px;
                border: 2px solid #e2e8f0;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            input[type="reset"]:hover {
                background: #f8fafc;
                border-color: #cbd5e0;
                transform: translateY(-1px);
            }

            .questions-table {
                background: white;
                border-radius: 16px;
                padding: 30px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                border: 1px solid rgba(0, 0, 0, 0.05);
            }

            .data-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background: white;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            }

            .data-table th {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                padding: 15px;
                text-align: left;
                font-weight: 600;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .data-table td {
                padding: 15px;
                border-bottom: 1px solid #e2e8f0;
                vertical-align: top;
            }

            .data-table tr:hover {
                background: #f8fafc;
            }

            .data-table tr:last-child td {
                border-bottom: none;
            }

            .no-questions {
                text-align: center;
                padding: 40px;
                color: #718096;
                font-size: 1.1rem;
                background: #f8fafc;
                border-radius: 12px;
                border: 2px dashed #e2e8f0;
            }

            .no-questions::before {
                content: "📝";
                font-size: 2rem;
                display: block;
                margin-bottom: 15px;
            }

            .floating-shapes {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: -1;
            }

            .floating-shapes::before,
            .floating-shapes::after {
                content: '';
                position: absolute;
                width: 150px;
                height: 150px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 50%;
                animation: float 6s ease-in-out infinite;
            }

            .floating-shapes::before {
                top: 20%;
                left: 15%;
                animation-delay: 0s;
            }

            .floating-shapes::after {
                bottom: 20%;
                right: 15%;
                animation-delay: 3s;
            }

            @keyframes float {
                0%, 100% { transform: translateY(0px); }
                50% { transform: translateY(-20px); }
            }

            .question-id {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                display: inline-block;
                min-width: 30px;
                text-align: center;
            }

            .correct-answer {
                background: #38a169;
                color: white;
                padding: 5px 12px;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.9rem;
                display: inline-block;
                min-width: 30px;
                text-align: center;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 20px;
                    margin: 10px;
                }

                h1 {
                    font-size: 2rem;
                }

                form table td {
                    padding: 15px;
                    display: block;
                    width: 100%;
                }

                form table td:first-child {
                    background: transparent;
                    border-right: none;
                    border-bottom: 1px solid #e2e8f0;
                    padding-bottom: 10px;
                    font-weight: 600;
                }

                .data-table {
                    font-size: 0.8rem;
                }

                .data-table th,
                .data-table td {
                    padding: 8px;
                }
            }
        </style>
    </head>
    <body>
        <div class="floating-shapes"></div>
        
        <div class="container">
            <h1>Add Question to Exam: ${exam.examTitle}</h1>

            <!-- Check if user is instructor -->
            <c:if test="${sessionScope.user.role != 'Instructor'}">
                <div class="access-denied">
                    <p>🚫 Access denied. Only instructors can add questions.</p>
                    <a href="ExamCategoriesController" class="back-link">Back to Dashboard</a>
                </div>
            </c:if>

            <c:if test="${sessionScope.user.role eq 'Instructor'}">
                <!-- Display success/error messages -->
                <c:if test="${not empty successMessage}">
                    <div class="message success">${successMessage}</div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="message error">${errorMessage}</div>
                </c:if>
                
                <a href="ExamCategoriesController" class="back-link">Back to Dashboard</a>
                
                <div class="form-container">
                    <form action="ExamCategoriesController" method="get">
                        <input type="hidden" name="action" value="add-question"/>
                        <input type="hidden" name="examId" value="${exam.examId}">

                        <table>
                            <tr>
                                <td>❓ Question Text:</td>
                                <td><textarea name="questionText" rows="4" cols="50" placeholder="Enter your question here..." required></textarea></td>
                            </tr>
                            <tr>
                                <td>🅰️ Option A:</td>
                                <td><input type="text" name="optionA" placeholder="Enter option A" required></td>
                            </tr>
                            <tr>
                                <td>🅱️ Option B:</td>
                                <td><input type="text" name="optionB" placeholder="Enter option B" required></td>
                            </tr>
                            <tr>
                                <td>🅲️ Option C:</td>
                                <td><input type="text" name="optionC" placeholder="Enter option C" required></td>
                            </tr>
                            <tr>
                                <td>🅳️ Option D:</td>
                                <td><input type="text" name="optionD" placeholder="Enter option D" required></td>
                            </tr>
                            <tr>
                                <td>✅ Correct Option:</td>
                                <td>
                                    <select name="correctOption" required>
                                        <option value="">Select correct option</option>
                                        <option value="A">A</option>
                                        <option value="B">B</option>
                                        <option value="C">C</option>
                                        <option value="D">D</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input type="submit" value="Add Question">
                                    <input type="reset" value="Clear">
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>

                <div class="questions-table">
                    <h3>Existing Questions for this Exam</h3>
                    <c:choose>
                        <c:when test="${empty questions}">
                            <div class="no-questions">
                                No questions added yet.
                                <br><small>Add your first question using the form above.</small>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <table class="data-table">
                                <tr>
                                    <th>ID</th>
                                    <th>Question Text</th>
                                    <th>Option A</th>
                                    <th>Option B</th>
                                    <th>Option C</th>
                                    <th>Option D</th>
                                    <th>Correct Answer</th>
                                </tr>
                                <c:forEach items="${questions}" var="question">
                                    <tr>
                                        <td><span class="question-id">${question.questionId}</span></td>
                                        <td>${question.questionText}</td>
                                        <td>${question.optionA}</td>
                                        <td>${question.optionB}</td>
                                        <td>${question.optionC}</td>
                                        <td>${question.optionD}</td>
                                        <td><span class="correct-answer">${question.correctOption}</span></td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>
    </body>
</html>