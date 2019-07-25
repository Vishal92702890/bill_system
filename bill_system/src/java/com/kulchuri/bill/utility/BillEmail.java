package com.kulchuri.bill.utility;

import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class BillEmail {

    private static String host = "localhost";
    static String MAIL_SERVER = "smtp.gmail.com";
    static String uname = "your emailID";
    static String pwd = "password";

    public static boolean sendMail(String toEmail, String otp) {
        boolean flag = false;

        try {
            Properties properties = System.getProperties();
            properties.put("mail.smtps.host", MAIL_SERVER);
            properties.put("mail.smtps.auth", "true");
            Session session = Session.getInstance(properties);
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(host));
            // msg.addRecipients(Message.RecipientType.TO, new InternetAddress(toSend));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            msg.setSubject("your OTP");
            msg.setText(otp);
            Transport tr = session.getTransport("smtps");
            tr.connect(MAIL_SERVER, uname, pwd);
            tr.sendMessage(msg, msg.getAllRecipients());
            tr.close();
            System.out.println("sending success");
            flag = true;
        } catch (Exception e) {
            System.out.println(e);
        }
        return flag;
    }

    public static int getOtp() {
        Random rand = new Random();
        return rand.nextInt(4000);
    }

    public static void main(String[] args) {
        System.out.println(getOtp());
    }
}
