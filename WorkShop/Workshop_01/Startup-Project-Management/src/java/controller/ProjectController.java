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
        if(authUtils.isAdmin(request)){
            String keyword = request.getParameter("keyword");
            List<StartupProject> project = spdao.getProjectByName(keyword);

            request.setAttribute("keyword", keyword);
            request.setAttribute("projects", project);
        }else{
            List<StartupProject> project = spdao.getAll();
            request.setAttribute("projects", project);
        }

        return "welcome.jsp";
    }

    // Create new project
    private String handleProjectCreating(HttpServletRequest request, HttpServletResponse response) {
        String url = "actionProject.jsp";
        if (authUtils.isAdmin(request)) {
            // valid form
            String error = validateProjectForm(request);
            if (error.isEmpty()) {
                //create project
                StartupProject project = buildProjectFromRequest(request, true);

                if (spdao.Create(project)) {
                    request.setAttribute("message", "Create project successfully!");

                    request.removeAttribute("inputName");
                    request.removeAttribute("inputDescription");
                    request.removeAttribute("inputStatus");
                    request.removeAttribute("inputEstimatedLaunch");
                } else {
                    request.setAttribute("checkError", "Failed to create project!");
                }
            }
        }
        return url;
    }

    //update project
    private String handleProjectUpdating(HttpServletRequest request, HttpServletResponse response) {
        String url = "actionProject.jsp";
        if (authUtils.isAdmin(request)) {

            request.setAttribute("isEdit", true);
            String name = request.getParameter("name");
            String projectIdStr = request.getParameter("projectId");
            int projectId = Integer.parseInt(projectIdStr);
            if (name == null && projectIdStr != null) { // --> chưa submit form, chỉ nhấn Edit thôi
                StartupProject project = spdao.getProjectById(projectId);
                request.setAttribute("projects", project); // chú ý biến là 'projects' theo JSP
                return url;
            }
            // sau khi submit tiến hành validate và update
            StartupProject project = spdao.getProjectById(projectId);
            String error = validateProjectForm(request);
            request.setAttribute("projects", project);
            if (error.isEmpty()) {
                project = buildProjectFromRequest(request, false);
                if (spdao.update(project)) {
                    request.setAttribute("message", "Update project successfully!");
                } else {
                    request.setAttribute("checkError", "Failed to update project!");
                }
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
        boolean hasError = false;

        // Project Name
        String projectName = request.getParameter("name");
        if (projectName == null || projectName.trim().isEmpty() || projectName.trim().length() < 3 || projectName.trim().length() > 100) {
            request.setAttribute("errorName", "Project name must be between 3 and 100 characters!");
            hasError = true;
        }

        // Description
        String description = request.getParameter("description");
        if (description == null || description.trim().isEmpty() || description.trim().length() < 5) {
            request.setAttribute("errorDescription", "Project description must be at least 5 characters!");
            hasError = true;
        }

        // Status
        String status = request.getParameter("status");
        if (status == null || status.trim().isEmpty()) {
            request.setAttribute("errorStatus", "Status must be selected!");
            hasError = true;
        }

        // Estimated Launch
        String estimatedLaunchStr = request.getParameter("estimatedLaunch");
        try {
            Date estimatedLaunch = Date.valueOf(estimatedLaunchStr);
            Date today = Date.valueOf(LocalDate.now());
            if (!estimatedLaunch.after(today)) {
                request.setAttribute("errorEstimatedLaunch", "Launch date must be in the future!");
                hasError = true;
            }
        } catch (Exception e) {
            request.setAttribute("errorEstimatedLaunch", "Invalid date format!");
            hasError = true;
        }

        // Giữ lại input cũ khi sai input
        request.setAttribute("inputName", projectName);
        request.setAttribute("inputDescription", description);
        request.setAttribute("inputStatus", status);
        request.setAttribute("inputEstimatedLaunch", estimatedLaunchStr);

        return hasError ? "error" : "";
    }
}
