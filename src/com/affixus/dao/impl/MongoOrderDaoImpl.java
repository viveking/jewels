package com.affixus.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;

import com.affixus.dao.OrderDao;
import com.affixus.pojo.Order;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants;
import com.affixus.util.Constants.DBCollectionEnum;
import com.affixus.util.MongoUtil;
import com.mongodb.AggregationOutput;
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
			dbObject.removeField("_id");
			DBObject query = new BasicDBObject("_id", order.get_id());
			
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
			exception.printStackTrace();
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
				dbObject.put("orderDateStr", CommonUtil.longToStringDate((Long)dbObject.get("orderDate"), CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN));
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
			exception.printStackTrace();
			LOG.error(exception);
		}
		return null;
	}

	@Override
	public Set<Order> getAll(Date fromDate, Date toDate) {
		// TODO Auto-generated method stub
		try{
			DBCollection collection = mongoDB.getCollection( collOrder );
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			if(null != fromDate && null != toDate){
				finalQuery.put("orderDate", new BasicDBObject("$gte",fromDate.getTime()).append("$lte", toDate.getTime()));
			}
			DBCursor dbCursor = collection.find( finalQuery);
			
			Set<Order> orderList = new HashSet<>();
			
			while ( dbCursor.hasNext() ) {
				DBObject dbObject = dbCursor.next();
				dbObject.put("orderDateStr", CommonUtil.longToStringDate((Long)dbObject.get("orderDate"), CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN));
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
			exception.printStackTrace();
			LOG.error(exception);
		}
		return null;
	}

	@Override
	public Set<Order> getAllByOperation(Date fromDate, Date toDate, String operation) {
		// TODO Auto-generated method stub
		try{
			DBCollection collection = mongoDB.getCollection( collOrder );
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			if(null != fromDate && null != toDate){
				finalQuery.put("orderDate", new BasicDBObject("$gte",fromDate.getTime()).append("$lte", toDate.getTime()));
			}
			
			String operationDoc = operation + ".required";
			finalQuery.put(operationDoc, true);
			
			DBCursor dbCursor = collection.find( finalQuery, new BasicDBObject("partList",0));
			
			Set<Order> orderList = new HashSet<>();
			
			while ( dbCursor.hasNext() ) {
				DBObject dbObject = dbCursor.next();
				dbObject.put("orderDateStr", CommonUtil.longToStringDate((Long)dbObject.get("orderDate"), CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN));
				DBObject clientDBO = ((DBRef) dbObject.get(KEY_CLIENT_XID)).fetch();
				dbObject.put(KEY_CLIENT, clientDBO);
				dbObject.removeField(KEY_CLIENT_XID);
				
				DBObject dbProcessType = (DBObject)dbObject.get(operation);
				dbObject.put("t_charges",dbProcessType.get("amount"));
				
				String jsonString = JSON.serialize(dbObject);
				Order oredr = (Order) CommonUtil.jsonToObject( jsonString, Order.class.getName() );
				orderList.add(oredr);
			}
			return orderList;
			
		}
		catch( Exception exception ){
			exception.printStackTrace();
			LOG.error(exception);
		}
		return null;
	}

	@Override
	public Set<String> getOrderInfoByClient(String clientId) {
		// TODO Auto-generated method stub
		try{
			DBCollection collection = mongoDB.getCollection(DBCollectionEnum.MAST_CLIENT.toString());
			//DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			DBObject clientObj = new BasicDBObject("clientId",clientId);
			DBCursor dbCursor = collection.find(clientObj);
			
			if(dbCursor.hasNext()){
				
				clientObj = dbCursor.next();
				clientId = (String) clientObj.get("_id");
				List<BasicDBObject> queryList = new ArrayList<>();
				

				queryList.add(new BasicDBObject("status",Constants.PartsStatus.INPROGRESS.toString()));
				queryList.add(new BasicDBObject("clientXid.$id",clientId));
				//queryList.add(new BasicDBObject("partList.status",ew BasicDBObject("$ne",Constants.PartsStatus.COMPLETE.toString())));
				
				DBObject anding = new BasicDBObject("$and",queryList);
				
				DBObject match = new BasicDBObject("$match", anding);
				DBObject unwind = new BasicDBObject("$unwind", "$partList");
				
				/*
				List<BasicDBObject> andingForMatch2 = new ArrayList<>();
				andingForMatch2.add(new BasicDBObject("partList.status",new BasicDBObject("$ne",Constants.PartsStatus.COMPLETE.toString())));
				andingForMatch2.add(new BasicDBObject("partList.platformNumber", platformNumber));
				
				DBObject match2 = new BasicDBObject("$match",new BasicDBObject("$and",andingForMatch2));
				*/
				
				DBObject match2 = new BasicDBObject("$match",new BasicDBObject("partList.status",
						new BasicDBObject("$ne",Constants.PartsStatus.COMPLETE.toString())));
				
				collection = mongoDB.getCollection(DBCollectionEnum.ORDER.toString());
				AggregationOutput aggregationOutput = collection.aggregate(match, unwind,match2);
				
				Set<String> orderList = new HashSet<>();
				for (DBObject orderObj : aggregationOutput.results()) {
					//DBObject orderObj = dbCursor1.next();
					DBObject clientDBO = ((DBRef) orderObj.get(KEY_CLIENT_XID)).fetch();
					
					orderObj.put("orderDateStr", CommonUtil.longToStringDate((Long)orderObj.get("orderDate"), CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN));
					orderObj.put(KEY_CLIENT, clientDBO);
					orderObj.removeField(KEY_CLIENT_XID);
					
					String jsonString = JSON.serialize(orderObj);
					//Order oredr = (Order) CommonUtil.jsonToObject( jsonString, Order.class.getName() );
					orderList.add(jsonString);
				}				
				return orderList;
			}
		}
		catch( Exception exception ){
			exception.printStackTrace();
		}
		return null;
	}

	@Override
	public Set<String> getOrderInfoByPlatform(String platformNumber) {
		// TODO Auto-generated method stub
		try{
			DBCollection collection = mongoDB.getCollection(DBCollectionEnum.ORDER.toString());
			
			//db.order.aggregate({$match:{"partList.platformNumber":"PF_7294"}},
			//{$unwind:"$partList"},{$match:{"partList.platformNumber":"PF_7294"}})
			List<BasicDBObject> queryList = new ArrayList<>();
			queryList.add(new BasicDBObject("status",Constants.PartsStatus.INPROGRESS.toString()));
			queryList.add(new BasicDBObject("partList.platformNumber", platformNumber));
			//queryList.add(new BasicDBObject("partList.status",new BasicDBObject("$ne",Constants.PartsStatus.COMPLETE.toString())));
			
			DBObject anding = new BasicDBObject("$and",queryList);
			
			DBObject match = new BasicDBObject("$match", anding);
			DBObject unwind = new BasicDBObject("$unwind", "$partList");
			
			List<BasicDBObject> andingForMatch2 = new ArrayList<>();
			andingForMatch2.add(new BasicDBObject("partList.status",new BasicDBObject("$ne",Constants.PartsStatus.COMPLETE.toString())));
			andingForMatch2.add(new BasicDBObject("partList.platformNumber", platformNumber));
			
			DBObject match2 = new BasicDBObject("$match",new BasicDBObject("$and",andingForMatch2));
			
			AggregationOutput aggregationOutput = collection.aggregate(match, unwind,match2);
			
			Set<String> orderList = new HashSet<>();
			for (DBObject orderObj : aggregationOutput.results()) {
				DBObject clientDBO = ((DBRef) orderObj.get(KEY_CLIENT_XID)).fetch();
				
				orderObj.put("orderDateStr", CommonUtil.longToStringDate((Long)orderObj.get("orderDate"), CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN));
				orderObj.put(KEY_CLIENT, clientDBO);
				orderObj.removeField(KEY_CLIENT_XID);
				String jsonString = JSON.serialize(orderObj);
				orderList.add(jsonString);
			}				
			return orderList;
		}
		catch( Exception exception ){
			exception.printStackTrace();
		}
		return null;
	}
	
}
