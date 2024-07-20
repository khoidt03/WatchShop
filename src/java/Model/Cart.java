/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

 
import dal.ProductDAO;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class Cart { 
    private static List<Item> items = new ArrayList<>();     
 

    public List<Item> getAllItem(){
        return items;
    }   
    public void getAllItemCookie(String listCart){ 
        //BL1835MKW>5>8350000.0::AE1000>1>1813000.0 
        String[] items = listCart.split(":");
        for (String s : items) {
            if (!s.isEmpty()) {
                String[] item = s.split(">");
                ProductDAO p = new ProductDAO();
                Item i = new Item(p.getProductByID(item[0]), Integer.parseInt(item[1]), Float.parseFloat(item[2]));
                addCart(i);
            }
        }
    }  
    public Item isDuplicateItem(Item item){
        if(items == null){
            return null;
        }
        for(Item it: items){
            if(it.getProduct().getProduct_id().equals(item.getProduct().getProduct_id())){
                return it;
            }
        }
        return null;
    }
    public void addCart(Item item){ 
        Item it = isDuplicateItem(item);
        if(it != null){
            it.setQuantity(it.getQuantity() + item.getQuantity()); 
        }
        else{
            items.add(item);
        } 
    }
    
    public void removeCart(String pID){
        items.remove(getItemByID(pID));
    }
    
    public Item getItemByID(String id){
        for(Item i: items){
            if(i != null && i.getProduct().getProduct_id().equals(id)){
                return i;
            }
        }
        return null;
    }
    public float getTotalMoney(){
        float total = 0;
        for(Item i: items){
            total += i.getQuantity() * i.getPrice();
        }
        return total;
    }
    
}
