package com.affixus.services;

import com.affixus.dao.UserDAO;
import com.affixus.dao.impl.MongoUserDaoImpl;
import com.affixus.pojo.User;
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
	
	public User login(User user){
		return userDAO.login(user);
	}
}
