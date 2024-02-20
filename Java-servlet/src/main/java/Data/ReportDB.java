package Data;

import business.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReportDB {
    public static double total_revenue(){
        double totalrenvune = 0;
        List<Invoice> invoiceList = InvoiceDB.selectInvoice();
        for (Invoice invoice : invoiceList){
            List<LineItem> lineItems = (List<LineItem>) invoice.getLineItem();
            for(LineItem lineItem : lineItems){
                totalrenvune += lineItem.getTotal();
            }
        }
        return totalrenvune;
    }
    public static Product popularProduct(){
        Map<Product, Integer> productIntegerMap = new HashMap<>();
        List<Invoice> invoiceList = InvoiceDB.selectInvoice();
        for (Invoice invoice : invoiceList){
            List<LineItem> lineItems = (List<LineItem>) invoice.getLineItem();
            for(LineItem lineItem : lineItems){
                Product product = lineItem.getItem();
                int quantity = lineItem.getQuantity();
                productIntegerMap.merge(product,quantity,Integer::sum);
            }
        }
        Product mostPopular = null;
        int maxQuantity = 0;
        for (Map.Entry<Product,Integer>entry : productIntegerMap.entrySet()){
            if(entry.getValue()>maxQuantity){
                maxQuantity = entry.getValue();
                mostPopular = entry.getKey();
            }
        }
        return mostPopular;
    }

    public static long numberVisitor(){
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        String qString = "SELECT count(c) FROM Customer c ";
        TypedQuery<Long> q = em.createQuery(qString, Long.class);
        Long results = null;
        try {
            results = q.getSingleResult();
        } catch (NoResultException ex) {
            return 0L;
        } finally {
            em.close();
        }
        return results;
    }


}
