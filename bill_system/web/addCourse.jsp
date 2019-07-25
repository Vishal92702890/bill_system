<%@page import="com.kulchuri.bill.course.CourseDao"%>
<%@page import="com.kulchuri.bill.branch.BranchDto"%>
<%@page import="java.util.ArrayList"%>
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
	


	<%
		if (request.getMethod().equalsIgnoreCase("post")) {
	%>
	<jsp:useBean id="dto" class="com.kulchuri.bill.course.CourseDto"></jsp:useBean>
	<jsp:setProperty property="*" name="dto" />
	<%
		if (new CourseDao().addCourse(dto)) {
				response.sendRedirect("viewAllCourses.jsp");
			} else {
				out.print("failed");
			}
		}
	%>
	<div style="width: 50%; margin-left: 25%">
		<form action="addCourse.jsp" method="post">
			<input class="field" type="text" name="name" placeholder="Enter name"
				required="" autofocus=""> 
				<input class="field" type="text" name="fees" placeholder="Enter fees" required=""> 
				
                                <select required="" class="field" name="bid">
                                    <option value="">--Select Branch--</option>
				<%
					ArrayList<BranchDto> al = new BranchDao().getAllBranches();
					for (BranchDto dto : al) {
				%>
				<option value="<%=dto.getBid()%>"><%=dto.getName()%></option>
				<%
					}
				%>
			</select> <input type="submit" value="Add">
		</form>
	</div>
</body>
</html>