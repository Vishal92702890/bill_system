<%@page import="com.kulchuri.bill.accountant.AccountantDto"%>
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
		window.location.replace("viewAllAccountants.jsp?bid=" + bid);
	}
</script>
</head>
<body>
	<%@ include file="main_header.jsp"%>
	<%@ include file="admin_menu.jsp"%>
<jsp:useBean id="adao" class="com.kulchuri.bill.accountant.AccountantDao"></jsp:useBean>
<jsp:useBean id="bdao" class="com.kulchuri.bill.branch.BranchDao"></jsp:useBean>
	
	<center>
		<table>
			<tr>
				<td><select onchange="getCourses()" id="bid" class="field"
					name="bid">
						<%
							String name = null;
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
		<h1>All Accountants</h1>
	</center>
	<div id="customers">
		<table style="width: 100%">
			<tr>
				<th>S.No.</th>
				<th>Name</th>
				<th>User Name</th>
				<th>Email</th>
				<th>M.No</th>
				<th>Gender</th>
				<th>Address</th>
				<th>D.O.J</th>
				<th>Operation</th>
			</tr>
			<%
				ArrayList<AccountantDto> al = null;
				String aid = request.getParameter("aid");
				if (aid != null) {
					adao.deleteAccountant(Integer.parseInt(aid));
				}

				if (bid != null) {
					al = adao.getAllAccountantsByBranch(Integer.parseInt(bid));
				} else {
					al = adao.getAllAccountants();
				}
				if (al != null) {
					int s = 0;
					for (AccountantDto dto : al) {
			%>
			<tr>
				<td><%=++s%></td>
				<td><%=dto.getName()%></td>
				<td><%=dto.getUname()%></td>
				<td><%=dto.getEmail()%></td>
				<td><%=dto.getMno()%></td>
				<td><%=dto.getGender()%></td>
				<td><%=dto.getAddress()%></td>
				<td><%=dto.getDoj()%></td>
				<td><a href="updateAccountant.jsp?aid=<%=dto.getAid()%>">Edit</a>
					<a href="viewAllAccountants.jsp?aid=<%=dto.getAid()%>">Delete</a></td>
			</tr>
			<%
				}
				} else {
					response.sendRedirect("addAccountant.jsp");
				}
			%>
		</table>
	</div>
</body>
</html>