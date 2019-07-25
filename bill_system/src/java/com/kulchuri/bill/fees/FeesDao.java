package com.kulchuri.bill.fees;

import com.kulchuri.bill.db.BillDb;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class FeesDao {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public ArrayList<FeesDto> getAllFeeses(int sid) {
        ArrayList<FeesDto> al = new ArrayList<>();
        if (conn == null) {
            conn = BillDb.getBillDb();
        }
        try {
            ps = conn.prepareStatement("select *from fees_master where sid=?");
            ps.setInt(1, sid);
            rs = ps.executeQuery();
            FeesDto fd;
            while (rs.next()) {
                fd = new FeesDto();
                fd.setFid(rs.getInt("fid"));
                fd.setDate(rs.getString("date"));
                fd.setPaid(rs.getFloat("paid"));
                fd.setBalance(rs.getFloat("balance"));
                al.add(fd);
            }
        } catch (Exception e) {
            System.out.println("Exception at getFeeses():" + e);
        } finally {
            rs = null;
            ps = null;
            conn = null;
            return al;
        }
    }
}
