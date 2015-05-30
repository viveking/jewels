package com.affixus.pojo;

import java.util.Date;
import java.util.Set;

public class Order extends BasePojo {

	private static final long serialVersionUID = 1L;
	
	private String _id;
	private Client client;
	private String orderName;
	private Date orderDate;
	private Set<Part> partList;
	private String status;
	private String printer;
	private Set<Process> processList;
	
	
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
	public String getOrderName() {
		return orderName;
	}
	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	
	public Set<Part> getPartList() {
		return partList;
	}
	
	public void setPartList(Set<Part> partList) {
		this.partList = partList;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getPrinter() {
		return printer;
	}
	
	public void setPrinter(String printer) {
		this.status = printer;
	}
	public Set<Process> getProcessList() {
		return processList;
	}
	public void setProcessList(Set<Process> processList) {
		this.processList = processList;
	}
	
	
	
}
