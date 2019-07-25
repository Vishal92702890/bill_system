<%@page import="com.kulchuri.bill.branch.BranchDto"%>
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
	<jsp:useBean id="dto" class="com.kulchuri.bill.branch.BranchDto"></jsp:useBean>
	<jsp:setProperty property="*" name="dto" />
	<%
		if (new BranchDao().updateBranch(dto)) {
				response.sendRedirect("viewAllBranches.jsp");
			} else {
				out.print("failed");
			}
		}
		String bid = request.getParameter("bid");
		if (bid != null) {
			int b = Integer.parseInt(bid);
			BranchDto branchDto = new BranchDao().getBranch(b);
			if(branchDto!=null){
	%>
	<div style="width: 50%; margin-left: 25%">
		<form action="updateBranch.jsp" method="post">
			<input type="hidden" name="bid" value="<%=bid%>">
			<input class="field" type="text" value="<%=branchDto.getName() %>"  name="name" placeholder="Enter name"
				required="" autofocus=""> 
			<input class="field" value="<%=branchDto.getCity() %>" type="text"
				name="city" placeholder="Enter city" required=""> <input
				class="field" type="text" name="address" value="<%=branchDto.getAddress() %>" placeholder="Enter address"
				required=""> 
			<input class="field" type="text" value="<%=branchDto.getPhone() %>" name="phone"
				placeholder="Enter phone" required=""> 
			<input type="submit" value="update">
		</form>
	</div>
	<%}else{
		response.sendRedirect("viewAllBranches.jsp");
	}
		}
	%>
</body>
</html>