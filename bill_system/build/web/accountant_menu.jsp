<%@page import="com.kulchuri.bill.accountant.AccountantDto"%>
<%
    String uname = (String) session.getAttribute("uname");
    String type = (String) session.getAttribute("type");
    if (uname == null || type == null) {
        response.sendRedirect("login.jsp");
    } else {
%>

<ul>
    <li><a href="accountant_home.jsp">Home</a></li>
    <li><a href="addStudent.jsp">Add Student</a></li>
    <li><a href="viewAllStudents.jsp">View Students</a></li>
    <li><a href="accountant_course_details.jsp">Courses</a></li>
    <li><a href="logout.jsp">Logout</a></li>
</ul>
<%}%>