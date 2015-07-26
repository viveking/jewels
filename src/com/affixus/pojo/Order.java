package com.affixus.pojo;

import java.util.Date;
import java.util.Set;

import com.affixus.util.Constants;

public class Order extends BasePojo {

	private static final long serialVersionUID = 1L;
	
	private String _id;
	private Client client;
	private String orderName;
	private Date orderDate;
	private String orderDateStr;
	private Set<Part> partList;
	private String status = Constants.PartsStatus.INPROGRESS.toString();
	private String printer;
	private Process cad;
	private Process cam;
	private Process rm;
	private Process cast;
	private String t_charges;
	private double camGrams;
	
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
		this.printer = printer;
	}
	public String getOrderDateStr() {
		return orderDateStr;
	}
	public void setOrderDateStr(String orderDateStr) {
		this.orderDateStr = orderDateStr;
	}
	public Process getCad() {
		return cad;
	}
	public void setCad(Process cad) {
		this.cad = cad;
	}
	public Process getCam() {
		return cam;
	}
	public void setCam(Process cam) {
		this.cam = cam;
	}
	public Process getRm() {
		return rm;
	}
	public void setRm(Process rm) {
		this.rm = rm;
	}
	public Process getCast() {
		return cast;
	}
	public void setCast(Process cast) {
		this.cast = cast;
	}
	public String getT_charges() {
		return t_charges;
	}
	public void setT_charges(String t_charges) {
		this.t_charges = t_charges;
	}
	public double getCamGrams() {
		return camGrams;
	}
	public void setCamGrams(double camGrams) {
		this.camGrams = camGrams;
	}
	
}
