package Controller;
import Util.RecommendUtil;
import business.*;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Data.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class CartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String url = "/index.jsp";
        ServletContext sc = getServletContext();
        String action = request.getParameter("action");
        if (action == null) {
            action = "cart";
        }
        if (action.equals("shop")) {
            url = "/shop.jsp";
        }
        else if (action.equals("cart")) {
            String productCode = request.getParameter("fruitID");
            String quantityString = request.getParameter("quantity");
            String type = request.getParameter("update");
            if(type == null) type = "false";
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
            }
            int quantity;
            try {
                quantity = Integer.parseInt(quantityString);
                if (quantity < 0) {
                    quantity = 1;
                }
            } catch (NumberFormatException nfe) {
                quantity = 1;
            }

            Product product = ProductDB.selectProduct(productCode);
            LineItem lineItem = new LineItem();
            lineItem.setItem(product);
            lineItem.setQuantity(quantity);

            if (quantity > 0) {

                cart.addItem(lineItem, type);
                Collection<LineItem> lineItems = cart.getItems();
                List<Product> customerPurchasedProducts = new ArrayList<>();
                for (LineItem lineItem1 : lineItems){
                    customerPurchasedProducts.add((Product) lineItem1.getItem());
                }
                List<Product> recommendProductsList = RecommendUtil.recommendProducts(customerPurchasedProducts, ProductDB.getAllProducts());
                List<Product> lineItemRecommend = new ArrayList<>(recommendProductsList);
                session.setAttribute("productRecommended",lineItemRecommend);

            } else if (quantity == 0) {
                cart.removeItem(lineItem);
            }
            session.setAttribute("cart", cart);
            url = "/cart.jsp";
        }
        else if (action.equals("checkout")) {
            url = "/checkout.jsp";
        }

        sc.getRequestDispatcher(url)
                .forward(request, response);
    }
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
