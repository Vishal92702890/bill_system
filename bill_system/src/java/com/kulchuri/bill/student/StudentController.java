package com.kulchuri.bill.student;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig(maxFileSize = 234567899)
@WebServlet(name = "StudentController", urlPatterns = {"/StudentController"})

public class StudentController extends HttpServlet {

    private static final long serialVersionUID = 8418358586824820624L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            StudentDto dto = new StudentDto();
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String gender = req.getParameter("gender");
            String mno = req.getParameter("mno");
            String address = req.getParameter("address");
            String paid = req.getParameter("paid");
            String cid = req.getParameter("cid");
            String uname=(String) req.getSession().getAttribute("uname");
            int bid=new StudentDao().getBranchId(uname);
            dto.setBid(bid);
            dto.setName(name);
            dto.setMno(mno);
            dto.setAddress(address);
            dto.setCid(Integer.parseInt(cid));
            dto.setPaid(Float.parseFloat(paid));
            dto.setGender(gender);
            dto.setEmail(email);
            InputStream photo = req.getPart("photo").getInputStream();
            if (new StudentDao().addStudent(dto, photo)) {
                resp.sendRedirect("viewAllStudents.jsp");
            } else {
                resp.sendRedirect("addStudent.jsp?msg=Registration Failed");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
