/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Model.Cart;   
import dal.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;  

/**
 *
 * @author ADMIN
 */
public class ProductServelet extends HttpServlet {
   
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
        ProductDAO dao = new ProductDAO();
        Cart c = new Cart();
        String action = request.getParameter("action"); 
        if(action == null){
            request.setAttribute("productAll", dao.getProduct());
        }
        else if(action.equals("listByCategory")){
            String cID = request.getParameter("cID"); 
            int cateID = Integer.parseInt(cID);
            request.setAttribute("productAll", dao.getProductByCategory(cateID));
        }
        else if(action.equals("sort")){ 
            String type = request.getParameter("type"); 
            request.setAttribute("productAll", dao.getProductByType(type));
        }
        request.setAttribute("cartSize", c.getAllItem().size()); 
        request.setAttribute("categoryAll", dao.getCategory()); 
        request.getRequestDispatcher("View/product.jsp").forward(request, response);
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
        ProductDAO dao = new ProductDAO();
        Cart c = new Cart();
        String action = request.getParameter("action");
        if(action.equals("search")){
            String textSearch = request.getParameter("textSearch");
            request.setAttribute("textSearch", textSearch);
            request.setAttribute("productAll", dao.searchProduct(textSearch));
        }
        request.setAttribute("cartSize", c.getAllItem().size()); 
        request.setAttribute("categoryAll", dao.getCategory()); 
        request.getRequestDispatcher("View/product.jsp").forward(request, response);
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
