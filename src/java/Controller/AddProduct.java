/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

/**
 *
 * @author ADMIN
 */
@MultipartConfig(
        location = "D:\\PRJ301\\Assignment\\WatchShop\\web\\images\\", // Thư mục để lưu trữ tệp tạm thời
        fileSizeThreshold = 1024 * 1024, // Kích thước tệp lớn nhất để lưu trữ trong bộ nhớ cache (1MB)
        maxFileSize = 1024 * 1024 * 15, // Kích thước tệp lớn nhất được phép tải lên (15MB)
        maxRequestSize = 1024 * 1024 * 30 // Tổng kích thước tệp tối đa được phép gửi đến máy chủ (30MB)
)
public class AddProduct extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddProduct</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProduct at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        ProductDAO p = new ProductDAO();
        request.setAttribute("categoryAll", p.getCategory()); 
        request.getRequestDispatcher("admin/addproduct.jsp").forward(request, response);
    }  
    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        ProductDAO p = new ProductDAO();
        String action = request.getParameter("type");
        if(action.equals("category")){
            String category_name = request.getParameter("category_name");
            p.addCategory(category_name); 
        } 
        if (action.equals("product")) {
            Part filePart = request.getPart("image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadDir = "D:\\PRJ301\\Assignment\\WatchShop\\web\\images\\"; 
            String productID = request.getParameter("product_id");
            if (p.getProductByID(productID) == null) {
                String categoryString = request.getParameter("category_id");
                String productName = request.getParameter("product_name");
                String price = request.getParameter("price");
                String describe = request.getParameter("describe");
                String quantityString = request.getParameter("quantity");
                try (InputStream fileContent = filePart.getInputStream()) {
                    Files.copy(fileContent, Paths.get(uploadDir + fileName), StandardCopyOption.REPLACE_EXISTING);
                } 
                String img = "images/" + fileName;
                p.addProduct(productID, Integer.parseInt(categoryString), productName, Float.parseFloat(price), describe, img, Integer.parseInt(quantityString)); 
                request.setAttribute("message", "OK");
            }  
        }
        doGet(request, response);
    }
 
    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
