package Controller;
import Data.AdminDB;
import business.Admin;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
public class ReportServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        String url ="/dashboard.jsp";
        ServletContext sc = request.getServletContext();
        String action = request.getParameter("action");
//        HttpSession session = request.getSession();
        HttpSession session = request.getSession(false); // Don't create a new session if one doesn't exist
        Admin admin =(Admin) session.getAttribute("admin");

        if(action==null){
            action = "logout";
        }
        if (action.equals("logout")){
            session.removeAttribute("admin");
            session.invalidate();
            url ="/index.jsp";
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }

        response.sendRedirect(request.getContextPath() + url);

    }

}
