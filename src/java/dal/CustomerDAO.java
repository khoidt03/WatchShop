/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
 
import Model.Customer;
import com.oracle.wls.shaded.org.apache.bcel.generic.AALOAD;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class CustomerDAO extends DBContext{
    
    public List<Customer> getCustomer() {
        List<Customer> list = new ArrayList<>();
        String sql = "select * from Customer";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql); 
            ResultSet rs = stm.executeQuery();
            while (rs.next()) { 
                list.add(new Customer(rs.getInt(1),
                                     rs.getString(2),
                                     rs.getString(3),  
                                     rs.getString(4),
                                     rs.getInt(5))); 
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    public void register(String user, String pass, String email){
        try {
            String query = "Insert into Customer (customer_name, customer_pass, customer_email, [role]) Values(?,?,?,0);";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, user);
            stm.setString(2, pass);
            stm.setString(3, email);
            stm.executeUpdate();
        } catch (SQLException e) {
        }
    }
    public boolean isExistUser(String username){
        try {
            String query = "select * from Customer where customer_name= ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, username); 
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                return true;
            }
        } catch (SQLException e) {
        }
        return false;
    }
    public boolean isExistEmail(String email){
        try {
            String query = "select * from Customer where customer_email= ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, email); 
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                return true;
            }
        } catch (SQLException e) {
        }
        return false;
    }
    
    public Customer getCustomer(String cID){
        try {
            String query = "select * from Customer where customer_id = ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, cID); 
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                return new Customer(rs.getInt(1), 
                                 rs.getString(2), 
                                 rs.getString(3), 
                                    rs.getString(4), 
                                   rs.getInt(5));
            }
        } catch (SQLException e) {
        }
        return null;
    }
    public Customer login(String user, String password) {
        try {
            String query = "select * from Customer where customer_name= ? AND customer_pass = ?";
            PreparedStatement stm = connection.prepareStatement(query);
            stm.setString(1, user);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                return new Customer(rs.getInt(1),
                                 rs.getString(2),
                                 rs.getString(3),
                                    rs.getString(4),
                                   rs.getInt(5));
            }
        } catch (SQLException e) {
        }
        return null;
    }
    
    public void setAdmin(String customerID, int role){
        try {
            String query = "update Customer set [role] = ? where customer_id = ?";
            PreparedStatement stm = connection.prepareStatement(query); 
            stm.setInt(1, role);
            stm.setString(2, customerID);  
            stm.executeUpdate(); 
        } catch (SQLException e) {
        }
    } 
    
    public void deleCustomer(String customerID){
        try {
            String query = "delete from Customer where customer_id = ?";
            PreparedStatement stm = connection.prepareStatement(query);  
            stm.setString(1, customerID);  
            stm.executeUpdate(); 
        } catch (SQLException e) {
        }
    }
    
    public void changePassowrd(String newPass, String customerID){
        try {
            String query = "update Customer set [customer_pass] = ? where customer_id = ?";
            PreparedStatement stm = connection.prepareStatement(query);  
            stm.setString(1, newPass);  
            stm.setString(2, customerID);
            stm.executeUpdate(); 
        } catch (SQLException e) {
        }
    }
}
