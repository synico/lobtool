package com.sn.lobtool.domain;

public class DailySalesEntry {
	
	private String billDate;
	private int numOfBill;
	private float totalAmount;
	private int numOfCust;
	private float billPerCust;
	
	public String getBillDate() {
		return billDate;
	}
	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}
	public int getNumOfBill() {
		return numOfBill;
	}
	public void setNumOfBill(int numOfBill) {
		this.numOfBill = numOfBill;
	}
	public float getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(float totalAmount) {
		this.totalAmount = totalAmount;
	}
	public int getNumOfCust() {
		return numOfCust;
	}
	public void setNumOfCust(int numOfCust) {
		this.numOfCust = numOfCust;
	}
	public float getBillPerCust() {
		return billPerCust;
	}
	public void setBillPerCust(float billPerCust) {
		this.billPerCust = billPerCust;
	}
	
}
