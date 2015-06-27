package com.affixus.dao;

import java.util.List;

import com.affixus.pojo.auth.User;

public interface UserDAO {
	public User auth(String username, String password);
	public User getByUsername(String username);
	public User get(String _id);
	public Boolean add(User user);
	public List<User> getAll();
	
}
