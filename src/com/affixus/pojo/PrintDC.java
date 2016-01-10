package com.affixus.pojo;

import java.util.List;

import com.affixus.util.Config;

public class PrintDC {
	private DC dc;
	private String swName;
	private String amountInWords;
	private String vattin;
	private String cstno;
	private String address;
	private String disclaimer;
	private double gross;
	private double grandTotal;
	private List<String> totalProcessesAvail;
	
	public DC getDc() {
		return dc;
	}
	public void setDc(DC dc) {
		this.dc = dc;
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
	public double getGross() {
		return gross;
	}
	public void setGross(double gross) {
		this.gross = gross;
	}
	public List<String> getTotalProcessesAvail() {
		return totalProcessesAvail;
	}
	public void setTotalProcessesAvail(List<String> totalProcessesAvail) {
		this.totalProcessesAvail = totalProcessesAvail;
	}
	public double getGrandTotal() {
		return grandTotal;
	}
	public void setGrandTotal(double grandTotal) {
		this.grandTotal = grandTotal;
	}
	
}
