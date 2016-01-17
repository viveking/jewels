package com.affixus.dao;

import java.util.List;

import com.affixus.pojo.auth.Role;

public interface RoleDAO {
	public Role get(String _id);
	public List<Role> getAll();
	public Boolean add(Role role);
	public Boolean update(Role role);
	public Boolean delete(String _id);

	
}
