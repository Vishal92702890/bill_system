<%@page import="com.kulchuri.bill.branch.BranchDto"%>
<%@page import="com.kulchuri.bill.course.CourseDto"%>
<%@page import="com.kulchuri.bill.course.CourseDao"%>
<%@page import="com.kulchuri.bill.student.StudentDao"%>
<%@page import="com.kulchuri.bill.student.StudentDto"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="bdao" class="com.kulchuri.bill.branch.BranchDao"></jsp:useBean>
<jsp:useBean id="sdao" class="com.kulchuri.bill.student.StudentDao"></jsp:useBean>
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
        <script>
            function getCourse() {
                var bid = document.getElementById("bid").value;
                var obj = new XMLHttpRequest();
                obj.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        var res = this.responseText;
                        document.getElementById("course").innerHTML = res;
                    }
                };
                obj.open("GET", "GET_DATA_AJAX.jsp?bid=" + bid + "&opn=course", true);
                obj.send();
            }
            function getStudents() {
                var cid = document.getElementById("course").value;
                alert(cid);
                var obj = new XMLHttpRequest();
                obj.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        var res = this.responseText;
                        document.getElementById("students").innerHTML = res;
                    }
                };
                obj.open("GET", "GET_DATA_AJAX.jsp?cid=" + cid + "&opn=students", true);
                obj.send();
            }
        </script>

        <div id="customers">

            <select style="width: 30%" onchange="getCourse()" id="bid" class="field" name="bid">
                <option value="">--Select Branch--</option>
                <%                    ArrayList<BranchDto> al1 = bdao.getAllBranches();
                    for (BranchDto dto : al1) {

                %>
                <option value="<%=dto.getBid()%>"><%=dto.getName()%></option>
                <%
                    }
                %>
            </select>
            <select onchange="getStudents()" style="width: 20%" class="field" id="course">
                <option value="">--Select Course--</option>
            </select>


            <h1>List of Students</h1>
            <table style="width: 100%" id="students">
                <tr>
                    <th>S.No.</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th>Gender</th>
                    <th>D.O.J</th>
                    <th>Address</th>                    
                </tr>
            </table>
        </div>
    </body>
</html>