<%@page import="com.kulchuri.bill.fees.FeesDao"%>
<%@page import="com.kulchuri.bill.fees.FeesDto"%>
<%@page import="java.util.ArrayList"%>
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
        <div id="customers" style="margin-left: 20%; margin-top: 2%">
            <%
                String sid = request.getParameter("sid");
                if (sid != null) {
            %>

            <table style="width: 60%">
                <tr>
                    <th>S.No.</th>
                    <th>Paid</th>
                    <th>Balance</th>
                    <th>Date</th>
                </tr>
                <%
                    ArrayList<FeesDto> al = new FeesDao().getAllFeeses(Integer.parseInt(sid));
                    int s = 0;
                    for (FeesDto fd : al) {
                %>
                <tr>
                    <td><%=++s%></td>
                    <td><%=fd.getPaid()%> </td>
                    <td><%=fd.getBalance()%></td>
                    <td><%=fd.getDate()%></td>
                </tr>
                <%}%>
            </table>
            <%}%>
        </div>
    </body>
</html>