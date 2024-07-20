/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
 
import Model.Cart;
import Model.Item;
import Model.Order; 
import Model.OrderDetail;
import Model.OrderStatus;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class OrderDAO extends DBContext{
    
    public void createOrder(int cID, Cart c, String address, String phoneNumber, int status){
        String sql = "INSERT INTO Orders OUTPUT inserted.orderID VALUES(?,?,?,?,?,?)";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql);  
            LocalDate curDate = java.time.LocalDate.now();
            String date = curDate.toString();
            stm.setInt(1, cID);
            stm.setString(2, address);
            stm.setString(3, phoneNumber);
            stm.setString(4, date);
            stm.setFloat(5,c.getTotalMoney());
            stm.setInt(6, status);
            ResultSet rs = stm.executeQuery();
            //insert và in ra orderID vừa insert
            while(rs.next()){
                int orderID = rs.getInt(1);
                addOrderDetail(orderID, c); 
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }  
     
    public void addOrderDetail(int orderID, Cart c){ 
        try { 
            for (Item i : c.getAllItem()) {
                String sql = "insert into OrderDetails values(?,?,?,?)";
                PreparedStatement stm = connection.prepareStatement(sql); 
                stm.setInt(1, orderID);
                stm.setString(2, i.getProduct().getProduct_id());
                stm.setInt(3, i.getQuantity());
                stm.setFloat(4, i.getPrice());
                stm.executeUpdate();
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    } 
    public List<Order> getOrderList(){
        List<Order> orderList = new ArrayList<>(); 
        String sql = "select Od.orderID, Od.customerID, Od.address, Od.phoneNumber, Od.orderDate, Od.total, Od.status, Os.status " 
                   + "from Orders Od INNER JOIN OrderStatus Os on Od.status = Os.id order by orderID desc";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql);  
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                OrderStatus os = new OrderStatus(rs.getInt(7), rs.getString(8));
                orderList.add(new Order(rs.getInt(1),
                                     rs.getInt(2),
                                     rs.getString(3),
                                     rs.getString(4),
                                     rs.getDate(5),
                                     rs.getFloat(6),
                                     os)); 
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return orderList;
    } 
    public List<Order> getOrderByID(int cID){
        List<Order> orderList = new ArrayList<>(); 
        String sql = "select Od.orderID, Od.customerID, Od.address, Od.phoneNumber, Od.orderDate, Od.total, Od.status, Os.status " 
                   + "from Orders Od INNER JOIN OrderStatus Os on Od.status = Os.id " 
                   + "where Od.customerID = ? order by orderID desc";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql); 
            stm.setInt(1, cID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                OrderStatus os = new OrderStatus(rs.getInt(7), rs.getString(8));
                orderList.add(new Order(rs.getInt(1),
                                     rs.getInt(2),
                                     rs.getString(3),
                                     rs.getString(4),
                                     rs.getDate(5),
                                     rs.getFloat(6),
                                     os));
                System.out.println(os);
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return orderList;
    }
    public float getTotalInMonth(int month){
        String sql = "select SUM(total) from Orders where MONTH(orderDate) = ? AND YEAR(orderDate) = 2024 AND status = 3";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql); 
            LocalDate curDate = java.time.LocalDate.now();
            if(month == 0){
                stm.setInt(1, curDate.getMonthValue());
            }
            else{
                stm.setInt(1, month);
            } 
            ResultSet rs = stm.executeQuery();
            while (rs.next()) { 
                return rs.getFloat(1);
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }
    
    public int getTotalOrder(int status){
        String sql = "";
        if(status == 0){
            sql = "SELECT COUNT(*) FROM Orders WHERE MONTH(orderDate) = ? AND YEAR(orderDate) = 2024";
        }
        else{
            sql = "SELECT COUNT(*) FROM Orders WHERE MONTH(orderDate) = ? AND YEAR(orderDate) = 2024 AND status = ?";
        }
        try { 
            PreparedStatement stm = connection.prepareStatement(sql); 
            LocalDate curDate = java.time.LocalDate.now();
            stm.setInt(1, curDate.getMonthValue());
            if(status != 0){
                stm.setInt(2, status);
            } 
            ResultSet rs = stm.executeQuery();
            while (rs.next()) { 
                return rs.getInt(1);
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    } 
    public List<OrderDetail> getOrderDetail(){
        List<OrderDetail> orderDetail = new ArrayList<>(); 
        String sql = "select * from OrderDetails";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql);  
            ResultSet rs = stm.executeQuery();
            while (rs.next()) { 
                orderDetail.add(new OrderDetail(rs.getInt(1),
                                     rs.getInt(2),
                                     rs.getString(3),
                                     rs.getInt(4), 
                                     rs.getFloat(5))); 
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return orderDetail;
    }
    public List<OrderDetail> getOrderDetailByID(int orderID){
        List<OrderDetail> orderDetail = new ArrayList<>(); 
        String sql = "select * from OrderDetails  where orderID = ?";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql); 
            stm.setInt(1, orderID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) { 
                orderDetail.add(new OrderDetail(rs.getInt(1),
                                     rs.getInt(2),
                                     rs.getString(3),
                                     rs.getInt(4), 
                                     rs.getFloat(5))); 
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return orderDetail;
    }
    
    public List<OrderStatus> getOrderStatus(){
        List<OrderStatus> status = new ArrayList<>(); 
        String sql = "select * from OrderStatus";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql);  
            ResultSet rs = stm.executeQuery();
            while (rs.next()) { 
                status.add(new OrderStatus(rs.getInt(1),
                                     rs.getString(2))); 
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return status;
    }
    
//    public void updateQuantity(int orderID){
//        try { 
//            List<OrderDetail> orderDetail = getOrderDetailByID(orderID); 
//            for (OrderDetail o : orderDetail) {
//                String sql = "update Product set quantity = quantity - ? where product_id = ?";
//                PreparedStatement stm = connection.prepareStatement(sql); 
//                stm.setInt(1, o.getQuantity());
//                stm.setString(2, o.getProductID()); 
//                stm.executeUpdate();
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//    }
    public void handleOrder(int orderID, int status){
        String sql = "update Orders set [status] = ? where orderID = ?";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql);  
            stm.setInt(1, status);
            stm.setInt(2, orderID);
            stm.executeUpdate(); 
        } catch (SQLException e) {
            System.out.println(e);
        }
    } 
     
}
