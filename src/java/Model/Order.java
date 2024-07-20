/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class Order {
    private int orderID;
    private int customerID;
    private String address;
    private String phoneNumber;
    private Date orderDate;
    private float total;
    private OrderStatus orderStatus;

    public Order() {
    } 

    public Order(int orderID, int customerID, String address, String phoneNumber, Date orderDate, float total, OrderStatus status) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.orderDate = orderDate;
        this.total = total;
        this.orderStatus = status;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public OrderStatus getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(OrderStatus orderStatus) {
        this.orderStatus = orderStatus;
    }

    @Override
    public String toString() {
        return "Order{" + "orderID=" + orderID + ", customerID=" + customerID + ", address=" + address + ", phoneNumber=" + phoneNumber + ", orderDate=" + orderDate + ", total=" + total + ", orderStatus=" + orderStatus + '}';
    }

    
    
    
}
