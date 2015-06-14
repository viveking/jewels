package com.affixus.pojo;

import java.util.Date;

public class Platform extends BasePojo{

	private static final long serialVersionUID = 1L;
	
	private String _id;
	private String platformNumber;
	private String printer;
	private Date orderFromDate;
	private Date orderToDate;
	private String platformPreparedBy;
	private String platformPrintedBy;
	
	public String get_id() {
		return _id;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
	public String getPlatformNumber() {
		return platformNumber;
	}
	public void setPlatformNumber(String platformNumber) {
		this.platformNumber = platformNumber;
	}
	public String getPrinter() {
		return printer;
	}
	public void setPrinter(String printer) {
		this.printer = printer;
	}
	public Date getOrderFromDate() {
		return orderFromDate;
	}
	public void setOrderFromDate(Date orderFromDate) {
		this.orderFromDate = orderFromDate;
	}
	public Date getOrderToDate() {
		return orderToDate;
	}
	public void setOrderToDate(Date orderToDate) {
		this.orderToDate = orderToDate;
	}
	public String getPlatformPreparedBy() {
		return platformPreparedBy;
	}
	public void setPlatformPreparedBy(String platformPreparedBy) {
		this.platformPreparedBy = platformPreparedBy;
	}
	public String getPlatformPrintedBy() {
		return platformPrintedBy;
	}
	public void setPlatformPrintedBy(String platformPrintedBy) {
		this.platformPrintedBy = platformPrintedBy;
	}
}
