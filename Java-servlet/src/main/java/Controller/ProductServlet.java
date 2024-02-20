package Controller;

import Data.ProductDB;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String insert = req.getParameter("insert");
        String update = req.getParameter("update");

        ServletContext servletContext = req.getServletContext();
        HttpSession session = req.getSession();
        String url ="/index.jsp";
        if (action == null){
            action = "controllProduct";
        }
        if (action.equals("controllProduct")){
            url = "/productable.jsp";
            if(insert != null) {
                String name = req.getParameter("NameProduct");
                String price = req.getParameter("Price");
                double priceProduct = Double.parseDouble(price);
                String dateString = req.getParameter("exp");
                String Description = req.getParameter("Description");
                Date exp = null;
                try {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    exp = dateFormat.parse(dateString);
                } catch (ParseException e) {
                    e.printStackTrace(); // Handle the parse exception appropriately
                }
                String dateInput = req.getParameter("DateInput");
                Date date = null;
                try {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    date = dateFormat.parse(dateInput);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                String origin = req.getParameter("Origin");
                ProductDB.insert(name,origin,priceProduct,exp,date,Description);
            }
            else if (update != null) {
                String name = req.getParameter("NameProduct");
                String price = req.getParameter("Price");

                int priceProduct ;
                if(price.equals("")){
                    priceProduct=0;
                }
                else{
                    priceProduct = Integer.parseInt(price);
                }
                String dateString = req.getParameter("exp");
                String Description = req.getParameter("Description");
                String origin = req.getParameter("Origin");
                String fruitID = req.getParameter("fruitID");
                Date exp = null;
                try {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    exp = dateFormat.parse(dateString);
                } catch (ParseException e) {
                    e.printStackTrace(); // Handle the parse exception appropriately
                }
                String dateInput = req.getParameter("DateInput");
                Date date = null;
                try {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    date = dateFormat.parse(dateInput);
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                ProductDB.Update(fruitID,name,origin,Description,priceProduct,exp,date);

            }


        }
        servletContext.getRequestDispatcher(url)
                .forward(req, resp);

    }
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
