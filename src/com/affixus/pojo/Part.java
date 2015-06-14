package com.affixus.pojo;

import java.io.Serializable;

public class Part implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String name;
	private String status;
	private String platFormNumber;
	private float weight;
	private float refWeight;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getPlatFormNumber() {
		return platFormNumber;
	}
	public void setPlatFormNumber(String platFormNumber) {
		this.platFormNumber = platFormNumber;
	}
	public float getWeight() {
		return weight;
	}
	public void setWeight(float weight) {
		this.weight = weight;
	}
	public float getRefWeight() {
		return refWeight;
	}
	public void setRefWeight(float refWeight) {
		this.refWeight = refWeight;
	}

}
