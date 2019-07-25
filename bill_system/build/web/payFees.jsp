<%@page import="com.kulchuri.bill.student.StudentDao"%>
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
        <%@ include file="accountant_menu.jsp"%>
    <center><h1>Pay Remaining Fees</h1></center>

    <div style="width: 30%; margin-left: 35%">
        <%                
            String sid = request.getParameter("sid");
            if (request.getMethod().equalsIgnoreCase("post")) {
                float paid = Float.parseFloat(request.getParameter("paid"));
                int ssid = Integer.parseInt(sid);
                StudentDao sd = new StudentDao();
                float balance = sd.getBalance(ssid) - paid;
                if (sd.addFees(paid, balance, ssid)) {
                    response.sendRedirect("viewFees.jsp");
                }                    
            }
            if (sid != null) {
        %>

        <form action="payFees.jsp" method="post">
            <input type="hidden" name="sid" value="<%=sid%>"/>
            <input class="field" required="" autofocus="" type="text" name="paid" placeholder="Enter Amout to paid"/>
            <input type="submit" value="Pay"/>
        </form>
        <%}%>
    </div>
</body>
</html>