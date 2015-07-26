package com.affixus.pojo;

import java.util.List;

public class Invoice extends BasePojo{
	
	private static final long serialVersionUID = 1L;
	private String _id;
	private Client client;
	private List<Order> orders;
	private String invoiceNumber;
	private double discount;
	private double courierCharges;
	private double otherCharges;
	private double gatePass;
	
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
	public List<Order> getOrders() {
		return orders;
	}
	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}
	public String getInvoiceNumber() {
		return invoiceNumber;
	}
	public void setInvoiceNumber(String invoiceNumber) {
		this.invoiceNumber = invoiceNumber;
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
	public double getGatePass() {
		return gatePass;
	}
	public void setGatePass(double gatePass) {
		this.gatePass = gatePass;
	}
	
}
