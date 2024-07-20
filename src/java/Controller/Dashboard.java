/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import dal.CustomerDAO;
import dal.OrderDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class Dashboard extends HttpServlet {
   
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
        ProductDAO product = new ProductDAO();
        CustomerDAO customer = new CustomerDAO();
        OrderDAO order = new OrderDAO();
        request.setAttribute("productList", product.getProduct());
        request.setAttribute("customerList", customer.getCustomer()); 
        request.setAttribute("totalOrder", order.getTotalOrder(0));
        request.setAttribute("totalMonth", order.getTotalInMonth(0));
        request.setAttribute("t1", order.getTotalInMonth(1));
        request.setAttribute("t2", order.getTotalInMonth(2));
        request.setAttribute("t3", order.getTotalInMonth(3));
        request.setAttribute("t4", order.getTotalInMonth(4));
        request.setAttribute("t5", order.getTotalInMonth(5));
        request.setAttribute("t6", order.getTotalInMonth(6));
        request.setAttribute("t7", order.getTotalInMonth(7));
        request.setAttribute("t8", order.getTotalInMonth(8));
        request.setAttribute("t9", order.getTotalInMonth(9));
        request.setAttribute("t10", order.getTotalInMonth(10));
        request.setAttribute("t11", order.getTotalInMonth(11));
        request.setAttribute("t12", order.getTotalInMonth(12));
        request.getRequestDispatcher("admin/dashboard.jsp").forward(request, response);
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
        processRequest(request, response);
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
