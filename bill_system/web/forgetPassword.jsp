<%@page import="com.kulchuri.bill.utility.BillEmail"%>
<%@page import="com.kulchuri.bill.accountant.AccountantDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Insert title here</title>
        <link href="css/style.css" type="text/css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="main_header.jsp"%>
        <%@ include file="main_menu.jsp"%>
        <%
            if (request.getMethod().equalsIgnoreCase("post")) {
                String email = request.getParameter("email");
                if (new AccountantDao().checkEmail(email)) {
                    int otp = BillEmail.getOtp();
                    if (BillEmail.sendMail(email, otp + "")) {
                        session.setAttribute("email", email);
                        session.setAttribute("otp", otp);
                        response.sendRedirect("matchOtp.jsp");
                    } else {
                        out.print("<script> alert('There are Some Server Problems')</script>");
                    }
                } else {
                    out.print("<script> alert('Plsease Enter Valid Email ID')</script>");
                }
            }
        %>
    <center><h1>GET OTP for Reset Password</h1></center>
    <div style="width: 40%; margin-left: 30% ">
        <form action="forgetPassword.jsp" method="post">
            <input required="" autofocus="" class="field" type="email" name="email" placeholder="Enter Email ID"/>
            <input type="submit" value="Submit" name="opn"/>
        </form>
    </div>
</body>
</html>