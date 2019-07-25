package com.kulchuri.bill.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class BillDb implements DbData {
	private static Connection conn = null;

	private BillDb() {
	}

	public static Connection getBillDb() {
		return conn;
	}

	static {
		try {
			Class.forName(DRIVER);
			conn = DriverManager.getConnection(URL, USER, PWD);
		} catch (Exception e) {
			System.out.println("Connection Failed:" + e);
		}
	}

	public static void main(String[] args) {
		System.out.println(getBillDb());
	}
}
