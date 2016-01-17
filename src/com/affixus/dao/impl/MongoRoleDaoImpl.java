package com.affixus.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.affixus.dao.RoleDAO;
import com.affixus.pojo.Client;
import com.affixus.pojo.auth.Role;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants.DBCollectionEnum;
import com.affixus.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.util.JSON;

public class MongoRoleDaoImpl implements RoleDAO {
	private static final Logger LOG = Logger.getLogger( MongoRoleDaoImpl.class );
	private String collRole = DBCollectionEnum.MAST_ROLE.toString();
	
	private DB mongoDB = MongoUtil.getDB();
	
	@Override
	public Role get(String _id) {
		try{
			DBCollection collection = mongoDB.getCollection( collRole );
			DBObject query = new BasicDBObject("_id", _id);
			DBObject dbObject = collection.findOne(query);
			
			if(dbObject == null){
				return null;
			}
			
			String jsonString = JSON.serialize(dbObject);
			Role role = (Role) CommonUtil.jsonToObject( jsonString, Role.class.getName() );
			return role;
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}
	
	@Override
	public List<Role> getAll() {
		try{
			DBCollection collection = mongoDB.getCollection( collRole );
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			DBCursor dbCursor = collection.find( finalQuery);
			
			if(dbCursor == null){
				return null;
			}
			List<Role> roleList = new ArrayList<>();
			
			while ( dbCursor.hasNext() ) {
				DBObject dbObject = dbCursor.next();
				String jsonString = JSON.serialize(dbObject);
				Role role = (Role) CommonUtil.jsonToObject( jsonString, Role.class.getName() );
				roleList.add(role);
			}
			return roleList;
		}
		catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}
	
	
	public Boolean add(Role role) {
		try{
			String _id = MongoUtil.getNextSequence(DBCollectionEnum.MAST_ROLE).toString();
			role.set_id( _id );
			DBCollection collection = mongoDB.getCollection( collRole );
			String jsonString = CommonUtil.objectToJson(role);
			DBObject dbObject = (DBObject) JSON.parse( jsonString );
			collection.insert(dbObject );
			return true;
		}
		catch( Exception exception ){
			LOG.equals(exception);
		}
		return false;
	}
	
	@Override
	public Boolean update(Role role) {
		try{
			Date date = new Date();
			role.setUtime( date );
			
			DBCollection collection = mongoDB.getCollection( collRole );
			String jsonString = CommonUtil.objectToJson(role);
			
			DBObject dbObject = (DBObject) JSON.parse( jsonString );
			dbObject.removeField("_id");
			DBObject query = new BasicDBObject("_id", role.get_id());
			
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
		Role role = new Role();
		role.set_id(_id);
		role.setDeleted(true);
		return update(role);
	}

	



}
