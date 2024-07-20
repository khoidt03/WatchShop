/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import Model.Product;
import Model.Category;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author ADMIN
 */
public class ProductDAO extends DBContext{
    
    public List<Product> getProduct() {
        List<Product> list = new ArrayList<>();
        String sql = "select c.category_id, c.category_name , p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img from  \n"
                + "product p inner join category c on p.category_id = c.category_id";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql); 
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(1), rs.getString(2));
                list.add(new Product(rs.getString(3),
                                     c,
                                     rs.getString(4),
                                     rs.getFloat(5),
                                     rs.getString(6),
                                     rs.getString(8),
                                     rs.getInt(7))); 
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    } 
    public List<Product> getProductByCategory(int categoryID) {
        List<Product> list = new ArrayList<>();
        String sql = "select c.category_id, c.category_name , p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img from  \n"
                + "product p inner join category c on p.category_id = c.category_id where c.category_id = ?";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, categoryID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(1), rs.getString(2));
                list.add(new Product(rs.getString(3),
                                     c,
                                     rs.getString(4),
                                     rs.getFloat(5),
                                     rs.getString(6),
                                     rs.getString(8),
                                     rs.getInt(7))); 
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    } 
    public Product getProductByID(String productID){
        String sql = "select c.category_id, c.category_name , p.product_id , p.product_name, p.product_price, p.product_describe, "
                + "p.quantity, p.img from product p inner join category c on p.category_id = c.category_id WHERE p.product_id=?";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql); 
            stm.setString(1, productID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(1),rs.getString(2));
                return new Product(rs.getString(3),
                                     c,
                                     rs.getString(4),
                                     rs.getFloat(5),
                                     rs.getString(6), 
                                     rs.getString(8),
                                     rs.getInt(7)); 
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    } 
    public List<Product> searchProduct(String textSeach){
        List<Product> list = new ArrayList<>();
        String sql = "select c.category_id, c.category_name , p.product_id , p.product_name, p.product_price, p.product_describe, "
                + "p.quantity, p.img from product p inner join category c on p.category_id = c.category_id WHERE p.product_name LIKE ?";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql); 
            stm.setString(1, "%" + textSeach + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(1),rs.getString(2));
                list.add(new Product(rs.getString(3),
                                     c,
                                     rs.getString(4),
                                     rs.getFloat(5),
                                     rs.getString(6), 
                                     rs.getString(8),
                                     rs.getInt(7))); 
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public List<Category> getCategory() {
        List<Category> list = new ArrayList<>();
        String sql = "select * from category";
        try {
            PreparedStatement stm = connection.prepareStatement(sql); 
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException e) {
        }
        return list;
    }
    
    public List<Product> getProductByType(String type) {
        List<Product> list = new ArrayList<>();
        String sql = "";
        if(type.equals("low")){
            sql = "select c.category_id, c.category_name , p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img from product p inner join category c on p.category_id = c.category_id ORDER BY p.product_price ASC";
        }
        else if(type.equals("high")){
            sql = "select c.category_id,c.category_name , p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img from product p inner join category c on p.category_id = c.category_id ORDER BY p.product_price DESC";
        }
        else{
            sql = "select c.category_id,c.category_name , p.product_id , p.product_name, p.product_price, p.product_describe, p.quantity,p.img from product p inner join category c on p.category_id = c.category_id ORDER BY p.product_name";
        }
        try { 
            PreparedStatement stm = connection.prepareStatement(sql); 
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(1), rs.getString(2));
                list.add(new Product(rs.getString(3),
                                     c,
                                     rs.getString(4),
                                     rs.getFloat(5),
                                     rs.getString(6),
                                     rs.getString(8),
                                     rs.getInt(7))); 
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }  
    public void addCategory(String category){
        String sql = "insert into Category(category_name) values(?)";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql); 
            stm.setString(1, category);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        } 
    }
 
    public void addProduct(String productID, int categoryID, String productName, float price, String describe, String img, int quantity){
        String sql = "insert into Product values(?,?,?,?,?,?,?)";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql); 
            stm.setString(1, productID);
            stm.setInt(2, categoryID);
            stm.setString(3, productName);
            stm.setFloat(4, price);
            stm.setString(5, describe);
            stm.setString(6, img);
            stm.setInt(7, quantity);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        } 
    }
 
    public void deleteProduct(String productID){
        String sql = "delete from Product where Product.product_id = ?";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql);  
            stm.setString(1, productID);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        } 
    }
    
    public void updateProduct(String nID, String cateID, String pName, float price, String describe, String img, int quantity,String oID){
        String sql = "update Product set product_id = ?,  category_id = ?,product_name = ?, product_price = ?, product_describe = ?,img = ?, quantity = ? where product_id = ?";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql); 
            stm.setString(1, nID);
            stm.setString(2, cateID);
            stm.setString(3, pName);
            stm.setFloat(4, price);
            stm.setString(5, describe);
            stm.setString(6, img);
            stm.setInt(7, quantity);
            stm.setString(8, oID);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        } 
    } 
    
    public List<Product> getTop10Product() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT TOP 10 O.productID, P.category_id, P.product_name, P.product_price, P.product_describe, P.img, P.quantity,\n" 
                   + "SUM(O.quantity) AS TotalSold\n" 
                   + "FROM OrderDetails O\n" 
                   + "INNER JOIN Product P ON O.productID = P.product_id\n" 
                   + "GROUP BY O.productID, P.category_id, P.product_name,P.product_price, P.product_describe, P.img, P.quantity\n"
                   + "ORDER BY TotalSold DESC";
        try { 
            PreparedStatement stm = connection.prepareStatement(sql); 
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Category c = new Category(rs.getInt(2));
                list.add(new Product(rs.getString(1),
                                     c,
                                     rs.getString(3),
                                     rs.getFloat(4),
                                     rs.getString(5),
                                     rs.getString(6),
                                     rs.getInt(7))); 
            } 
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }  
}

