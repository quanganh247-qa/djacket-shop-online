package business;

import jakarta.persistence.*;

import java.text.NumberFormat;

@Entity
public class LineItem {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long lineItemID;

    public Long getLineItemID() {
        return lineItemID;
    }

    public void setLineItemID(Long lineItemID) {
        this.lineItemID = lineItemID;
    }

    @Basic
    private Integer quantity =1;

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    @OneToOne(optional = false)
    private Product item;

    public Product getItem() {
        return item;
    }

    public void setItem(Product item) {
        this.item = item;
    }

    public double getTotal() {
        double total = item.getPrice() * quantity;
        return total;
    }

    public String getTotalCurrencyFormat() {
        NumberFormat currency = NumberFormat.getCurrencyInstance();
        return currency.format(this.getTotal());
    }
}
