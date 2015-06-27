package com.affixus.pojo.auth;

import java.util.Set;

import com.affixus.pojo.BasePojo;

public class Role extends BasePojo {

	private static final long serialVersionUID = 1L;
	
	private String _id;
	private String name;
	private Set<String> accessList;
	
	public String get_id() {
		return _id;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String roleName) {
		this.name = roleName;
	}
	public Set<String> getAccessList() {
		return accessList;
	}
	public void setAccessList(Set<String> accessList) {
		this.accessList = accessList;
	}	

}
