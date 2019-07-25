<%@page import="com.kulchuri.bill.branch.BranchDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Insert title here</title>
        <link href="css/style.css" rel="stylesheet" type="text/css">

    </head>
    <body>
        <%@ include file="main_header.jsp"%>
        <%@ include file="admin_menu.jsp"%>

        <%            if (request.getMethod().equalsIgnoreCase("post")) {
        %>
        <jsp:useBean id="dto" class="com.kulchuri.bill.branch.BranchDto"></jsp:useBean>
        <jsp:setProperty property="*" name="dto" />
        <%
                if (new BranchDao().addBranch(dto)) {
                    out.print("success");
                } else {
                    out.print("failed");
                }
            }
        %>
        <div style="width: 50%; margin-left: 25%">
            <h1>New Branch</h1>
            <form action="addBranch.jsp" method="post">
                <input class="field" type="text" name="name" placeholder="Enter name"
                       autofocus="" required pattern="[A-z|\s]*"
                       onchange="this.setCustomValidity(validity.patternMismatch ? 'Please Enter Only Alphabets for Branch Name' : '');">
                <input class="field" type="text" name="city" placeholder="Enter city"
                       required pattern="[A-z|\s]*"
                       onchange="this.setCustomValidity(validity.patternMismatch ? 'Please Enter Only Alphabets for City Name' : '');">
                <input class="field" type="text" name="address"
                       placeholder="Enter address" required=""> 

                <input type="text"
                       required pattern="[0-9]{12}"
                       onchange="this.setCustomValidity(validity.patternMismatch ? 'Please Enter Only 12 Digits' : '');"

                       class="field" name="phone" placeholder="Enter phone" required="">
                <input type="submit" value="Add">
            </form>


        </div>
    </body>
</html>