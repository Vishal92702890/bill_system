package com.kulchuri.bill.student;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Base64;
import com.kulchuri.bill.course.CourseDao;
import com.kulchuri.bill.db.BillDb;
import com.kulchuri.bill.utility.BillDate;

public class StudentDao {

    private PreparedStatement ps = null;
    private ResultSet rs = null;
    private Connection conn = null;

    public boolean addStudent(StudentDto dto, InputStream photo) {
        boolean flag = false;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            String sql = "insert into student_master(bid,cid,name,email,mno,"
                    + "gender,address,photo,doj) values(?,?,?,?,?,?,?,?,?)";
            ps = conn.prepareStatement(sql);
            float fees = new CourseDao().getFees(dto.getCid());
            float balance = fees - dto.getPaid();
            ps.setInt(1, dto.getBid());
            ps.setInt(2, dto.getCid());
            ps.setString(3, dto.getName());
            ps.setString(4, dto.getEmail());
            ps.setString(5, dto.getMno());
            ps.setString(6, dto.getGender());
            ps.setString(7, dto.getAddress());
            ps.setBlob(8, photo);
            ps.setString(9, BillDate.getCurrentDate());
            if (ps.executeUpdate() > 0) {
                flag = true;
                rs = conn.prepareStatement("SELECT max(sid) as sid FROM student_master").executeQuery();
            }
            if (rs.next()) {
                addFees(dto.getPaid(), balance, rs.getInt("sid"));
            }
        } catch (Exception e) {
            System.out.println("Exception at addStudent():" + e);
        } finally {
            ps = null;
            conn = null;
            return flag;
        }
    }

    public boolean addFees(float paid, float balance, int sid) {
        boolean flag = false;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            ps = conn.prepareStatement("insert into fees_master(paid, balance, date, sid) values(?,?,?,?)");
            ps.setFloat(1, paid);
            ps.setFloat(2, balance);
            ps.setString(3, BillDate.getCurrentDate());
            ps.setInt(4, sid);
            if (ps.executeUpdate() > 0) {
                flag = true;
            }
        } catch (Exception e) {
            System.out.println("Exception at addFees():" + e);
        } finally {
            ps = null;
            conn = null;
            return flag;
        }
    }

    public float getBalance(int sid) {
        float balance = 0;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            ps = conn.prepareStatement("select min(balance) as balance from fees_master where sid=?");
            ps.setInt(1, sid);
            rs = ps.executeQuery();
            if (rs.next()) {
                balance = rs.getFloat("balance");
            }
        } catch (Exception e) {
            System.out.println("Exception at getBalance():" + e);
        } finally {
            rs = null;
            ps = null;
            conn = null;
            return balance;
        }
    }

    public ArrayList<StudentDto> getAllStudents() {
        ArrayList<StudentDto> list = new ArrayList<>();
        StudentDto dto = null;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            ps = conn.prepareStatement("select sm.*, fm.balance from student_master sm,fees_master fm where fm.sid=sm.sid");
            rs = ps.executeQuery();
            while (rs.next()) {
                dto = new StudentDto();
                dto.setSid(rs.getInt("sid"));
                dto.setAddress(rs.getString("address"));
                dto.setName(rs.getString("name"));
                dto.setEmail(rs.getString("email"));
                dto.setGender(rs.getString("gender"));
                dto.setMno(rs.getString("mno"));
                dto.setDoj(rs.getString("doj"));
                dto.setBalance(rs.getFloat("balance"));
                dto.setPhoto(Base64.getEncoder().encodeToString(rs.getBytes("photo")));
                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("Exception at getAllStudents():" + e);
        } finally {
            if (list.isEmpty()) {
                list = null;
            }
            ps = null;
            rs = null;
            conn = null;
            return list;
        }
    }

    public ArrayList<StudentDto> getAllStudentsByAccountant(String uname) {
        ArrayList<StudentDto> list = new ArrayList<>();
        int bid = getBranchId(uname);
        StudentDto dto = null;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            ps = conn.prepareStatement("select sm.*, min(fm.balance) as balance from student_master sm,fees_master fm where fm.sid=sm.sid and bid=? group by sm.sid");
            ps.setInt(1, bid);
            rs = ps.executeQuery();
            while (rs.next()) {
                dto = new StudentDto();
                dto.setSid(rs.getInt("sid"));
                dto.setAddress(rs.getString("address"));
                dto.setName(rs.getString("name"));
                dto.setEmail(rs.getString("email"));
                dto.setGender(rs.getString("gender"));
                dto.setMno(rs.getString("mno"));
                dto.setDoj(rs.getString("doj"));
                dto.setBalance(rs.getFloat("balance"));
                dto.setPhoto(Base64.getEncoder().encodeToString(rs.getBytes("photo")));
                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("Exception at getAllStudents():" + e);
        } finally {
            if (list.isEmpty()) {
                list = null;
            }
            ps = null;
            rs = null;
            conn = null;
            return list;
        }
    }

    public ArrayList<StudentDto> getAllStudentsByBranchAndCourse(String uname, String cid) {
        ArrayList<StudentDto> list = new ArrayList<>();
        int bid = getBranchId(uname);
        StudentDto dto = null;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            ps = conn.prepareStatement("select sm.*, min(fm.balance) as balance from student_master sm,fees_master fm where fm.sid=sm.sid and bid=? and cid=? group by sm.sid");
            ps.setInt(1, bid);
            ps.setInt(2, Integer.parseInt(cid));
            rs = ps.executeQuery();
            while (rs.next()) {
                dto = new StudentDto();
                dto.setSid(rs.getInt("sid"));
                dto.setAddress(rs.getString("address"));
                dto.setName(rs.getString("name"));
                dto.setEmail(rs.getString("email"));
                dto.setGender(rs.getString("gender"));
                dto.setMno(rs.getString("mno"));
                dto.setDoj(rs.getString("doj"));
                dto.setBalance(rs.getFloat("balance"));
                dto.setPhoto(Base64.getEncoder().encodeToString(rs.getBytes("photo")));
                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("Exception at getAllStudents():" + e);
        } finally {
            if (list.isEmpty()) {
                list = null;
            }
            ps = null;
            rs = null;
            conn = null;
            return list;
        }
    }

    public ArrayList<StudentDto> getAllStudentsCourse(String cid) {
        ArrayList<StudentDto> list = new ArrayList<>();
        StudentDto dto = null;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            ps = conn.prepareStatement("SELECT * FROM student_master where cid=?");
            ps.setInt(1, Integer.parseInt(cid));
            rs = ps.executeQuery();
            while (rs.next()) {
                dto = new StudentDto();
                dto.setSid(rs.getInt("sid"));
                dto.setAddress(rs.getString("address"));
                dto.setName(rs.getString("name"));
                dto.setEmail(rs.getString("email"));
                dto.setGender(rs.getString("gender"));
                dto.setMno(rs.getString("mno"));
                dto.setDoj(rs.getString("doj"));
                dto.setPhoto(Base64.getEncoder().encodeToString(rs.getBytes("photo")));
                list.add(dto);
            }
        } catch (Exception e) {
            System.out.println("Exception at getAllStudents():" + e);
        } finally {
            if (list.isEmpty()) {
                list = null;
            }
            ps = null;
            rs = null;
            conn = null;
            return list;
        }
    }

    public int getBranchId(String uname) {
        int bid = 0;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            ps = conn.prepareStatement("select bid from accountant_master where uname=?");
            ps.setString(1, uname);
            rs = ps.executeQuery();
            if (rs.next()) {
                bid = rs.getInt("bid");
            }
        } catch (Exception e) {
            System.out.println("Exception at getBranchId():" + e);
        } finally {
            rs = null;
            ps = null;
            conn = null;
            return bid;
        }
    }

    public static void main(String[] args) {
        System.out.println(new StudentDao().getBranchId("sonam@gmail.com"));
    }
}
