package com.affixus.pojo;

import java.util.Date;
import java.util.List;

public class DC extends BasePojo{
	
	private static final long serialVersionUID = 1L;
	
	private String _id;
	private Client client;
	private List<String> orderIdList;
	private List<Order> orderList;
	private String dcNumber;
	private Date dcCreationDate;
	private String dcCreationDateStr;
	
	private final String DC_STRING = "DC";
	
	public String get_id() {
		return _id;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
	public Client getClient() {
		return client;
	}
	public void setClient(Client client) {
		this.client = client;
	}
	public List<String> getOrderIdList() {
		return orderIdList;
	}
	public void setOrderIdList(List<String> orderIdList) {
		this.orderIdList = orderIdList;
	}
	public List<Order> getOrderList() {
		return orderList;
	}
	public void setOrderList(List<Order> orderList) {
		this.orderList = orderList;
	}
	public String getDcNumber() {
		return dcNumber;
	}
	public void setDcNumber(String dcNumber) {
		this.dcNumber = dcNumber;
	}
	public String generateDCNumber(){
		String numberFormat = String.format("%05d", Integer.parseInt(this.get_id()));
		return DC_STRING+ numberFormat;
	}
	public Date getDcCreationDate() {
		return dcCreationDate;
	}
	public void setDcCreationDate(Date dcCreationDate) {
		this.dcCreationDate = dcCreationDate;
	}
	public String getDcCreationDateStr() {
		return dcCreationDateStr;
	}
	public void setDcCreationDateStr(String dcCreationDateStr) {
		this.dcCreationDateStr = dcCreationDateStr;
	}
	
}
