package com.affixus.pojo;

import java.util.Date;
import java.util.List;

public class DeliveryChalan extends BasePojo{
	
	private static final long serialVersionUID = 1L;
	
	private String _id;
	private Client client;
	private List<String> orderIdList;
	private List<Order> orderList;
	private String dcNumber;
	private double discount;
	private double courierCharges;
	private double otherCharges;
	private double gatePassCharges;
	private Date invoiceCreationDate;
	private String invoiceCreationDateStr;
	
	private final String DC_STRING = "DC_";
	
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
	public double getDiscount() {
		return discount;
	}
	public void setDiscount(double discount) {
		this.discount = discount;
	}
	public double getCourierCharges() {
		return courierCharges;
	}
	public void setCourierCharges(double courierCharges) {
		this.courierCharges = courierCharges;
	}
	public double getOtherCharges() {
		return otherCharges;
	}
	public void setOtherCharges(double otherCharges) {
		this.otherCharges = otherCharges;
	}
	public double getGatePassCharges() {
		return gatePassCharges;
	}
	public void setGatePassCharges(double gatePassCharges) {
		this.gatePassCharges = gatePassCharges;
	}
	public Date getInvoiceCreationDate() {
		return invoiceCreationDate;
	}
	public void setInvoiceCreationDate(Date invoiceCreationDate) {
		this.invoiceCreationDate = invoiceCreationDate;
	}
	public String getInvoiceCreationDateStr() {
		return invoiceCreationDateStr;
	}
	public void setInvoiceCreationDateStr(String invoiceCreationDateStr) {
		this.invoiceCreationDateStr = invoiceCreationDateStr;
	}
	public String generateDCNumber(){
		return DC_STRING+ this.get_id();
	}
	
}