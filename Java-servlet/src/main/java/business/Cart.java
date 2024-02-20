package business;

import java.text.NumberFormat;
import java.util.*;
import java.io.Serializable;

public class Cart implements Serializable {

    private List<LineItem> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public void setItems(List<LineItem> lineItems) {
        items = lineItems;
    }

    public List<LineItem> getItems() {
        return items;
    }

    public int getCount() {
        return items.size();
    }

    public void addItem(LineItem item, String type) {
        //If the item already exists in the cart, only the quantity is changed.
        String code = item.getItem().getFruitID();
        String update = type.toString();
        int quantity = item.getQuantity();

        if(update.equals("true"))
        {
            for (int i = 0; i < items.size(); i++) {
                LineItem lineItem = items.get(i);
                if (lineItem.getItem().getFruitID().equals(code))
                {
                    lineItem.setQuantity(quantity);
                    return;
                }
            }
        }
        else // add
        {
            for (int i = 0; i < items.size(); i++) {
                LineItem lineItem = items.get(i);
                if (lineItem.getItem().getFruitID().equals(code))
                {
                    lineItem.setQuantity(lineItem.getQuantity() + quantity);
                    return;
                }
            }
            items.add(item); // new
        }
    }

    public void removeItem(LineItem item) {
        String code = item.getItem().getFruitID();
        for (int i = 0; i < items.size(); i++) {
            LineItem lineItem = items.get(i);
            if (lineItem.getItem().getFruitID().equals(code)) {
                items.remove(i);
                return;
            }
        }
    }
    public double totalBillWithoutShip()
    {
        double sum = 0;
        for (var item: items)
        {
            sum += item.getTotal();
        }
        return sum;
    }
    public String getTotalWithoutShipCurrencyFormat() {
        NumberFormat currency = NumberFormat.getCurrencyInstance();
        return currency.format(this.totalBillWithoutShip());
    }
    public double Shipping(){
        if(totalBillWithoutShip()<75) {
            return this.totalBillWithoutShip() * 0.1;
        }
        else {
            return 0;
        }
    }

    public String getTotalCurrentFormat() {
        NumberFormat currency = NumberFormat.getCurrencyInstance();
        double total = this.totalBillWithoutShip() + this.Shipping();
        double roundedTotal = Math.round(total * 100.0) / 100.0; // Round to 2 decimal places
        return currency.format(roundedTotal);
    }
    public String getShipCurrentFormat(){
        NumberFormat currency = NumberFormat.getCurrencyInstance();
        return currency.format(this.Shipping());
    }
}