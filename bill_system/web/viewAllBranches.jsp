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
</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="admin_menu.jsp"%>
	
<div id="customers">
		<h1>All Branches</h1>
		<table style="width: 100%">
			<tr>
				<th>S.No.</th>
				<th>Name</th>
				<th>City</th>
				<th>Address</th>
				<th>Phone</th>
				<th>Operation</th>
			</tr>
			<%
				ArrayList<BranchDto> al = new BranchDao().getAllBranches();
				if (al != null) {
					int s = 0;
					for (BranchDto dto : al) {
			%>
			<tr>
				<td><%=++s%></td>
				<td><%=dto.getName()%></td>
				<td><%=dto.getCity()%></td>
				<td><%=dto.getAddress()%></td>
				<td><%=dto.getPhone()%></td>
				<td>
				<a href="updateBranch.jsp?bid=<%=dto.getBid() %>">Edit</a>
				<a href="deleteBranch.jsp?bid=<%=dto.getBid() %>">Delete</a> 
				
				</td>
			</tr>
			<%
				}
				} else {
					response.sendRedirect("addBranch.jsp");
				}
			%>
		</table>
	</div>
</body>
</html>