package com.kulchuri.bill.login;

import com.kulchuri.bill.db.BillDb;
import com.kulchuri.bill.utility.BillPassword;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDao {

    private PreparedStatement ps = null;
    private Connection conn = null;
    private ResultSet rs = null;

    public String checkUser(LoginDto ld) {
        String type = null;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            ps = conn.prepareStatement("select type from login_master where uname=? and pwd=?");
            ps.setString(1, ld.getUname());
            ps.setString(2, BillPassword.encrypt(ld.getPwd()));
            rs = ps.executeQuery();
            if (rs.next()) {
                type = rs.getString("type");
            }
        } catch (Exception e) {
            System.out.println("Exception at checkUser():" + e);
        } finally {
            rs = null;
            conn = null;
            return type;
        }
    }

    public boolean updatePwd(LoginDto ld) {
        boolean flag = false;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            ps = conn.prepareStatement("update login_master set pwd=? where uname=?");
            ps.setString(1, BillPassword.encrypt(ld.getPwd()));
            ps.setString(2, ld.getUname());
//            ps.setString(3, ld.getType());
            if (ps.executeUpdate() > 0) {
                flag = true;
            }
        } catch (Exception e) {
            System.out.println("Exception at updatePwd():" + e);
        } finally {
            ps = null;
            conn = null;
            return flag;
        }
    }

    public boolean addLogin(String uname, String pwd, String type) {
        boolean flag = false;
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            ps = conn.prepareStatement("insert into login_master( pwd,uname,type) values(?,?,?)");
            ps.setString(1, BillPassword.encrypt(pwd));
            ps.setString(2, uname);
            ps.setString(3, type);
            if (ps.executeUpdate() > 0) {
                flag = true;
            }
        } catch (Exception e) {
            System.out.println("Exception at addLogin():" + e);
        } finally {
            ps = null;
            conn = null;
            return flag;
        }
    }

    public static void main(String[] args) {
        LoginDto ld = new LoginDto();
        ld.setPwd("admin");
        ld.setUname("admin");
        ld.setType("admin");
        System.out.println(new LoginDao().updatePwd(ld));
    }
}
