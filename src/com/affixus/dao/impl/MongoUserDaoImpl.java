package com.affixus.dao.impl;

import java.util.Set;

import org.apache.log4j.Logger;

import com.affixus.dao.UserDAO;
import com.affixus.pojo.User;
import com.affixus.pojo.auth.AccessRole;
import com.affixus.pojo.auth.AccessUser;
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
	private String collAccessUser = DBCollectionEnum.ACCESS_USER.toString();
	private String collAccessRole = DBCollectionEnum.ACCESS_ROLE.toString();
	private DB mongoDB = MongoUtil.getDB();
	
	@Override
	public AccessUser auth(String username, String password){
		// TODO Auto-generated method stub
		
		try{
			DBCollection collection = mongoDB.getCollection( collAccessUser );
			DBObject query = new BasicDBObject("userName", username).append("password", password);
			DBObject dbObject = collection.findOne(query);
			System.out.println(query.toString());
			String jsonString = JSON.serialize(dbObject);
			System.out.println(jsonString);
			
			if(dbObject == null){
				return null;
			}
			
			AccessUser loggedinUser = (AccessUser) CommonUtil.jsonToObject( jsonString, User.class.getName() );
			return loggedinUser;
			
			
		}catch( Exception exception ){
			//loggedinUser.setValid(false);
			LOG.equals(exception);
		}
		return null;
	}

	@Override
	public AccessUser getByUsername(String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public AccessUser get(String _id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Boolean register(AccessUser user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Set<AccessUser> getAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public AccessRole getAccessRole(String _id) {
		// TODO Auto-generated method stub
		return null;
	}
}
