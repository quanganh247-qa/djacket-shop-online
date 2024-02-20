package Data;

import business.Product;
import jakarta.persistence.*;

import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

public class ProductDB {
    public static void insert(String name, String origin, Double price, Date exp, Date input, String decription) {
        Product product = new Product();
        product.setName(name);
        product.setOrigin(origin);
        product.setPrice(price);
        product.setExp(exp);
        product.setDateInput(input);
        product.setDescription(decription);
        EntityManager em2 = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em2.getTransaction();
        trans.begin();
        try {
            Query query =em2.createQuery("select p from Product p ORDER BY p.fruitID DESC");
            query.setMaxResults(1);
            List<Product> results = query.getResultList();
            Product lastProduct = results.isEmpty() ? null : results.get(0);
            int index = lastProduct != null ? Integer.parseInt(lastProduct.getFruitID().substring(1)) + 1 : 1;
            String FruitID= "F" + String.format("%03d",index);
            product.setFruitID(FruitID);
            em2.persist(product);
            trans.commit();
        } catch (Exception e) {
            System.out.println(e);
            trans.rollback();
        } finally {
            em2.close();
        }
    }


    public static void Update(String fruitID, String name, String origin, String description, double price, Date exp, Date dateinput){
        EntityManager em2 = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction transaction = em2.getTransaction();
        Product product = ProductDB.selectProduct(fruitID);
        if(price==0){
            price=product.getPrice();
        }
        if(name.equals("")){
            name = product.getName();
        }
        if( origin.equals("")){
            origin= product.getOrigin();
        }
        if(description.equals("")){
            description = product.getDescription();
        }
        if(exp ==null ){
            exp = product.getExp();
        }
        if(dateinput == null){
            dateinput =product.getDateInput();
        }
        transaction.begin();
        product.setName(name);
        product.setExp(exp);
        product.setPrice(price);
        product.setDescription(description);
        product.setDateInput(dateinput);
        product.setOrigin(origin);
        try {
            em2.merge(product);
            transaction.commit();
        }
        catch (Exception a){
            System.out.println(a);
            transaction.rollback();
        }finally {
            em2.close();
        }
    }
    public static void remove(Product product){
        EntityManager em2 = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction transaction = em2.getTransaction();
        transaction.begin();
        try {
            em2.remove(product);
            transaction.commit();
        }catch (Exception a){
            System.out.println(a);
            transaction.rollback();
        }finally {
            em2.close();
        }
    }

    public static List<Product> getAllProducts() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        TypedQuery<Product> query = em.createQuery("SELECT p FROM Product p", Product.class);
        return query.getResultList();
    }

    public static Product selectProduct(String fruitID){
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        String qString = "SELECT p FROM Product p " +
                "WHERE p.fruitID = :fruitID";
        TypedQuery<Product> q = em.createQuery(qString, Product.class);
        q.setParameter("fruitID", fruitID);
        Product result = null;
        try {
            result = q.getSingleResult();
        } catch (NoResultException ex) {
            return null;
        } finally {
            em.close();
        }
        return (Product)result;
    }

public static List<Product> findProduct(String name) {
    EntityManager em = DBUtil.getEmFactory().createEntityManager();
    String qString = "SELECT p FROM Product p WHERE p.name LIKE :name";
    TypedQuery<Product> q = em.createQuery(qString, Product.class);
    q.setParameter("name", "%" + name + "%");
    List<Product> products = null;
    try {
        products = q.getResultList();
    } catch (NoResultException ex) {
        return null;
    } finally {
        em.close();
    }
    return products;
}

    public static void insert(Product product) {


        EntityManager em2 = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em2.getTransaction();
        trans.begin();
        try {

            em2.persist(product);
            trans.commit();
        } catch (Exception e) {
            System.out.println(e);
            trans.rollback();
        } finally {
            em2.close();
        }
    }
    public static Set<Product> getAllProductsbyset() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        TypedQuery<Product> query = em.createQuery("SELECT p.name FROM Product p", Product.class);
        List<Product> productList = query.getResultList();
        Set<Product> productSet = new LinkedHashSet<>(productList);
        return productSet;
    }

}
