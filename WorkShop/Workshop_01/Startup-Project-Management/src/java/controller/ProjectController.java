/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.StartupProjectDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import model.StartupProject;
import util.AuthUtils;

/**
 *
 * @author ddhuy
 */
@WebServlet(name = "ProjectController", urlPatterns = {"/ProjectController"})
public class ProjectController extends HttpServlet {

    StartupProjectDAO spdao = new StartupProjectDAO();
    AuthUtils authUtils = new AuthUtils();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "";
        try {
            String action = request.getParameter("action");
            if ("searchProject".equals(action)) {
                url = handleProjectSearching(request, response);
            } else if ("createProject".equals(action)) {
                url = handleProjectCreating(request, response);
            } else if ("updateProject".equals(action)) {
                url = handleProjectUpdating(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
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

    private String handleProjectSearching(HttpServletRequest request, HttpServletResponse response) {
        String keyword = request.getParameter("keyword");
        List<StartupProject> project = spdao.getProjectByName(keyword);

        request.setAttribute("keyword", keyword);
        request.setAttribute("projects", project);

        return "welcome.jsp";
    }

    // Create new project
    private String handleProjectCreating(HttpServletRequest request, HttpServletResponse response) {
        String url = "actionProject.jsp";
        if (authUtils.isAdmin(request)) {

            // valid form
            String error = validateProjectForm(request);
            if (!error.isEmpty()) {
                request.setAttribute("checkError", error);
                url = "actionProject.jsp";
            }

            //create project
            StartupProject project = buildProjectFromRequest(request, true);

            if (spdao.Create(project)) {
                request.setAttribute("message", "Create project successfully!");
                //clear form input
                request.removeAttribute("inputName");
                request.removeAttribute("inputDescription");
                request.removeAttribute("inputStatus");
                request.removeAttribute("inputEstimatedLaunch");
            } else {
                request.setAttribute("checkError", "Failed to create project!");
            }
        }
        return url;
    }

    //update project
    private String handleProjectUpdating(HttpServletRequest request, HttpServletResponse response) {
        String url = "actionProject.jsp";
        if (authUtils.isAdmin(request)) {

            //validate form
            String error = validateProjectForm(request);
            if (!error.isEmpty()) {
                request.setAttribute("isEdit", true);
                return url;
            }

            // upate project
            StartupProject project = buildProjectFromRequest(request, false);
            
            if (spdao.update(project)) {
                request.setAttribute("projects", project);
            } else {
                request.setAttribute("checkError", "Failed to update project!");
                request.setAttribute("isEdit", true);
                url = "actionProject.jsp";
            }

        }
        return url;
    }

    private StartupProject buildProjectFromRequest(HttpServletRequest req, boolean isCreate) {
        String name = req.getParameter("name").trim();
        String desc = req.getParameter("description").trim();
        String status = req.getParameter("status").trim();
        String dateStr = req.getParameter("estimatedLaunch").trim();

        int id = isCreate ? spdao.CreateId() : Integer.parseInt(req.getParameter("projectId"));
        Date launchDate = Date.valueOf(dateStr);

        return new StartupProject(id, name, desc, status, launchDate);
    }

    private String validateProjectForm(HttpServletRequest request) {
        StringBuilder errorMessage = new StringBuilder();

        // Lấy dữ liệu từ form
        String projectName = request.getParameter("name");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String estimatedLaunchStr = request.getParameter("estimatedLaunch");

        // Lưu lại dữ liệu để hiển thị khi có lỗi
        request.setAttribute("inputName", projectName);
        request.setAttribute("inputDescription", description);
        request.setAttribute("inputStatus", status);
        request.setAttribute("inputEstimatedLaunch", estimatedLaunchStr);

        // Validate project name
        if (projectName == null || projectName.trim().isEmpty() || projectName.trim().length() < 3 || projectName.trim().length() > 100) {
            errorMessage.append("Project name must be between 3 and 100 characters!<br/>");
        }

        // Validate description
        if (description == null || description.trim().isEmpty() || description.trim().length() < 5) {
            errorMessage.append("Project description must be at least 5 characters!<br/>");
        }

        try {
            Date estimatedLaunch = Date.valueOf(estimatedLaunchStr);
            Date today = Date.valueOf(LocalDate.now());

            if (!estimatedLaunch.after(today)) {
                errorMessage.append("Launch date must be in the future!<br/>");
            }
        } catch (Exception e) {
            errorMessage.append("Invalid date format!<br/>");
        }

        String error = errorMessage.toString();
        if (!error.isEmpty()) {
            request.setAttribute("checkError", error);
        }

        return error;
    }
}
