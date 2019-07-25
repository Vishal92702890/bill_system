package com.kulchuri.bill.course;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.kulchuri.bill.db.BillDb;

public class CourseDao {

    private PreparedStatement ps = null;
    private Connection conn = null;
    private ResultSet rs = null;

    public boolean addCourse(CourseDto dto) {
        boolean flag = false;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            String sql = "insert into course_master(name, bid, fees) values(?,?,?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, dto.getName());
            ps.setInt(2, dto.getBid());
            ps.setFloat(3, dto.getFees());

            if (ps.executeUpdate() > 0) {
                flag = true;
            }

        } catch (Exception e) {
            System.out.println("Exception at addCourse():" + e);
        } finally {
            return flag;
        }
    }

    public ArrayList<CourseDto> getAllCourses() {
        ArrayList<CourseDto> al = new ArrayList<>();
        CourseDto dto;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }

        try {
            String sql = "select cm.*, bm.name as bname from course_master cm, branch_master bm where cm.bid=bm.bid";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dto = new CourseDto();
                dto.setName(rs.getString("name"));
                dto.setBname(rs.getString("bname"));
                dto.setCid(rs.getInt("cid"));
                dto.setFees(rs.getFloat("fees"));
                al.add(dto);
            }

        } catch (Exception e) {
            System.out.println("Exception at getAllCourses:" + e);
        } finally {
            if (al.isEmpty()) {
                al = null;
            }
            rs = null;
            ps = null;
            conn = null;
            return al;
        }
    }

    public ArrayList<CourseDto> getAllCoursesByBranch(int bid) {
        ArrayList<CourseDto> al = new ArrayList<>();
        CourseDto dto;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }

        try {
            String sql = "select cm.*, bm.name as bname from course_master cm, branch_master bm where cm.bid=bm.bid and bm.bid=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, bid);
            rs = ps.executeQuery();
            while (rs.next()) {
                dto = new CourseDto();
                dto.setName(rs.getString("name"));
                dto.setBname(rs.getString("bname"));
                dto.setCid(rs.getInt("cid"));
                dto.setFees(rs.getFloat("fees"));
                al.add(dto);
            }

        } catch (Exception e) {
            System.out.println("Exception at getAllCourses:" + e);
        } finally {
            if (al.isEmpty()) {
                al = null;
            }
            rs = null;
            ps = null;
            conn = null;
            return al;
        }
    }

    public ArrayList<CourseDto> getAllCoursesByAccountant(String uname) {
        ArrayList<CourseDto> al = new ArrayList<>();
        CourseDto dto;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }

        try {
            String sql = "select cm.* from course_master cm, branch_master bm, accountant_master am where cm.bid=bm.bid and am.bid=bm.bid and am.uname=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, uname);
            rs = ps.executeQuery();
            while (rs.next()) {
                dto = new CourseDto();
                dto.setName(rs.getString("name"));
                dto.setFees(rs.getFloat("fees"));
                al.add(dto);
            }

        } catch (Exception e) {
            System.out.println("Exception at getAllCoursesByAccountant():" + e);
        } finally {
            if (al.isEmpty()) {
                al = null;
            }
            rs = null;
            ps = null;
            conn = null;
            return al;
        }
    }

    public boolean deleteCourse(int cid) {
        boolean flag = false;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            ps = conn.prepareStatement("delete from course_master where cid=?");
            ps.setInt(1, cid);
            if (ps.executeUpdate() > 0) {
                flag = true;
            }
        } catch (Exception e) {
            System.out.println("Exception at deleteCourse():" + e);
        } finally {
            ps = null;
            conn = null;
            return flag;
        }
    }

    public float getFees(int cid) {
        float fees = 0;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            String sql = "select fees from course_master where cid=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, cid);
            rs = ps.executeQuery();
            if (rs.next()) {
                fees = rs.getFloat("fees");
            }
        } catch (Exception e) {
            System.out.println("Exception at getFees():" + e);
        } finally {

            rs = null;
            ps = null;
            conn = null;
            return fees;
        }
    }

}
