package com.kulchuri.bill.branch;

import java.io.Serializable;

public class BranchDto implements Serializable {
	private int bid;
	private String name, address, city, phone;

	public BranchDto() {
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	public static void main(String[] args) {
		int x='A';
		System.out.println(x);
		System.out.println((char)x);
	}
}
