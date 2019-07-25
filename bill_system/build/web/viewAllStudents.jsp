<%@page import="com.kulchuri.bill.course.CourseDto"%>
<%@page import="com.kulchuri.bill.course.CourseDao"%>
<%@page import="com.kulchuri.bill.student.StudentDao"%>
<%@page import="com.kulchuri.bill.student.StudentDto"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="sdao" class="com.kulchuri.bill.student.StudentDao"></jsp:useBean>
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
        <script>
            function getStudents() {
                var cid = document.getElementById("cid").value;
                window.location.replace("viewAllStudents.jsp?cid=" + cid);
            }
        </script>
        <%
            ArrayList<StudentDto> al = null;
            String cid = request.getParameter("cid");
            if (cid != null) {
                al = sdao.getAllStudentsByBranchAndCourse(uname, cid);
            } else {
                al = sdao.getAllStudentsByAccountant(uname);
            }
        %>
        <div id="customers">
            <center>
                <select style="width: 30%" class="field" id="cid" onchange="getStudents()">
                    <option value="">--Select Course--</option>
                    <%
                        ArrayList<CourseDto> alc = new CourseDao().getAllCoursesByBranch(sdao.getBranchId(uname));
                        if (alc != null) {
                            for (CourseDto cd : alc) {
                    %>
                    <option value="<%=cd.getCid()%>"><%=cd.getName()%></option>
                    <%}
                        }%>
                </select>
            </center>
            <%
                if (al != null) {
            %>
            <h1>List of Students</h1>
            <table style="width: 100%">
                <tr>
                    <th>S.No.</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th>Gender</th>
                    <th>D.O.J</th>
                    <th>Address</th>                    
                    <th>Balance</th>
                    <th>Photo</th>
                    <th>Operation</th>
                </tr>
                <%     int s = 0;
                    for (StudentDto dto : al) {
                        ++s;
                %>
                <tr>
                    <td><%=s%></td>
                    <td><%=dto.getName()%></td>
                    <td><%=dto.getEmail()%></td>
                    <td><%=dto.getMno()%></td>
                    <td><%=dto.getGender()%></td>
                    <td><%=dto.getDoj()%></td>
                    <td><%=dto.getAddress()%></td>

                    <td><%=dto.getBalance()%></td>
                    <td><img src="data:image/jpeg;base64,<%=dto.getPhoto()%>"
                             width="50" height="50"></td>
                    <td>
                        <a href="viewFees.jsp?sid=<%=dto.getSid()%>">Paid</a>
                        <%
                            if (dto.getBalance() > 0) {
                        %>
                        <a href="payFees.jsp?sid=<%=dto.getSid()%>">ToPay</a>
                        <%}%>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <center><h1>These are no student available for this course</h1></center>
                        <%}%>
            </table>
        </div>
    </body>
</html>