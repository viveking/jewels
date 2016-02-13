package com.affixus.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.affixus.dao.UserDAO;
import com.affixus.pojo.auth.User;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants.DBCollectionEnum;
import com.affixus.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.DBRef;
import com.mongodb.util.JSON;

public class MongoUserDaoImpl implements UserDAO{
	private static final Logger LOG = Logger.getLogger( MongoUserDaoImpl.class );
	private String collUser = DBCollectionEnum.MAST_USER.toString();
	private String collRole = DBCollectionEnum.MAST_ROLE.toString();
	public static final String KEY_ROLE_XID = "roleXid";
	public static final String KEY_ROLE = "role";
	
	private DB mongoDB = MongoUtil.getDB();
	
	@Override
	public User auth(String username, String password){
		try{
			DBCollection collection = mongoDB.getCollection( collUser );
			DBObject query = new BasicDBObject("username", username).append("password", password);
			DBObject dbObject = collection.findOne(query);
			
			if(dbObject == null){
				return null;
			}
			
			DBObject roleDBO = ((DBRef) dbObject.get(KEY_ROLE_XID)).fetch();
			dbObject.put(KEY_ROLE, roleDBO);
			dbObject.removeField(KEY_ROLE_XID);
			
			String jsonString = JSON.serialize(dbObject);
			User user = (User) CommonUtil.jsonToObject( jsonString, User.class.getName() );
			return user;
			
			
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}

	@Override
	public User getByUsername(String username) {
		try{
			DBCollection collection = mongoDB.getCollection( collUser );
			DBObject query = new BasicDBObject("username", username);
			DBObject dbObject = collection.findOne(query);
			
			if(dbObject == null){
				return null;
			}
			
			DBObject roleDBO = ((DBRef) dbObject.get(KEY_ROLE_XID)).fetch();
			dbObject.put(KEY_ROLE, roleDBO);
			dbObject.removeField(KEY_ROLE_XID);
			
			String jsonString = JSON.serialize(dbObject);
			User user = (User) CommonUtil.jsonToObject( jsonString, User.class.getName() );
			return user;
			
			
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}

	@Override
	public User get(String _id) {
		try{
			DBCollection collection = mongoDB.getCollection( collUser );
			DBObject query = new BasicDBObject("_id", _id);
			DBObject dbObject = collection.findOne(query);
			
			if(dbObject == null){
				return null;
			}
			
			DBObject roleDBO = ((DBRef) dbObject.get(KEY_ROLE_XID)).fetch();
			dbObject.put(KEY_ROLE, roleDBO);
			dbObject.removeField(KEY_ROLE_XID);
			
			String jsonString = JSON.serialize(dbObject);
			User loggedinUser = (User) CommonUtil.jsonToObject( jsonString, User.class.getName() );
			return loggedinUser;
			
			
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}

	@Override
	public Boolean add(User user) {
		try{
			String _id = MongoUtil.getNextSequence(DBCollectionEnum.MAST_USER).toString();
			user.set_id( _id );
			DBCollection collection = mongoDB.getCollection( collUser );
			String jsonString = CommonUtil.objectToJson(user);
			DBObject dbObject = (DBObject) JSON.parse( jsonString );
			DBRef roleRef = new DBRef( mongoDB, collRole, user.getRole().get_id() );
			dbObject.put( KEY_ROLE_XID, roleRef );
			dbObject.removeField( KEY_ROLE);
			collection.insert(dbObject );
			
			return true;
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return false;
	}

	@Override
	public List<User> getAll() {
		try{
			DBCollection collection = mongoDB.getCollection( collUser );
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			DBCursor dbCursor = collection.find( finalQuery);
			
			if(dbCursor == null){
				return null;
			}
			
			List<User> userList = new ArrayList<>();
			
			while ( dbCursor.hasNext() ) {
				DBObject dbObject = dbCursor.next();
				DBObject roleDBO = ((DBRef) dbObject.get(KEY_ROLE_XID)).fetch();
				dbObject.put(KEY_ROLE, roleDBO);
				dbObject.removeField(KEY_ROLE_XID);
				
				String jsonString = JSON.serialize(dbObject);
				User user = (User) CommonUtil.jsonToObject( jsonString, User.class.getName() );
				
				userList.add(user);
				
			}
			return userList;
		}
		catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}
	@Override
	public Boolean update(User user) {
		try{
			Date date = new Date();
			user.setUtime( date );
			
			DBCollection collection = mongoDB.getCollection( collUser );
			String jsonString = CommonUtil.objectToJson(user);
			
			DBObject dbObject = (DBObject) JSON.parse( jsonString );
			dbObject.removeField("_id");
			DBObject query = new BasicDBObject("_id", user.get_id());
			
			DBObject updateObj = new BasicDBObject("$set", dbObject);
			
			collection.update(query, updateObj);
			return true;
		}
		catch( Exception exception ){
			LOG.equals(exception);
		}
		return false;
	}

	@Override
	public Boolean delete(String _id) {
		// TODO Auto-generated method stub
		User user = new User();
		user.set_id(_id);
		user.setDeleted(true);
		return update(user);
	}

	@Override
	public Boolean validateUser(String username) {
		// TODO Auto-generated method stub
		DBCollection collection = mongoDB.getCollection( collUser );
		DBObject query = new BasicDBObject("username", username);
		DBObject dbObject = collection.findOne(query);
		
		if(dbObject == null){
			return false;
		}
		return true;
	}
}

