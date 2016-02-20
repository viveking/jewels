package com.affixus.pojo;

import java.util.Date;
import java.util.List;

public class Invoice extends BasePojo{
	
	private static final long serialVersionUID = 1L;
	private String _id;
	private Client client;
	private List<String> orderIdList;
	private List<Order> orderList;
	private String invoiceNumber;
	private double discount;
	private double courierCharges;
	private double otherCharges;
	private double gatePassCharges;
	private Date invoiceCreationDate;
	private String invoiceCreationDateStr;
	private String invoiceTaxOption;
	private double rmCount;
	//private final String INVOICE_STRING = "TI";
	
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
		return gatePassCharges;
	}
	public void setGatePass(double gatePass) {
		this.gatePassCharges = gatePass;
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
	public String generateInvoiceNumber(String prefixString, String counter){
		String numberFormat = String.format("%05d", Integer.parseInt(counter));
		return prefixString + numberFormat;
	}
	public String getInvoiceTaxOption() {
		return invoiceTaxOption;
	}
	public void setInvoiceTaxOption(String invoiceTaxOption) {
		this.invoiceTaxOption = invoiceTaxOption;
	}
	public double getRmCount() {
		return rmCount;
	}
	public void setRmCount(double rmCount) {
		this.rmCount = rmCount;
	}
}
