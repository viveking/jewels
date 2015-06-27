package com.affixus.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.affixus.dao.ClientDao;
import com.affixus.pojo.Client;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants.DBCollectionEnum;
import com.affixus.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.util.JSON;

public class MongoClientDaoImpl implements ClientDao{
	private static final Logger LOG = Logger.getLogger( MongoClientDaoImpl.class );
	
	
	private String collClient = DBCollectionEnum.MAST_CLIENT.toString();
	
	private DB mongoDB = MongoUtil.getDB();
	
	@Override
	public Boolean create(Client area) {
		try{
			Date date = new Date();
			area.setCtime( date );
			area.setUtime( date );
			String _id = MongoUtil.getNextSequence(DBCollectionEnum.MAST_CLIENT).toString();
			area.set_id( _id );
			
			DBCollection collection = mongoDB.getCollection( collClient );
			String jsonString = CommonUtil.objectToJson(area);
			
			DBObject dbObject = (DBObject) JSON.parse( jsonString );
			
			collection.insert(dbObject );
			return true;
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return false;
	}
	
	@Override
	public Boolean update(Client client) {
		try{
			Date date = new Date();
			client.setUtime( date );
			
			DBCollection collection = mongoDB.getCollection( collClient );
			String jsonString = CommonUtil.objectToJson(client);
			
			DBObject dbObject = (DBObject) JSON.parse( jsonString );
			dbObject.removeField("_id");
			DBObject query = new BasicDBObject("_id", client.get_id());
			
			DBObject updateObj = new BasicDBObject("$set", dbObject);
			
			collection.update(query, updateObj);
			return true;
			
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return false;
		
	}
	
	@Override
	public Boolean delete(String _id) {
		Client area = new Client();
		area.set_id(_id);
		area.setDeleted(true);
		return update(area);
	}
	
	
	@Override
	public Client get(String _id) {
		try{
			DBCollection collection = mongoDB.getCollection( collClient );
			DBObject query = new BasicDBObject("_id", _id);
			DBObject dbObject = collection.findOne(query);
			String jsonString = JSON.serialize(dbObject);
			Client client = (Client) CommonUtil.jsonToObject( jsonString, Client.class.getName() );
			
			return client;
			
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}
	
	@Override
	public List<Client> getAll() {
		try{
			DBCollection collection = mongoDB.getCollection( collClient );
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			DBCursor dbCursor = collection.find( finalQuery);
			
			List<Client> clientList = new ArrayList<>();
			
			while ( dbCursor.hasNext() ) {
				DBObject dbObject = dbCursor.next();
				String jsonString = JSON.serialize(dbObject);
				Client client = (Client) CommonUtil.jsonToObject( jsonString, Client.class.getName() );
				clientList.add(client);
			}
			return clientList;
			
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}

	@Override
	public List<String> getAllClientId() {
		try{
			DBCollection collection = mongoDB.getCollection( collClient );
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			
			DBObject projection = new BasicDBObject("clientId", 1);
			
			DBCursor dbCursor = collection.find(finalQuery,projection);
			
			List<String> clientList = new ArrayList<>();
			
			while ( dbCursor.hasNext() ) {
				DBObject dbObject = dbCursor.next();
				//String jsonString = JSON.serialize(dbObject);
				//Client area = (Client) CommonUtil.jsonToObject( jsonString, Client.class.getName() );
				clientList.add( dbObject.get("clientId").toString() );
			}
			return clientList;
			
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}

	@Override
	public Client getByClientId(String clientId) {
		try{
			DBCollection collection = mongoDB.getCollection( collClient );
			DBObject query = new BasicDBObject("clientId", clientId);
			DBObject dbObject = collection.findOne(query);
			String jsonString = JSON.serialize(dbObject);
			Client client = (Client) CommonUtil.jsonToObject( jsonString, Client.class.getName() );
			return client;
			
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}
	
}
