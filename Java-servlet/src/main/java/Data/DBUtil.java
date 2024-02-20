package Data;
import jakarta.persistence.*;

import jakarta.persistence.EntityManagerFactory;
public class DBUtil {
    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("default");

    public static EntityManagerFactory getEmFactory() {
        return emf;
    }
}
