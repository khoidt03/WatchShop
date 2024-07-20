/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Model.Cart;
import java.io.IOException;
import Model.Customer;
import dal.CustomerDAO;
import dal.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
public class ProfileCustomer extends HttpServlet {
   
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
        OrderDAO dao = new OrderDAO();
        HttpSession session = request.getSession();
        Customer c = (Customer)session.getAttribute("acc");
        Cart cart = new Cart();
        request.setAttribute("orderDetail", dao.getOrderDetail());
        request.setAttribute("cartSize", cart.getAllItem().size());
        request.setAttribute("orderList", dao.getOrderByID(c.getCustomerID()));
        request.getRequestDispatcher("View/profile.jsp").forward(request, response);
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
        CustomerDAO dao = new CustomerDAO();
        HttpSession session = request.getSession();
        Customer c = (Customer)session.getAttribute("acc");
        String password = c.getCustomerPass();
        String oldpass = request.getParameter("oldpass");
        String newpass = request.getParameter("newpass");
        String repass = request.getParameter("repass");
        if (!password.equals(oldpass)) {
            request.setAttribute("message", "Mật khẩu cũ không chính xác.");

        } else if (!newpass.equals(repass)) {
            request.setAttribute("message", "Mật khẩu xác thực không trùng khớp.");
        } else {
            dao.changePassowrd(newpass, c.getCustomerPass()); 
            c.setCustomerPass(newpass); 
            request.setAttribute("message", "Thay đổi mật khẩu thành công!");
        }
        request.getRequestDispatcher("View/profile.jsp").forward(request, response);
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
