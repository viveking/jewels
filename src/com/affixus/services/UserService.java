package com.affixus.services;

import javax.accessibility.AccessibleRole;

import com.affixus.dao.UserDAO;
import com.affixus.dao.impl.MongoUserDaoImpl;
import com.affixus.pojo.auth.AccessRole;
import com.affixus.pojo.auth.AccessUser;
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
	
	public AccessUser auth(String username, String password){
		return userDAO.auth(username, password);
	}

	public AccessUser getByUsername(String username) {
		return userDAO.getByUsername(username);
	}
	
	public Boolean register(AccessUser user) {
		return userDAO.register(user);
	}
	
	/**
	 * Get user by _id (primary key)
	 * @param _id
	 * @return
	 */
	public AccessUser get(String _id)
	{
		return userDAO.get(_id);
	}

	public AccessRole getAccessRole(String _id)
	{
		return userDAO.getAccessRole(_id);
	}
}
