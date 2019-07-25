<%@page import="com.kulchuri.bill.course.CourseDao"%>
<%@page import="com.kulchuri.bill.course.CourseDto"%>
<%@page import="com.kulchuri.bill.branch.BranchDao"%>
<%@page import="com.kulchuri.bill.branch.BranchDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Insert title here</title>
        <link href="css/style.css" rel="stylesheet" type="text/css">
        <script>
            function getCourses() {
                var bid = document.getElementById("bid").value;
                window.location.replace("viewAllCourses.jsp?bid=" + bid);
            }
        </script>

    </head>
    <body>
        <%@ include file="main_header.jsp"%>
        <%@ include file="admin_menu.jsp"%>
        <jsp:useBean id="bdao" class="com.kulchuri.bill.branch.BranchDao"></jsp:useBean>
        <center>
            <table>
                <tr>
                    <td>
                        <select onchange="getCourses()" id="bid" class="field" name="bid">
                        <%                                                    String name = null;
                            String bid = request.getParameter("bid");
                            if (bid != null) {
                                name = bdao.getBranchName(Integer.parseInt(bid));
                            }
                            if (name == null) {
                        %>
                        <option value="">--Select Branch--</option>
                        <%
                        } else {
                        %>
                        <option value="<%=bid%>"><%=name%></option>
                        <%
                            }
                            ArrayList<BranchDto> al1 = bdao.getAllBranches();
                            for (BranchDto dto : al1) {
                                if (name != null && (dto.getName().equalsIgnoreCase(name))) {
                                } else {
                        %>
                        <option value="<%=dto.getBid()%>"><%=dto.getName()%></option>
                        <%
                                }
                            }
                        %>
                    </select></td>
            </tr>
        </table>
        <h1>All Courses</h1>
    </center>

    <div id="customers">
        <table style="width: 60%; margin-left: 20%">
            <tr>
                <th>S.No.</th>
                <th>Name</th>
                <th>Fees</th>
                <th>Branch</th>
                <th>Operation</th>
            </tr>
            <%
                CourseDao cd = new CourseDao();
                ArrayList<CourseDto> al = null;
                String cid = request.getParameter("cid");
                if (cid != null) {
                    cd.deleteCourse(Integer.parseInt(cid));
                }
                if (bid != null) {
                    al = cd.getAllCoursesByBranch(Integer.parseInt(bid));
                } else {
                    al = cd.getAllCourses();
                }
                if (al != null) {
                    int s = 0;
                    for (CourseDto dto : al) {
            %>
            <tr>
                <td><%=++s%></td>
                <td><%=dto.getName()%></td>
                <td><%=dto.getFees()%></td>
                <td><%=dto.getBname()%></td>
                <td>
                    <a>Edit</a>
                    <a href="viewAllCourses.jsp?cid=<%=dto.getCid()%>" >Delete</a>
                </td>
            </tr>
            <%
                    }
                } else {
                }
            %>
        </table>
    </div>
</body>
</html>