<%@page import="com.kulchuri.bill.course.CourseDao"%>
<%@page import="com.kulchuri.bill.course.CourseDto"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Insert title here</title>
        <link href="css/style.css" rel="stylesheet" type="text/css">

    </head>
    <body>
        <%@ include file="main_header.jsp"%>
        <%@ include file="accountant_menu.jsp"%>
        <div style="width: 50%; margin-left: 25%">
            <form enctype="multipart/form-data" action="StudentController" method="post">
                <input class="field" type="text" name="name" placeholder="Enter name">
                <input class="field" type="email" name="email" placeholder="Enter email">
                <input class="field" type="text" name="mno" placeholder="Enter mobile number">
                <input class="field" type="text" name="paid" placeholder="Enter paid amount">
                <input class="field" type="text" name="address" placeholder="Enter address">
                <input type="radio" name="gender" value="Male">Male
                <input type="radio" name="gender" value="Female">Female
                <input type="file" class="field" name="photo">
                <%
                    ArrayList<CourseDto> al = new CourseDao().getAllCourses();
                %>
                <select name="cid" class="field">
                    <option value="">---Select Course---</option>
                    <% for (CourseDto dto : al) {%>
                    <option value="<%=dto.getCid()%>"><%=dto.getName()%></option>
                    <%}%>
                </select>
                <input type="submit" value="Register">		
            </form>
        </div>
    </body>
</html>