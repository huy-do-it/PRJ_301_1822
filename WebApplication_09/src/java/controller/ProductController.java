/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.ProductDAO;
import model.ProductDTO;
import utils.AuthUtils;

/**
 *
 * @author ddhuy
 */
@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    ProductDAO pdao = new ProductDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "";
        try {
            String action = request.getParameter("action");
            if ("addProduct".equals(action)) {
                url = handleProductAdding(request, response);
            }else if("searchProduct".equals(action)){
                url = handleProductSearching(request, response);
                System.out.println("hong co gi het do ngok" + url);
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

    private String handleProductAdding(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (AuthUtils.isAdmin(request)) {
            Map<String, String> errors = new HashMap<>();
            String message = "";

            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String image = request.getParameter("image");
            String description = request.getParameter("description");
            String price = request.getParameter("price");
            String size = request.getParameter("size");
            String status = request.getParameter("status");

            double price_value = 0;
            try {
                price_value = Double.parseDouble(price);
            } catch (Exception e) {
                errors.put("price", "Giá không hợp lệ.");
            }

            boolean status_value = status != null && status.equals("true");

            // Validate ID
            if (id == null || id.trim().isEmpty()) {
                errors.put("id", "ID không được để trống.");
            } else if (pdao.isProductExists(id)) {
                errors.put("id", "Product ID đã tồn tại.");
            }

            // Validate Name
            if (name == null || name.trim().isEmpty()) {
                errors.put("name", "Tên sản phẩm không được để trống.");
            }

            // Validate Price
            if (price == null || price.trim().isEmpty()) {
                errors.put("price", "Giá không được để trống.");
            } else if (errors.get("price") == null && price_value < 0) {
                errors.put("price", "Giá phải lớn hơn hoặc bằng 0.");
            }

            // Validate Size (optional)
            // if (size == null || size.trim().isEmpty()) {
            //     errors.put("size", "Size không được để trống.");
            // }
            ProductDTO product = new ProductDTO(id, name, image, description, price_value, size, status_value);
            request.setAttribute("product", product);

            // Nếu không có lỗi, thêm sản phẩm
            if (errors.isEmpty()) {
                if (pdao.create(product)) {
                    message = "Thêm sản phẩm thành công.";
                } else {
                    errors.put("general", "Không thể thêm sản phẩm mới.");
                }
            }

            request.setAttribute("errors", errors);
            request.setAttribute("message", message);
        }
        return "productForm.jsp";
    }

    private String handleProductSearching(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<ProductDTO> list = pdao.getProductsByName(keyword);
        request.setAttribute("list", list);
        request.setAttribute("keyowrd", keyword);
        return "welcome.jsp";
    }
}
