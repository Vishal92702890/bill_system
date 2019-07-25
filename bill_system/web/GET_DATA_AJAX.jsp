<%@page import="com.kulchuri.bill.student.StudentDao"%>
<%@page import="com.kulchuri.bill.student.StudentDto"%>
<%@page import="com.kulchuri.bill.course.CourseDao"%>
<%@page import="com.kulchuri.bill.course.CourseDto"%>
<%@page import="java.util.ArrayList"%>
<%
    String bid = request.getParameter("bid");
    String cid = request.getParameter("cid");
    String opn = request.getParameter("opn");
    if (bid != null && opn != null && opn.equalsIgnoreCase("course")) {
        ArrayList<CourseDto> al = new CourseDao().getAllCoursesByBranch(Integer.parseInt(bid));
        if (al != null) {
            for (CourseDto cd : al) {
                out.println("<option value=" + cd.getCid() + ">" + cd.getName() + "</option>");
            }
        } else {

        }
    }
    if (cid != null && opn != null && opn.equalsIgnoreCase("students")) {
        ArrayList<StudentDto> list = new StudentDao().getAllStudentsCourse(cid);
        if (list != null) {
            int s = 0;
            for (StudentDto dto : list) {
                ++s;
                out.println("<tr>");
                out.println("<td>" + s + "</td>");
                out.println("<td>" + dto.getName() + "</td>");
                out.println("<td>" + dto.getEmail() + "</td>");
                out.println("<td>" + dto.getMno() + "</td>");
                out.println("<td>" + dto.getGender() + "</td>");
                out.println("<td>" + dto.getDoj() + "</td>");
                out.println("<td>" + dto.getAddress() + "</td>");
                out.println("</tr>");
            }
        }
    }
%>
