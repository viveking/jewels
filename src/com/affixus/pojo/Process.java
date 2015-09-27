package com.affixus.pojo;

import java.io.Serializable;

public class Process implements Serializable {
	
	public Process() {
		super();
	}
	
	public Process(boolean required, double amount) {
		super();
		this.required = required;
		this.amount = amount;
	}
	
	private static final long serialVersionUID = 1L;
	
	private boolean required;
	private Double amount;
	private Double weight;
	
	public double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public boolean isRequired() {
		return required;
	}

	public void setRequired(boolean required) {
		this.required = required;
	}

	public double getWeight() {
		return weight;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
	}

}
