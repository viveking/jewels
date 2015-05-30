package com.affixus.dao.impl;

import java.util.HashSet;
import java.util.Set;

import org.apache.log4j.Logger;

import com.affixus.dao.OrderDao;
import com.affixus.pojo.Order;
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

public class MongoOrderDaoImpl implements OrderDao {
	private static final Logger LOG = Logger.getLogger( MongoOrderDaoImpl.class );
	
	public static final String KEY_CLIENT_XID = "clientXid";
	public static final String KEY_CLIENT = "client";
	
	private DB mongoDB = MongoUtil.getDB();
	private String collOrder = DBCollectionEnum.ORDER.toString();
	private String collClient = DBCollectionEnum.MAST_CLIENT.toString();
	
	@Override
	public Boolean create(Order order) {
		try{
			
			String _id = MongoUtil.getNextSequence(DBCollectionEnum.ORDER).toString();
			order.set_id( _id );
			
			DBCollection collection = mongoDB.getCollection( collOrder );
			String jsonString = CommonUtil.objectToJson(order);
			DBObject dbObject = (DBObject) JSON.parse( jsonString );
			DBRef clientRef = new DBRef( mongoDB, collClient, order.getClient().get_id() );
			dbObject.put( KEY_CLIENT_XID, clientRef );
			dbObject.removeField( KEY_CLIENT );
			
			collection.insert(dbObject );
			
			return true;
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return false;
	}
	
	@Override
	public Boolean update(Order order) {
		try{
			
			DBCollection collection = mongoDB.getCollection( collOrder );
			String jsonString = CommonUtil.objectToJson(order);
			DBObject dbObject = (DBObject) JSON.parse( jsonString );
			DBObject dbOldObj = new BasicDBObject();
			dbOldObj.put("_id", order.get_id());
			
			collection.update(dbOldObj, dbObject, false, false);
			
			return true;
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return false;
	}

	
	
	@Override
	public Boolean delete(String _id) {
		Order order = new Order();
		order.set_id(_id);
		order.setDeleted(true);
		return update(order);
	}
	
	@Override
	public Order get(String _id) {
		try{
			
			DBCollection collection = mongoDB.getCollection(collOrder);
			DBObject query = new BasicDBObject("_id", _id);
			DBObject dbObject = collection.findOne(query);
			
			DBObject clientDBO = ((DBRef) dbObject.get(KEY_CLIENT_XID)).fetch();
			dbObject.put(KEY_CLIENT, clientDBO);
			dbObject.removeField(KEY_CLIENT_XID);
			
			String jsonString = JSON.serialize(dbObject);
			Order order = (Order) CommonUtil.jsonToObject( jsonString, Order.class.getName() );
			return order;
		}
		catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}

	@Override
	public Set<Order> getAll() {
		
		try{
			DBCollection collection = mongoDB.getCollection( collOrder );
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			DBCursor dbCursor = collection.find( finalQuery);
			
			Set<Order> orderList = new HashSet<>();
			
			while ( dbCursor.hasNext() ) {
				DBObject dbObject = dbCursor.next();
				DBObject clientDBO = ((DBRef) dbObject.get(KEY_CLIENT_XID)).fetch();
				dbObject.put(KEY_CLIENT, clientDBO);
				dbObject.removeField(KEY_CLIENT_XID);
				
				String jsonString = JSON.serialize(dbObject);
				Order oredr = (Order) CommonUtil.jsonToObject( jsonString, Order.class.getName() );
				orderList.add(oredr);
			}
			return orderList;
			
		}
		catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}
}
