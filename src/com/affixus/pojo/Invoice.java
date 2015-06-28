package com.affixus.pojo;

import java.util.List;

public class Invoice extends BasePojo{
	
	private static final long serialVersionUID = 1L;
	private String _id;
	private Client client;
	private List<Order> orders;
	private String invoiceNumber;
	private float discount;
	private float courierCharges;
	private float otherCharges;
	private float gatePass;
	
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
	public float getDiscount() {
		return discount;
	}
	public void setDiscount(float discount) {
		this.discount = discount;
	}
	public float getCourierCharges() {
		return courierCharges;
	}
	public void setCourierCharges(float courierCharges) {
		this.courierCharges = courierCharges;
	}
	public float getOtherCharges() {
		return otherCharges;
	}
	public void setOtherCharges(float otherCharges) {
		this.otherCharges = otherCharges;
	}
	public float getGatePass() {
		return gatePass;
	}
	public void setGatePass(float gatePass) {
		this.gatePass = gatePass;
	}
	
}
