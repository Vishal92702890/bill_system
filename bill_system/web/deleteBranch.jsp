<%@page import="com.kulchuri.bill.branch.BranchDao"%>
<%
	String bid = request.getParameter("bid");
	if (bid != null) {
		int b = Integer.parseInt(bid);
		new BranchDao().deleteBranch(b);
		response.sendRedirect("viewAllBranches.jsp");
	} else {
		response.sendRedirect("viewAllBranches.jsp");
	}
%>