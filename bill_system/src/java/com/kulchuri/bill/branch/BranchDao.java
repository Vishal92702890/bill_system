package com.kulchuri.bill.branch;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.kulchuri.bill.db.BillDb;

public class BranchDao {
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	public BranchDao() {
	}

	public boolean addBranch(BranchDto dto) {
		boolean flag = false;
		if (conn == null) {
			conn = BillDb.getBillDb();
		}
		try {
			String sql = "insert into branch_master(name, address, city, phone) values(?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getName());
			ps.setString(2, dto.getAddress());
			ps.setString(3, dto.getCity());
			ps.setString(4, dto.getPhone());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception at addBranch():" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public boolean updateBranch(BranchDto dto) {
		boolean flag = false;
		if (conn == null) {
			conn = BillDb.getBillDb();
		}
		try {
			String sql = "update branch_master set name=?, address=?, city=?, phone=? where bid=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getName());
			ps.setString(2, dto.getAddress());
			ps.setString(3, dto.getCity());
			ps.setString(4, dto.getPhone());
			ps.setInt(5, dto.getBid());
			if (ps.executeUpdate() > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("Exception at updateBranch():" + e);
		} finally {
			ps = null;
			conn = null;
			return flag;
		}
	}

	public ArrayList<BranchDto> getAllBranches() {
		ArrayList<BranchDto> list = new ArrayList<>();
		if (conn == null) {
			conn = BillDb.getBillDb();
		}
		try {
			String sql = "select *from branch_master";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			BranchDto dto;
			while (rs.next()) {
				dto = new BranchDto();
				dto.setBid(rs.getInt("bid"));
				dto.setName(rs.getString("name"));
				dto.setAddress(rs.getString("address"));
				dto.setPhone(rs.getString("phone"));
				dto.setCity(rs.getString("city"));
				list.add(dto);
			}

		} catch (Exception e) {
			System.out.println("Exception at getAllBranches:" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			if (list.isEmpty()) {
				list = null;
			}
			return list;
		}
	}

	public BranchDto getBranch(int bid) {
		BranchDto dto = null;
		if (conn == null) {
			conn = BillDb.getBillDb();
		}
		try {
			String sql = "select *from branch_master where bid=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bid);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new BranchDto();
				dto.setBid(rs.getInt("bid"));
				dto.setName(rs.getString("name"));
				dto.setAddress(rs.getString("address"));
				dto.setPhone(rs.getString("phone"));
				dto.setCity(rs.getString("city"));
			}
		} catch (Exception e) {
			System.out.println("Exception at getBranch:" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return dto;
		}
	}

	public String getBranchName(int bid) {
		String name = null;
		if (conn == null) {
			conn = BillDb.getBillDb();
		}
		try {
			String sql = "select name from branch_master where bid=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bid);
			rs = ps.executeQuery();
			if (rs.next()) {
				name = rs.getString("name");
			}
		} catch (Exception e) {
			System.out.println("Exception at getBranchName():" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return name;
		}
	}

	public boolean deleteBranch(int bid) {
		boolean flag = false;
		if (conn == null) {
			conn = BillDb.getBillDb();
		}
		try {
			String sql = "delete from branch_master where bid=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bid);
			if (ps.executeUpdate() > 0) {
				flag = true;
			}

		} catch (Exception e) {
			System.out.println("Exception at deleteBranch:" + e);
		} finally {
			rs = null;
			ps = null;
			conn = null;
			return flag;
		}
	}
}
