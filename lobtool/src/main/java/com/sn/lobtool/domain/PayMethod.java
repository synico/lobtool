package com.sn.lobtool.domain;

import java.sql.Date;

public class PayMethod {
	
	private String payMethodId;	
	private String code;	
	private String Name;
	private int isSystem;
	private int isMobile;
	private int isHaveChange;
	private int isDisabled;
	private String checkEntry;
	private int isHasNominalValue;
	private double nominalValue;
	private int isDelete;
	private Date deleteTime;
	
	public String getPayMethodId() {
		return payMethodId;
	}
	public void setPayMethodId(String payMethodId) {
		this.payMethodId = payMethodId;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public int getIsSystem() {
		return isSystem;
	}
	public void setIsSystem(int isSystem) {
		this.isSystem = isSystem;
	}
	public int getIsMobile() {
		return isMobile;
	}
	public void setIsMobile(int isMobile) {
		this.isMobile = isMobile;
	}
	public int getIsHaveChange() {
		return isHaveChange;
	}
	public void setIsHaveChange(int isHaveChange) {
		this.isHaveChange = isHaveChange;
	}
	public int getIsDisabled() {
		return isDisabled;
	}
	public void setIsDisabled(int isDisabled) {
		this.isDisabled = isDisabled;
	}
	public String getCheckEntry() {
		return checkEntry;
	}
	public void setCheckEntry(String checkEntry) {
		this.checkEntry = checkEntry;
	}
	public int getIsHasNominalValue() {
		return isHasNominalValue;
	}
	public void setIsHasNominalValue(int isHasNominalValue) {
		this.isHasNominalValue = isHasNominalValue;
	}
	public double getNominalValue() {
		return nominalValue;
	}
	public void setNominalValue(double nominalValue) {
		this.nominalValue = nominalValue;
	}
	public int getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(int isDelete) {
		this.isDelete = isDelete;
	}
	public Date getDeleteTime() {
		return deleteTime;
	}
	public void setDeleteTime(Date deleteTime) {
		this.deleteTime = deleteTime;
	}
	
}
