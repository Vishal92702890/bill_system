<%@page import="com.kulchuri.bill.branch.BranchDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.kulchuri.bill.accountant.AccountantDao"%>
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
	<jsp:useBean id="dto"
		class="com.kulchuri.bill.accountant.AccountantDto"></jsp:useBean>
	<jsp:setProperty property="*" name="dto" />
	<%
		if (new AccountantDao().addAccountant(dto)) {
				response.sendRedirect("viewAllAccountants.jsp");
			} else {
				out.print("failed");
			}
		}
	%>
	<div style="width: 50%; margin-left: 25%">
		<form action="addAccountant.jsp" method="post">
			<input class="field" type="text" name="name" placeholder="Enter name"
				autofocus="" required=""> <input class="field" type="text"
				name="uname" placeholder="Enter user name" required=""> <input
				class="field" type="password" name="pwd"
				placeholder="Enter password" required=""> <input
				class="field" type="text" name="mno"
				placeholder="Enter mobile number" required=""> <input
				class="field" type="text" name="email" placeholder="Enter email"
				required=""> <input class="field" type="text" name="address"
				placeholder="Enter address" required=""> <input
				class="field" type="text" name="salary" placeholder="Enter salary"
				required=""> <input type="radio" name="gender" value="Male">Male
			<input type="radio" name="gender" value="Female">Female <select
				class="field" name="bid" required="">
				<option value="">--Select Branch--</option>
				<%
					ArrayList<BranchDto> al = new BranchDao().getAllBranches();
					if (al != null) {
						for (BranchDto bd : al) {
				%>
				<option value="<%=bd.getBid()%>"><%=bd.getName()%></option>
				<%
					}
					} else {
						response.sendRedirect("addBranch.jsp");
					}
				%>
			</select> <input type="submit" value="Add">
		</form>
	</div>
</body>
</html>