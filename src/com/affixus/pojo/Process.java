package com.affixus.pojo;

import java.io.Serializable;

public class Process implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String name;
	private String amount;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}

}
