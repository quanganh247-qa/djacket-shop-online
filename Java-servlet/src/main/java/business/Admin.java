package business;

import jakarta.persistence.*;

import java.util.Collection;

@Entity
public class Admin {

    @Id
    private String adminID;

    public String getAdminID() {
        return adminID;
    }

    public void setAdminID(String adminID) {
        this.adminID = adminID;
    }

    @Basic
    private String userName;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Basic
    private String passwd;

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    @OneToMany
    private Collection<business.Product> Product;

    public Collection<business.Product> getProduct() {
        return Product;
    }

    public void setProduct(Collection<business.Product> product) {
        Product = product;
    }
}
