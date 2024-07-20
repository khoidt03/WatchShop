/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Model.Cart;
import Model.Customer;
import Model.Item;
import dal.OrderDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
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
public class OrderServelet extends HttpServlet {
   
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
            out.println("<title>Servlet OrderServelet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderServelet at " + request.getContextPath () + "</h1>");
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
        Cart c = new Cart();
        ProductDAO dao = new ProductDAO();  
        for(Item i: c.getAllItem()){
            if(dao.getProductByID(i.getProduct().getProduct_id()).getQuantity() < i.getQuantity()){
                request.setAttribute("cart", c); 
                request.getRequestDispatcher("View/cart.jsp").forward(request, response);
                return;
            }
        } 
        request.setAttribute("cart", c); 
        request.getRequestDispatcher("View/order.jsp").forward(request, response);
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
        Cart c = new Cart();
        HttpSession session = request.getSession();
        Customer customer = (Customer)session.getAttribute("acc"); 
        OrderDAO dao = new OrderDAO(); 
        String phoneNumber = request.getParameter("phone");
        String address = request.getParameter("address"); 
        dao.createOrder(customer.getCustomerID(), c, address, phoneNumber, 1);  
        Cookie[] cookies = request.getCookies();
        for(Cookie ck: cookies){
            if(ck.getName().equals("cart" + customer.getCustomerID())){
                ck.setMaxAge(0);
                response.addCookie(ck);
            }
        }
        c.getAllItem().clear();
        response.sendRedirect("profile");
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
