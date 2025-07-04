package controller;

import dao.ExamCategoriesDAO;
import dao.ExamsDAO;
import dao.QuestionsDAO;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Exam;
import model.ExamCategories;
import model.Questions;
import model.User;

@WebServlet(name = "ExamCategoriesController", urlPatterns = {"/ExamCategoriesController"})
public class ExamCategoriesController extends HttpServlet {

    private static final String CREATE_PAGE = "createExam.jsp";
    private static final String DASHBOARD_PAGE = "welcome.jsp";
    private static final String ADD_QUESTION_PAGE = "addQuestions.jsp";

    ExamCategoriesDAO exCaDAO = new ExamCategoriesDAO();
    ExamsDAO examDAO = new ExamsDAO();
    QuestionsDAO queDAO = new QuestionsDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        String url = DASHBOARD_PAGE;
        try {
            // always load categories for dashboard
            request.setAttribute("categories", exCaDAO.getAll());

            if ("create".equals(action)) {
                url = handleCreating(request);
            } else if ("view-exams".equals(action)) { // thay đổi cho dashboard filter đúng logic
                url = handleViewExams(request);
            } else if ("create-form".equals(action)) {
                HttpSession session = request.getSession(false);
                User user = (session != null) ? (User) session.getAttribute("user") : null;
                if (user == null || !"Instructor".equals(user.getRole())) {
                    url = DASHBOARD_PAGE;
                } else {
                    request.setAttribute("categories", exCaDAO.getAll());
                    url = CREATE_PAGE;
                }
            } else if ("add-question-form".equals(action)) { // show form thêm câu hỏi
                url = handleShowAddQuestionForm(request);
            } else if ("add-question".equals(action)) { // xử lý submit thêm câu hỏi
                url = handleAddQuestion(request);
            } else if ("take-exam".equals(action)) {
                url = handleExamTaking(request);
            } else if ("submit-exam".equals(action)) {
                url = handleExamSubmission(request);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String handleCreating(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"Instructor".equals(user.getRole())) {
            return DASHBOARD_PAGE;
        }
        Map<String, String> errors = new HashMap<>();

        String title = request.getParameter("title");
        String subject = request.getParameter("subject");
        String catId = request.getParameter("category_id");
        String to_marks = request.getParameter("total_marks");
        String dur = request.getParameter("duration");

        if (title == null || title.trim().isEmpty()) {
            errors.put("title", "Title is required");
        }
        if (subject == null || subject.trim().isEmpty()) {
            errors.put("subject", "Subject is required");
        }
        int categoryId = 0;
        try {
            categoryId = Integer.parseInt(catId);
        } catch (NumberFormatException e) {
            errors.put("category_id", "Invalid category");
        }
        int marks = 0;
        try {
            marks = Integer.parseInt(to_marks);
            if (marks <= 0) {
                errors.put("total_marks", "Marks must be greater than ZERO");
            }
        } catch (NumberFormatException e) {
            errors.put("total_marks", "Marks must be a number");
        }
        int duration = 0;
        try {
            duration = Integer.parseInt(dur);
            if (duration <= 0) {
                errors.put("duration", "Duration must be greater than ZERO");
            }
        } catch (NumberFormatException e) {
            errors.put("duration", "Duration must be a number");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("categories", exCaDAO.getAll());
            return CREATE_PAGE;
        }

        Exam newExam = new Exam(examDAO.CreateId(), title, subject, categoryId, marks, duration);
        boolean valid = examDAO.createExam(newExam);
        if (valid) {
            request.setAttribute("success", "Exam created successfully!");
        } else {
            request.setAttribute("errorMess", "Failed to create exam, please try again.");
            request.setAttribute("categories", exCaDAO.getAll());
            return CREATE_PAGE;
        }

        // Sau khi tạo xong, load lại dashboard với categories
        request.setAttribute("categories", exCaDAO.getAll());
        return CREATE_PAGE;
    }

    // Hiển thị Exam theo Category được chọn từ dashboard (filter mới)
    private String handleViewExams(HttpServletRequest request) {
        String catIdStr = request.getParameter("category_id");
        int catId = 0;
        try {
            catId = Integer.parseInt(catIdStr);
        } catch (NumberFormatException e) {
        }
        ExamCategories cat = exCaDAO.getById(catId);
        if (cat == null) {
            request.setAttribute("errorMessage", "Category not found!");
            return DASHBOARD_PAGE;
        }
        List<Exam> exams = examDAO.getExamsByCategoryId(catId);
        request.setAttribute("examsByCategory", exams);
        request.setAttribute("selectedCategoryName", cat.getCategoryName());
        return DASHBOARD_PAGE;
    }

    // Hiển thị form add question cho instructor (phải truyền examId)
    private String handleShowAddQuestionForm(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"Instructor".equals(user.getRole())) {
            request.setAttribute("errorMessage", "Access denied. Only instructors can add questions.");
            return DASHBOARD_PAGE;
        }
        String examIdStr = request.getParameter("examId");
        int examId = 0;
        try {
            examId = Integer.parseInt(examIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Exam ID.");
            return DASHBOARD_PAGE;
        }
        Exam exam = examDAO.getExamById(examId);
        if (exam == null) {
            request.setAttribute("errorMessage", "Exam not found.");
            return DASHBOARD_PAGE;
        }
        List<Questions> questions = queDAO.getQuestionsByExamId(examId);
        request.setAttribute("exam", exam);
        request.setAttribute("questions", questions);
        return ADD_QUESTION_PAGE;
    }

    // Xử lý submit thêm câu hỏi cho exam
    private String handleAddQuestion(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"Instructor".equals(user.getRole())) {
            request.setAttribute("errorMessage", "Access denied. Only instructors can add questions.");
            return DASHBOARD_PAGE;
        }
        String examIdStr = request.getParameter("examId");
        int examId = 0;
        try {
            examId = Integer.parseInt(examIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Exam ID.");
            return DASHBOARD_PAGE;
        }
        // Lấy data từ form
        String questionText = request.getParameter("questionText");
        String optionA = request.getParameter("optionA");
        String optionB = request.getParameter("optionB");
        String optionC = request.getParameter("optionC");
        String optionD = request.getParameter("optionD");
        String correctOption = request.getParameter("correctOption");

        Map<String, String> errors = new HashMap<>();
        if (questionText == null || questionText.trim().isEmpty()) {
            errors.put("questionText", "Question text is required.");
        }
        if (optionA == null || optionA.trim().isEmpty()) {
            errors.put("optionA", "Option A is required.");
        }
        if (optionB == null || optionB.trim().isEmpty()) {
            errors.put("optionB", "Option B is required.");
        }
        if (optionC == null || optionC.trim().isEmpty()) {
            errors.put("optionC", "Option C is required.");
        }
        if (optionD == null || optionD.trim().isEmpty()) {
            errors.put("optionD", "Option D is required.");
        }
        if (correctOption == null || correctOption.isEmpty()
                || !(correctOption.equals("A") || correctOption.equals("B") || correctOption.equals("C") || correctOption.equals("D"))) {
            errors.put("correctOption", "Please select the correct option.");
        }
        Exam exam = examDAO.getExamById(examId);
        if (!errors.isEmpty()) {
            List<Questions> questions = queDAO.getQuestionsByExamId(examId);
            request.setAttribute("exam", exam);
            request.setAttribute("questions", questions);
            request.setAttribute("errorMessage", errors.values().stream().findFirst().orElse("Invalid input"));
            return ADD_QUESTION_PAGE;
        }
        Questions question = new Questions(queDAO.CreateId(), examId, questionText, optionA, optionB, optionC, optionD, correctOption);
        boolean success = queDAO.addQuestionToExam(question);
        if (success) {
            request.setAttribute("successMessage", "Question added successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to add question. Please try again.");
        }
        List<Questions> questions = queDAO.getQuestionsByExamId(examId);
        request.setAttribute("exam", exam);
        request.setAttribute("questions", questions);
        return ADD_QUESTION_PAGE;
    }

    private String handleExamTaking(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"Student".equals(user.getRole())) {
            request.setAttribute("errorMessage", "Only students can take exams.");
            return DASHBOARD_PAGE;
        }
        String examIdStr = request.getParameter("examId");
        int examId = 0;
        try {
            examId = Integer.parseInt(examIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Exam ID.");
            return DASHBOARD_PAGE;
        }

        Exam exam = examDAO.getExamById(examId);
        if (exam == null) {
            request.setAttribute("errorMessage", "Exam not found.");
            return DASHBOARD_PAGE;
        }
        List<Questions> questions = queDAO.getQuestionsByExamId(examId);
        if (questions == null || questions.isEmpty()) {
            request.setAttribute("errorMessage", "No questions found for this exam.");
            return DASHBOARD_PAGE;
        }
        // Đưa dữ liệu sang trang làm bài
        request.setAttribute("exam", exam);
        request.setAttribute("questions", questions);
        return "takeExam.jsp";
    }

    private String handleExamSubmission(HttpServletRequest request) {
        String examIdStr = request.getParameter("examId");
        int examId = 0;
        try {
            examId = Integer.parseInt(examIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Exam ID.");
            return DASHBOARD_PAGE;
        }
        List<Questions> questions = queDAO.getQuestionsByExamId(examId);
        if (questions == null || questions.isEmpty()) {
            request.setAttribute("errorMessage", "No questions found for this exam.");
            return DASHBOARD_PAGE;
        }
        int score = 0;
        int total = questions.size();
        Map<Integer, String> studentAnswers = new HashMap<>();
        for (Questions q : questions) {
            String answer = request.getParameter("answer_" + q.getQuestionId());
            studentAnswers.put(q.getQuestionId(), answer);
            if (q.getCorrectOption().equals(answer)) {
                score++;
            }
        }
        request.setAttribute("score", score);
        request.setAttribute("total", total);
        request.setAttribute("questions", questions);
        request.setAttribute("studentAnswers", studentAnswers);
        Exam exam = examDAO.getExamById(examId);
        request.setAttribute("exam", exam);
        return "examResult.jsp";
    }
}
