package com.affixus.services;

import java.util.List;

import com.affixus.dao.UserDAO;
import com.affixus.dao.impl.MongoUserDaoImpl;
import com.affixus.pojo.Client;
import com.affixus.pojo.auth.Role;
import com.affixus.pojo.auth.User;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

public class UserService {
	private UserDAO userDAO;
	
	public UserService(){
		Object object = ObjectFactory.getInstance(ObjectEnum.USER_DAO);
		if (object instanceof UserDAO) {
			userDAO = (MongoUserDaoImpl) object;
		}
		else{
			try {
				throw new Exception("Problem to initialise MongoUserDao");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public User auth(String username, String password){
		return userDAO.auth(username, password);
	}

	public User getByUsername(String username) {
		return userDAO.getByUsername(username);
	}
	
	public Boolean add(User user) {
		return userDAO.add(user);
	}
	
	/**
	 * Get user by _id (primary key)
	 * @param _id
	 * @return
	 */
	public User get(String _id)
	{
		return userDAO.get(_id);
	}

	public List<User> getAll() {
		return userDAO.getAll();
	}
}
