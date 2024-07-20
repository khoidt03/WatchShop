/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Model.Cart;
import Model.Customer;
import Model.Item;
import Model.Product;
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
public class CartServlet extends HttpServlet {
   
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
        Cart c = new Cart(); 
        String message = "can order";
        ProductDAO dao = new ProductDAO(); 
        for(Item i: c.getAllItem()){
            Product p = dao.getProductByID(i.getProduct().getProduct_id());
            if(p.getQuantity() < i.getQuantity()){
                message = "Số lượng " + i.getProduct().getProduct_name() + " trong kho chỉ còn " + p.getQuantity() + "  sản phẩm!";
            }
        }
        if(request.getParameter("action") != null){
            String pID = request.getParameter("pID"); 
            String action = request.getParameter("action");
            Item i = c.getItemByID(pID); 
            if(action.equals("remove")){  
                c.removeCart(pID); 
                deleCookie(pID, request, response);
            } 
            if(action.equals("sub")){
                i.setQuantity(i.getQuantity() - 1);
                if(i.getQuantity() == 0){
                    c.removeCart(pID);
                    deleCookie(pID, request, response);
                }
            }
            if(action.equals("add")){
                i.setQuantity(i.getQuantity() + 1);
            }
            response.sendRedirect("cart");
        }
        request.setAttribute("message", message);
        request.setAttribute("cart", c); 
        request.setAttribute("cartSize", c.getAllItem().size());
        request.getRequestDispatcher("View/cart.jsp").forward(request, response);
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
        ProductDAO dao = new ProductDAO();  
        String action = request.getParameter("action"); 
        String pID = request.getParameter("pID");  
        if (action.equals("add")) {   
            Product p = dao.getProductByID(pID);
            int quantity = Integer.parseInt(request.getParameter("quantity")); 
            c.addCart(new Item(p, quantity, p.getProduct_price()));  
            addCookie(p, quantity, p.getProduct_price(), request, response);
        } 
        if (action.equals("quickadd")) { 
            Product p = dao.getProductByID(pID); 
            c.addCart(new Item(p, 1, p.getProduct_price())); 
            addCookie(p, 1 , p.getProduct_price(), request, response);
        } 
        response.sendRedirect("cart"); 
    }

    /** `
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */  
    private Cookie getCookie(Cookie[] cookies, String name) {
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (name.equals(c.getName())) {
                    return c;
                }
            }
        }
        return null;
    }
    private void addCookie(Product p, int quantity, float price, HttpServletRequest request, HttpServletResponse response) {
        String txtCookie = "";
        int customerID = 0;
        Customer c = (Customer)request.getSession().getAttribute("acc");
        if(c != null){
            customerID = c.getCustomerID();
        } 
        String items = p.getProduct_id() + ">" + quantity + ">" + price;
        Cookie[] cookies = request.getCookies();
        Cookie cartCookie = getCookie(cookies, "cart" + customerID);
        if (cartCookie == null) {
            txtCookie = items;
        } else {
            txtCookie = cartCookie.getValue();
            if (canAddCookie(txtCookie, p.getProduct_id())) {
                txtCookie += ":" + items;
            }
        }
        cartCookie = new Cookie("cart" + customerID, txtCookie);
        cartCookie.setMaxAge(864000);
        response.addCookie(cartCookie);
    }
    private void deleCookie(String pID, HttpServletRequest request, HttpServletResponse response){ 
        int customerID = 0;
        Customer customer = (Customer)request.getSession().getAttribute("acc");
        if(customer != null){
            customerID = customer.getCustomerID();
        } 
        Cookie cartCookie = getCookie(request.getCookies(), "cart" + customerID);
        if (cartCookie != null) {
            String stringCookie = cartCookie.getValue();
            String newCookie = "";
            String[] ck = stringCookie.split(":");
            if (ck.length == 1) {
                cartCookie.setMaxAge(0);
                response.addCookie(cartCookie);
            } else {
                for (String s : ck) {
                    String[] cID = s.split(">");
                    if (cID[0] != null && !cID[0].equals(pID)) {
                        newCookie += s + ":";
                    }
                }
                Cookie c = new Cookie("cart" + customerID, newCookie);
                c.setMaxAge(864000);
                response.addCookie(c);
            }
        }
    }
    private boolean canAddCookie(String cookies, String pID){
        String[] c = cookies.split(":");
        for(String s: c){
            String[] cID = s.split(">");
            if(cID[0] != null && cID[0].equals(pID)){
                return false;
            }
        }
        return true;
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
