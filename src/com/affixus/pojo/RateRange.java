package com.affixus.pojo;

import java.io.Serializable;

public class RateRange implements Serializable {

	private static final long serialVersionUID = 1L;

	private String from;
	private String to;
	private double minAmount;
	private double rate;
	
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public double getRate() {
		return rate;
	}
	public void setRate(double rate) {
		this.rate = rate;
	}
	public double getMinAmount() {
		return minAmount;
	}
	public void setMinAmount(double fixedAmount) {
		this.minAmount = fixedAmount;
	}
	public boolean isToValueInfinite(){
		
		boolean flag;
		try{
			Float f = Float.parseFloat(this.getTo());
			flag = false;
		}
		catch(Exception e){
			flag = true;
		}
		return flag;
	}
	
	@Override
	public boolean equals(Object obj) {
		// TODO Auto-generated method stub
		return super.equals(obj);
	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return super.hashCode();
	}

}
