package com.kg.seeot.order.dto;

import java.text.SimpleDateFormat;

public class OrderHistoryDTO {
	String hiMemberId,hiProductName,hiProductColor,hiProductFile,hiOrderAddr1,hiOrderAddr2,hiOrderDate;
	int hiOrderNo,hiProductNo,hiProductSize,hiOrderPrice,hiOrderStatus,hiProductPrice,hiOrderStack;
	public String getHiMemberId() {
		return hiMemberId;
	}
	public void setHiMemberId(String hiMemberId) {
		this.hiMemberId = hiMemberId;
	}
	public String getHiProductName() {
		return hiProductName;
	}
	public void setHiProductName(String hiProductName) {
		this.hiProductName = hiProductName;
	}
	public String getHiProductColor() {
		return hiProductColor;
	}
	public void setHiProductColor(String hiProductColor) {
		this.hiProductColor = hiProductColor;
	}
	public String getHiProductFile() {
		return hiProductFile;
	}
	public void setHiProductFile(String hiProductFile) {
		this.hiProductFile = hiProductFile;
	}
	public String getHiOrderAddr1() {
		return hiOrderAddr1;
	}
	public void setHiOrderAddr1(String hiOrderAddr1) {
		this.hiOrderAddr1 = hiOrderAddr1;
	}
	public String getHiOrderAddr2() {
		return hiOrderAddr2;
	}
	public void setHiOrderAddr2(String hiOrderAddr2) {
		this.hiOrderAddr2 = hiOrderAddr2;
	}
	public String getHiOrderDate() {
		return hiOrderDate;
	}
	public void setHiOrderDate(String hiOrderDate) {
		SimpleDateFormat s = new SimpleDateFormat("YYYY/MM/dd HH:mm:ss");
		this.hiOrderDate = s.format(hiOrderDate);
	}
	public int getHiOrderNo() {
		return hiOrderNo;
	}
	public void setHiOrderNo(int hiOrderNo) {
		this.hiOrderNo = hiOrderNo;
	}
	public int getHiProductNo() {
		return hiProductNo;
	}
	public void setHiProductNo(int hiProductNo) {
		this.hiProductNo = hiProductNo;
	}
	public int getHiProductSize() {
		return hiProductSize;
	}
	public void setHiProductSize(int hiProductSize) {
		this.hiProductSize = hiProductSize;
	}
	public int getHiOrderPrice() {
		return hiOrderPrice;
	}
	public void setHiOrderPrice(int hiOrderPrice) {
		this.hiOrderPrice = hiOrderPrice;
	}
	public int getHiOrderStatus() {
		return hiOrderStatus;
	}
	public void setHiOrderStatus(int hiOrderStatus) {
		this.hiOrderStatus = hiOrderStatus;
	}
	public int getHiProductPrice() {
		return hiProductPrice;
	}
	public void setHiProductPrice(int hiProductPrice) {
		this.hiProductPrice = hiProductPrice;
	}
	public int getHiOrderStack() {
		return hiOrderStack;
	}
	public void setHiOrderStack(int hiOrderStack) {
		this.hiOrderStack = hiOrderStack;
	}
	
	
}