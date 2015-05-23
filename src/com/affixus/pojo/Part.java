package com.affixus.pojo;

import java.io.Serializable;

public class Part implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String name;
	private String status;
	
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

}
