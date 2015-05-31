package com.affixus.pojo;

import java.io.Serializable;

public class Process implements Serializable {
	
	public Process() {
		super();
	}
	
	public Process(boolean required, float amount) {
		super();
		this.required = required;
		this.amount = amount;
	}
	
	private static final long serialVersionUID = 1L;
	
	private boolean required;
	private float amount;
	
	public float getAmount() {
		return amount;
	}
	public void setAmount(float amount) {
		this.amount = amount;
	}

	public boolean isRequired() {
		return required;
	}

	public void setRequired(boolean required) {
		this.required = required;
	}

}
