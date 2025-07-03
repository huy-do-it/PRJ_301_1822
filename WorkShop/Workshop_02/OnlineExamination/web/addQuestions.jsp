<%-- 
    Document   : addQuestions
    Created on : Jul 3, 2025, 6:06:38 PM
    Author     : ddhuy
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Question</title>
    </head>
    <body>
        <h1>Add Question to Exam: ${exam.examTitle}</h1>

        <!-- Check if user is instructor -->
        <c:if test="${sessionScope.user.role ne 'Instructor'}">
            <p>Access denied. Only instructors can add questions.</p>
            <a href="ExamCategoriesController">Back to Dashboard</a>
        </c:if>

        <c:if test="${sessionScope.user.role eq 'Instructor'}">
            <!-- Display success/error messages -->
            <c:if test="${not empty successMessage}">
                <p style="color: green;">${successMessage}</p>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <p style="color: red;">${errorMessage}</p>
            </c:if>

            <form action="ExamCategoriesController" method="get">
                <input type="hidden" name="action" value="add-question"/>
                <input type="hidden" name="examId" value="${exam.examId}">

                <table border="1">
                    <tr>
                        <td>Question Text:</td>
                        <td><textarea name="questionText" rows="4" cols="50" required></textarea></td>
                    </tr>
                    <tr>
                        <td>Option A:</td>
                        <td><input type="text" name="optionA" required></td>
                    </tr>
                    <tr>
                        <td>Option B:</td>
                        <td><input type="text" name="optionB" required></td>
                    </tr>
                    <tr>
                        <td>Option C:</td>
                        <td><input type="text" name="optionC" required></td>
                    </tr>
                    <tr>
                        <td>Option D:</td>
                        <td><input type="text" name="optionD" required></td>
                    </tr>
                    <tr>
                        <td>Correct Option:</td>
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

            <br>
            <h3>Existing Questions for this Exam:</h3>
            <c:choose>
                <c:when test="${empty questions}">
                    <p>No questions added yet.</p>
                </c:when>
                <c:otherwise>
                    <table border="1">
                        <tr>
                            <th>Question ID</th>
                            <th>Question Text</th>
                            <th>Option A</th>
                            <th>Option B</th>
                            <th>Option C</th>
                            <th>Option D</th>
                            <th>Correct Answer</th>
                        </tr>
                        <c:forEach items="${questions}" var="question">
                            <tr>
                                <td>${question.questionId}</td>
                                <td>${question.questionText}</td>
                                <td>${question.optionA}</td>
                                <td>${question.optionB}</td>
                                <td>${question.optionC}</td>
                                <td>${question.optionD}</td>
                                <td>${question.correctOption}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>

            <br>
            <a href="ExamCategoriesController">Back to Dashboard</a>
        </c:if>
    </body>
</html>