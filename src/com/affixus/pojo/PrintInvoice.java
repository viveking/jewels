package com.affixus.pojo;

import com.affixus.util.Config;

public class PrintInvoice {

	private Invoice invoice;
	private String swName;
	private String amountInWords;
	private String vattin;
	private String cstno;
	private String address;
	private String disclaimer;
	private String taxString;
	
	private double gross;
	private double taxAmount;
	private double grandTotal;
	
	public Invoice getInvoice() {
		return invoice;
	}
	public void setInvoice(Invoice invoice) {
		this.invoice = invoice;
	}
	public String getSwName() {
		return Config.getProperty("client.name");
	}
	/*public void setSwName(String swName) {
		this.swName = swName;
	}*/
	public String getAmountInWords() {
		return amountInWords;
	}
	public void setAmountInWords(String amountInWords) {
		this.amountInWords = amountInWords;
	}
	public String getVattin() {
		return Config.getProperty("invoice.vattin");
	}
	/*public void setVattin(String vattin) {
		this.vattin = vattin;
	}*/
	public String getCstno() {
		return Config.getProperty("invoice.cstno");
	}
	/*public void setCstno(String cstno) {
		this.cstno = cstno;
	}*/
	public String getAddress() {
		return Config.getProperty("invoice.address");
	}
	/*public void setAddress(String address) {
		this.address = address;
	}*/
	public String getDisclaimer() {
		return Config.getProperty("invoice.disclaimer");
	}
	/*public void setDisclaimer(String disclaimer) {
		this.disclaimer = disclaimer;
	}*/
	public String getTaxString() {
		return taxString;
	}
	public void setTaxString(String taxString) {
		this.taxString = taxString;
	}
	public double getGross() {
		return gross;
	}
	public void setGross(double gross) {
		this.gross = gross;
	}
	public double getTaxAmount() {
		return taxAmount;
	}
	public void setTaxAmount(double taxAmount) {
		this.taxAmount = taxAmount;
	}
	public double getGrandTotal() {
		return grandTotal;
	}
	public void setGrandTotal(double grandTotal) {
		this.grandTotal = grandTotal;
	}
	
}
