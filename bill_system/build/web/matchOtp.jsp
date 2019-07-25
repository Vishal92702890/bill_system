<%-- 
    Document   : matchOtp
    Created on : Mar 29, 2019, 1:48:45 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/style.css" type="text/css" rel="stylesheet">

    </head>
    <body>
        <%@ include file="main_header.jsp"%>
        <%@ include file="main_menu.jsp"%>
    <center>OTP Match Form</center>
        <%
            String otp = request.getParameter("otp");
            if (otp != null) {
                int newOtp = Integer.parseInt(otp);
                Integer oldOtp = (Integer) session.getAttribute("otp");
                if (newOtp == oldOtp) {
                    session.removeAttribute("otp");
                    response.sendRedirect("resetPwd.jsp");
                } else {
                    out.print("<script> alert('Plsease Enter Valid OTP')</script>");
                }
            }
        %>
    <div style="width: 50%; margin-left: 25% ">
        <form action="matchOtp.jsp" method="post">
            <input required="" autofocus="" class="field" type="text" name="otp" placeholder="Enter OTP"/>
            <input type="submit" value="Submit" name="opn"/>
        </form>
    </div>
</body>
</html>
