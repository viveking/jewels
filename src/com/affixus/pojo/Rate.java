package com.affixus.pojo;

import java.util.List;
import java.util.Set;

public class Rate extends BasePojo{

	private static final long serialVersionUID = 1L;

	private String _id;
	private String name;
	private String description;
	private String printerType;
	private List<RateRange> rateRangeList;
	
	public String get_id() {
		return _id;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public List<RateRange> getRateRangeList() {
		return rateRangeList;
	}
	public void setRateList(List<RateRange> rateRangeList) {
		this.rateRangeList = rateRangeList;
	}
	public String getPrinterType() {
		return printerType;
	}
	public void setPrinterType(String printerType) {
		this.printerType = printerType;
	}
	
	
}
