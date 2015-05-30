package com.affixus.dao.impl;

import org.apache.log4j.Logger;
import com.affixus.dao.UserDAO;
import com.affixus.pojo.User;
import com.affixus.util.CommonUtil;
import com.affixus.util.MongoUtil;
import com.affixus.util.Constants.DBCollectionEnum;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.util.JSON;

public class MongoUserDaoImpl implements UserDAO{
	private static final Logger LOG = Logger.getLogger( MongoUserDaoImpl.class );
	private String collLogin = DBCollectionEnum.MAST_LOGIN.toString();
	private DB mongoDB = MongoUtil.getDB();
	
	@Override
	public User login(User user) {
		// TODO Auto-generated method stub
		
		try{
			DBCollection collection = mongoDB.getCollection( collLogin );
			DBObject query = new BasicDBObject("userName", user.getUserName()).append("password", user.getPassword());
			DBObject dbObject = collection.findOne(query);
			System.out.println(query.toString());
			String jsonString = JSON.serialize(dbObject);
			System.out.println(jsonString);
			
			if(dbObject.equals(null)){
				return null;
			}
			else{
				User loggedinUser = (User) CommonUtil.jsonToObject( jsonString, User.class.getName() );
				loggedinUser.setValid(true);
				return loggedinUser;
			}
			
		}catch( Exception exception ){
			//loggedinUser.setValid(false);
			LOG.equals(exception);
			
		}
		return null;

	}
}
