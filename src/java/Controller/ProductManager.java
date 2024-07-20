/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import dal.ProductDAO;
import java.io.IOException; 
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
public class ProductManager extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException { 
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
        request.setAttribute("productList", p.getProduct()); 
        request.getRequestDispatcher("admin/product.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        String pID = request.getParameter("pID");
        if(action.equals("delete")){
            p.deleteProduct(pID); 
        } 
        if(action.equals("edit")){  
            String productID = request.getParameter("productID");
            String categoryID = request.getParameter("categoryID");
            String productName = request.getParameter("productName");
            String price = request.getParameter("price");
            String quantity = request.getParameter("quantity"); 
            String describe = request.getParameter("describe");
            String img = p.getProductByID(productID).getImg();
            if(request.getPart("image").getSize() != 0){ 
                Part filePart = request.getPart("image");
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadDir = "D:\\PRJ301\\Assignment\\WatchShop\\web\\images\\";
                try (InputStream fileContent = filePart.getInputStream()) {
                    Files.copy(fileContent, Paths.get(uploadDir + fileName), StandardCopyOption.REPLACE_EXISTING);
                }  
                img = "images/" + fileName; 
            } 
            p.updateProduct(productID, categoryID, productName, Float.parseFloat(price), describe, img, Integer.parseInt(quantity), pID);
        }
        response.sendRedirect("productmanager");
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
