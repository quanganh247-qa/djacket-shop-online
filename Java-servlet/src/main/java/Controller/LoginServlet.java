package Controller;

import Data.AdminDB;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        String url ="/index.jsp";
        ServletContext sc = request.getServletContext();
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String username =request.getParameter("j_username");
        String pass =request.getParameter("j_password");
        if(action==null){
            action = "Login";
        }
        if (action.equals("Login")){

            AdminDB adminDB = new AdminDB();
            if (adminDB.login(username,pass) != null){
                session.setAttribute("admin",adminDB.login(username,pass));
                url ="/dashboard.jsp";

            }
            else {
                String retryMessage = "Incorrect account or password. Please retry.";
                request.setAttribute("retryMessage", retryMessage);
            }
        }
        else {
            url ="/404.html";
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
