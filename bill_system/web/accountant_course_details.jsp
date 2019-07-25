<%-- 
    Document   : accountant_course_details
    Created on : Mar 26, 2019, 10:49:04 AM
    Author     : DELL
--%>

<%@page import="com.kulchuri.bill.course.CourseDao"%>
<%@page import="com.kulchuri.bill.course.CourseDto"%>
<%@page import="java.util.ArrayList"%>
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
        <%@ include file="accountant_menu.jsp"%>
        <div style="margin-left: 25%; width: 50%" >
            <%
                ArrayList<CourseDto> al = new CourseDao().getAllCoursesByAccountant(uname);
                if (al != null) {
            %>
            <table id="customers">
                <h1>List of Course</h1>

                <tr>
                    <th>S.No.</th>
                    <th>Name</th>
                    <th>Fees</th>
                </tr>
                <%
                    int s = 0;
                    for (CourseDto cd : al) {%>
                <tr>
                    <td><%=++s%></td>
                    <td><%=cd.getName()%></td>
                    <td><%=cd.getFees()%></td>
                </tr>
                <%}%>
            </table>
            <%} else {%>
            <h1>Data Not Available</h1>
            <%}%>
        </div>
    </body>
</html>