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
        request.setAttribute("project", project);

        return "welcome.jsp";
    }

    private String handleProjectCreating(HttpServletRequest request, HttpServletResponse response) {
        // remember create a method check error for update & create status
        if (authUtils.isAdmin(request)) {
            String checkError = "";
            String message = "";

            String projectName = request.getParameter("name");
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            Date estimatedLaunch = Date.valueOf(request.getParameter("estimatedLaunch"));
            Date today = Date.valueOf(LocalDate.now());

            if (projectName.isEmpty()) {
                checkError = "Project name cannot emplty ";
            } else if (estimatedLaunch.before(today)) {
                checkError = "Launch date must be in the future.";
            }
            if (checkError.isEmpty()) {
                message = "Add project successfully!";
            }
            
            StartupProject sp = new StartupProject(spdao.CreateId(), projectName, description, status, estimatedLaunch);

            if (!spdao.Create(sp)) {
                checkError += "<br/>Cannot Create new project!!!";
            }
            
            request.setAttribute("project", sp);
            request.setAttribute("message", message);
            request.setAttribute("checkError", checkError);
        }
        return "actionProject.jsp";
    }

    private String handleProjectUpdating(HttpServletRequest request, HttpServletResponse response) {

        return "actionProject.jsp";
    }

}
