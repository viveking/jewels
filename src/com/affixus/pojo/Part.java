package com.affixus.pojo;

import java.io.Serializable;

import com.affixus.util.Constants;

public class Part implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String name;
	private String status = Constants.PartsStatus.INPROGRESS.toString();
	private String platFormNumber;
	private double weight;
	private double refWeight;
	
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
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	public double getRefWeight() {
		return refWeight;
	}
	public void setRefWeight(double refWeight) {
		this.refWeight = refWeight;
	}

}
