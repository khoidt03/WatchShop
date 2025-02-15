/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Model.Cart;
import dal.CustomerDAO;
import Model.Customer;
import java.io.IOException; 
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
public class Login extends HttpServlet {
   
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
        request.getRequestDispatcher("View/login.jsp").forward(request, response);
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
        Cart c = new Cart();
        String username = request.getParameter("user");
        String password = request.getParameter("pass");
        String remember = request.getParameter("remember");
        Customer acc = dao.login(username, password);
        if (acc != null) {
            HttpSession session = request.getSession();
            session.setAttribute("acc", acc);
            Cookie user = new Cookie("username", username);
            Cookie pass = new Cookie("password", password); 
            Cookie checked = new Cookie("remember", remember);
            if (remember != null) {
                user.setMaxAge(2592000); //30 days
                pass.setMaxAge(2592000);
                checked.setMaxAge(2592000);
            } else {
                user.setMaxAge(0); 
                pass.setMaxAge(0);
                checked.setMaxAge(0);
            }
            response.addCookie(user);
            response.addCookie(pass);
            response.addCookie(checked); 
            c.getAllItem().clear();
            response.sendRedirect("home");
        }
        else{
            request.setAttribute("message", "Tài khoản hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("View/login.jsp").forward(request, response);
        }
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
