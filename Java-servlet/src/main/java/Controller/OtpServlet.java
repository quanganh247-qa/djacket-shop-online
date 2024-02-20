package Controller;
import business.Cart;
import business.Customer;
import jakarta.mail.*;
import jakarta.mail.Authenticator;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Properties;
import java.util.Random;

public class OtpServlet extends HttpServlet {
    private String generateOtp() {
        Random random = new Random();
        return String.format("%04d", random.nextInt(10000));
    }

    private void sendOtpEmail(String toEmail, String otp) {
        // Your email configuration
        final String username = "fsmile3107@gmail.com";
        final String password = "ptkc prht nagg sxwk";
        // Thiết lập Content-Type là text/html


        // Set the properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        // Get the Session object
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // Create a message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("OTP Verification");
            message.setText("Your OTP for email verification is: " + otp);
            Transport.send(message);
            System.out.println("Email sent successfully!");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        ServletContext servletContext = request.getServletContext();
        String action = request.getParameter("action");
        String url ="/checkout.jsp";


        if(action == null) {
            action = "sendEmail";
        }
        if (action == "shop") {
            url ="/shop.jsp";
        }
        else if (action == "sendEmail"){
            Cart cart =(Cart) session.getAttribute("cart");
            if(cart!=null){

                String name = request.getParameter("Name");
                String address = request.getParameter("Address");
                String contact = request.getParameter("Phone");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                String userEmail = request.getParameter("Email");
                String moreInfo = request.getParameter("bill");
                String card = request.getParameter("Credit");
                Customer customer = new Customer();
                customer.setId(customer.getId());
                customer.setName(name);
                customer.setEmail(userEmail);
                customer.setContact(contact);
                customer.setAddress(address);
                customer.setCreditCard(card);
                customer.setFeedback(moreInfo);
                session.setAttribute("customer",customer);
                if(customer != null) {
                    String otp = generateOtp();
                    session.setAttribute("otp", otp);
                    sendOtpEmail(userEmail, otp);
                    response.getWriter().println("OTP sent to " + userEmail);
                    session.setAttribute("emailOTP", userEmail);
                    String Message = "Please check your email. Please confirm OTP";
                    request.setAttribute("Message", Message);
                }
                else {
                    String retryMessage = "Please fill information.";
                    request.setAttribute("retryMessage", retryMessage);
                }
            }
            else {
                String retryMessage = "Please add products.";
                request.setAttribute("retryMessage", retryMessage);
            }
        }
        servletContext.getRequestDispatcher(url)
                .forward(request, response);
    }
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

}