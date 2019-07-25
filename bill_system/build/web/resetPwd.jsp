<%-- 
    Document   : resetPwd
    Created on : Mar 29, 2019, 1:55:53 PM
    Author     : DELL
--%>

<%@page import="com.kulchuri.bill.login.LoginDto"%>
<%@page import="com.kulchuri.bill.login.LoginDao"%>
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
    <center><h1>Reset Password</h1></center>
        <%
            if (request.getMethod().equalsIgnoreCase("post")) {
                String pwd = request.getParameter("pwd");
                String email = (String) session.getAttribute("email");
                LoginDto ld = new LoginDto();
                ld.setPwd(pwd);
                ld.setUname(email);
                if (new LoginDao().updatePwd(ld)) {
                    session.removeAttribute("email");
                    response.sendRedirect("login.jsp");
                }
            }
        %>
    <div style="width: 30%; margin-left: 35% ">
        <form action="resetPwd.jsp" method="post">
            <input class="field" type="password" required="" autofocus="" name="pwd" placeholder="Enter Password"/>
            <input type="submit" value="Submit"/>
        </form>
    </div>
</body>
</html>
