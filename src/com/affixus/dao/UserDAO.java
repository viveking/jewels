package com.affixus.dao;

import java.util.Set;

import com.affixus.pojo.auth.AccessUser;

public interface UserDAO {
	public AccessUser auth(String username, String password);
	public AccessUser getByUsername(String username);
	public AccessUser get(String _id);
	public Boolean register(AccessUser user);
	public Set<AccessUser> getAll();
}
