package com.affixus.pojo;

import java.io.Serializable;

public class RateList implements Serializable {

	private static final long serialVersionUID = 1L;

	private String _id;
	private String fromVal;
	private String toVal;
	private String rateVal;
	
	public String getRateVal() {
		return rateVal;
	}
	public void setRateVal(String rateVal) {
		this.rateVal = rateVal;
	}
	public String get_id() {
		return _id;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
	public String getFromVal() {
		return fromVal;
	}
	public void setFromVal(String fromVal) {
		this.fromVal = fromVal;
	}
	public String getToVal() {
		return toVal;
	}
	public void setToVal(String toVal) {
		this.toVal = toVal;
	}
	
	
}
