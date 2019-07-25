
<%
	String uname = (String) session.getAttribute("uname");
	if (uname == null) {
		response.sendRedirect("login.jsp");
	}
%>

<ul>
	<li><a href="admin_home.jsp">Home</a></li>
	<li><a href="addBranch.jsp">Add Branch</a></li>
	<li><a href="viewAllBranches.jsp">All Branches</a></li>
	<li><a href="addCourse.jsp">Add Course</a></li>
	<li><a href="viewAllCourses.jsp">All Courses</a></li>
	<li><a href="addAccountant.jsp">Add Accountant</a></li>
	<li><a href="viewAllAccountants.jsp">View All Accountants</a></li>
        <li><a href="admin_viewStudents.jsp">Students</a></li>
	<li><a href="logout.jsp">SignOut</a></li>






</ul>