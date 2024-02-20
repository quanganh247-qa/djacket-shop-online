    package Controller;
    import Data.InvoiceDB;
    import Data.UserDB;
    import business.*;
    import jakarta.mail.*;
    import jakarta.mail.internet.InternetAddress;
    import jakarta.mail.internet.MimeMessage;
    import jakarta.servlet.ServletContext;
    import jakarta.servlet.ServletException;
    import jakarta.servlet.http.HttpServlet;
    import jakarta.servlet.http.HttpServletRequest;
    import jakarta.servlet.http.HttpServletResponse;
    import jakarta.servlet.http.HttpSession;
    import java.text.ParseException;
    import java.io.IOException;
    import java.util.Collection;
    import java.util.Date;
    import java.util.Properties;

    public class PaymentServlet extends HttpServlet {
        public static void sendEmail(String toEmail, String emailContent) {
            final String username = "fsmile3107@gmail.com";
            final String password = "ptkc prht nagg sxwk";

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
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(username));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
                message.setSubject("Invoice Verification");
                message.setContent(emailContent, "text/html");
                Transport.send(message);
                System.out.println("Email sent successfully!");

            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }
        }
        public static String generateVerificationEmail(Invoice invoice,Cart cart) throws ParseException {

            StringBuilder content = new StringBuilder();
            content.append("<html><body>");
            content.append("<h2>Invoice Verification</h2>");
            content.append("<p>Dear " + invoice.getCustomer().getName() + ",</p>");
            content.append("<p>Thank you for your recent purchase. Please verify the details of your invoice:</p>");
            content.append("<p>ID: " + invoice.getInvoiceID() + "</p>");
            content.append("<p>Date: " + invoice.getDate() + "</p>");
            content.append("<h3>Products</h3>");
            content.append("<ul>");
            for (LineItem lineItem : invoice.getLineItem()) {
                content.append("<li>" + lineItem.getItem().getName() +" with "+ lineItem.getQuantity()  +" Per Kg" + "</li>");
            }
            content.append("</ul>");
            content.append("<p>Total bill: "+cart.getTotalCurrentFormat()+ "</p>");
            content.append("<p>Thank you for choosing our services.</p>");
            content.append("<p>Best regards,</p>");
            content.append("<p>A.P.A Company</p>");
            content.append("</body></html>");

            return content.toString();
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            String url="/index.jsp";
            ServletContext servletContext= getServletContext();
            HttpSession session = request.getSession();
            String action = request.getParameter("action");
            if (action == null){ action = "otpForm";}
            if (action.equals("shop")){
                url ="/shop.jsp";
            }
            if (action == "otpForm"){
                String otpInput = request.getParameter("otpInput");
                Cart cart =(Cart) session.getAttribute("cart");

                String otpValue = (String) session.getAttribute("otp");

                //check otp value ? LIVE
                if(otpValue!= null){
                    if(otpValue.equals(otpInput)){
                        Customer customer = (Customer) session.getAttribute("customer");
                        Invoice invoice = new Invoice();
                        Collection<LineItem> lineItems = cart.getItems();
                        invoice.setInvoiceID(invoice.getInvoiceID());
                        invoice.setCustomer(customer);
                        invoice.setLineItem(lineItems);
                        invoice.setDate(new Date());
                        invoice.setTotal(cart.totalBillWithoutShip()+ cart.Shipping());
                        String userEmail = customer.getEmail();
                        UserDB.insert(customer);
                        InvoiceDB.insert(invoice);
                        session.setAttribute("invoice",invoice);

                        try {
                            sendEmail(userEmail,generateVerificationEmail(invoice,cart));
                            session.removeAttribute("cart");
                            session.removeAttribute("otp");
                            session.removeAttribute("customer");
                            // Invalidate the entire session
                            session.invalidate();

                            url = "/index.jsp";
                        } catch (ParseException e) {
                            throw new RuntimeException(e);
                        }

                    }
                    else {
                        url ="/checkout.jsp";
                        String retryMessage = "Incorrect OTP. Please retry.";
                        request.setAttribute("retryMessage", retryMessage);
                    }
                }else {
                    url ="/checkout.jsp";
                    String retryMessage = "Please register to receive OTP.";
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
