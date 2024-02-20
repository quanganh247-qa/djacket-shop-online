package Data;

import business.LineItem;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
public class LineItemDB {
    public static void insert(LineItem lineItem) {
        EntityManager em3 = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em3.getTransaction();
        trans.begin();
        try {
            em3.persist(lineItem);
            trans.commit();
        } catch (Exception e) {
            System.out.println(e);
            trans.rollback();
        } finally {
            em3.close();
        }
    }
}
