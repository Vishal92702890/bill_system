
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Insert title here</title>
        <link href="css/style.css" type="text/css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="main_header.jsp"%>
        <%@ include file="main_menu.jsp"%>
        <div style="width: 50%; margin-left: 25%; margin-top: 5%">
            <h1>Login</h1>
            <%
                if (request.getMethod().equalsIgnoreCase("post")) {
            %>
            <jsp:useBean id="ld" class="com.kulchuri.bill.login.LoginDto"></jsp:useBean>
            <jsp:setProperty name="ld" property="*"></jsp:setProperty>
            <jsp:useBean id="ldao" class="com.kulchuri.bill.login.LoginDao"></jsp:useBean>
            <%
                    String type = ldao.checkUser(ld);
                    if (type != null) {
                        if (type.equalsIgnoreCase("admin")) {
                            session.setAttribute("uname", ld.getUname());
                            session.setAttribute("type", type);
                            response.sendRedirect("admin_home.jsp");
                        } else if (type.equalsIgnoreCase("accountant")) {
                            session.setAttribute("uname", ld.getUname());
                            session.setAttribute("type", type);
                            response.sendRedirect("accountant_home.jsp");
                        }
                    } else {
                        out.print("<script>alert('Please Enter valid Login Details')</script>");
                    }
                }
            %>

            <form action="login.jsp" method="post">
                <input class="field" type="text" name="uname" placeholder="Enter username" required=""> 
                <input class="field" type="password" name="pwd" placeholder="Enter password" required=""> 
                <input style="width: 20%;" type="submit" value="Signin">
                <a href="forgetPassword.jsp">forget password</a>
            </form>
        </div>
    </body>
</html>