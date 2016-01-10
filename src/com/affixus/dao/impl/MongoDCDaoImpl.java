package com.affixus.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.affixus.dao.DCDao;
import com.affixus.dao.OrderDao;
import com.affixus.pojo.Client;
import com.affixus.pojo.DC;
import com.affixus.pojo.Invoice;
import com.affixus.pojo.Order;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants;
import com.affixus.util.MongoUtil;
import com.affixus.util.Constants.DBCollectionEnum;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.DBRef;
import com.mongodb.util.JSON;

public class MongoDCDaoImpl implements DCDao {

	private static final Logger LOG = Logger.getLogger( MongoDCDaoImpl.class );

	private DB mongoDB = MongoUtil.getDB();
	private String collOrder = DBCollectionEnum.ORDER.toString();
	private String collClient = DBCollectionEnum.MAST_CLIENT.toString();
	private String collDc = DBCollectionEnum.DC.toString();
	public static final String KEY_CLIENT_XID = "clientXid";
	public static final String KEY_CLIENT = "client";
	
	public static final String KEY_ORDER_XID = "orderXid";
	public static final String KEY_ORDER = "order";

	@Override
	public boolean create(DC dc) {
		// TODO Auto-generated method stub
		
		try{
			
			String _id = MongoUtil.getNextSequence(DBCollectionEnum.DC).toString();
			dc.set_id( _id );
			
			dc.setDcNumber(dc.generateDCNumber());
		
			DBCollection collection = mongoDB.getCollection( collOrder );
			String jsonString = CommonUtil.objectToJson(dc);
			DBObject dbObject = (DBObject) JSON.parse( jsonString );
			
			List<String> orderIdList = dc.getOrderIdList();
			for(String orderId : orderIdList){
				BasicDBObject queryObj = new BasicDBObject("_id",orderId);
				BasicDBObject setQuery = new BasicDBObject("status", Constants.PartsStatus.DCGENERTED.toString());
				DBObject updateQuery = new BasicDBObject("$set",setQuery);
				
				collection.update(queryObj, updateQuery);
			}
			
			DBRef clientRef = new DBRef( mongoDB, collClient, dc.getClient().get_id() );
			dbObject.put( KEY_CLIENT_XID, clientRef );
			dbObject.removeField( KEY_CLIENT );
			
			collection = mongoDB.getCollection( collDc);
			collection.insert(dbObject );
			
			return true;
		}catch( Exception exception ){
			LOG.equals(exception);
			exception.printStackTrace();
		}
		return false;
	}

	@Override
	public DC get(String _id) {
		// TODO Auto-generated method stub
		try{
			OrderDao Order = (OrderDao) new MongoOrderDaoImpl();
			
			DBCollection collection = mongoDB.getCollection(collDc);
			DBObject query = new BasicDBObject("_id", _id);
			DBObject dbObject = collection.findOne(query);
			
			//dbObject.put("invoiceCreationDateStr", CommonUtil.longToStringDate((Long)dbObject.get("invoiceCreationDate"), CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN));		
			DBObject clientDBO = ((DBRef) dbObject.get(KEY_CLIENT_XID)).fetch();
			dbObject.put(KEY_CLIENT, clientDBO);
			dbObject.removeField(KEY_CLIENT_XID);
			
			String jsonString = JSON.serialize(dbObject);
			DC dc = (DC) CommonUtil.jsonToObject( jsonString, DC.class.getName() );
			
			List<Order> orderList = new ArrayList<Order>();
			for(String orderId : dc.getOrderIdList()){
				Order order = Order.get(orderId);
				orderList.add(order);
			}
			dc.setOrderList(orderList);
			
			return dc;
		}
		catch( Exception exception ){
			exception.printStackTrace();
			LOG.equals(exception);
		}
		return null;
	}

	@Override
	public List<Order> getAllInfo(Date from, Date to) {
		// TODO Auto-generated method stub
		try{
			DBCollection collection = mongoDB.getCollection( collOrder );
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			if(null != from && null != to){
				finalQuery.put("orderDate", new BasicDBObject("$gte",from.getTime()).append("$lte", to.getTime()));
			}
			finalQuery.put("status", Constants.PartsStatus.COMPLETED.toString());
			DBCursor dbCursor = collection.find( finalQuery);
			
			List<Order> ordertList = new ArrayList<>();
			
			while ( dbCursor.hasNext() ) {
				DBObject dbObject = dbCursor.next();
				dbObject.put("orderDateStr", CommonUtil.longToStringDate((Long)dbObject.get("orderDate"), CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN));
				DBObject clientDBO = ((DBRef) dbObject.get(KEY_CLIENT_XID)).fetch();
				dbObject.put(KEY_CLIENT, clientDBO);
				dbObject.removeField(KEY_CLIENT_XID);
				if(("DC").equals(clientDBO.get("voucherType").toString())){
					String jsonString = JSON.serialize(dbObject);
					Order order = (Order) CommonUtil.jsonToObject( jsonString, Order.class.getName() );
					ordertList.add(order);
				}
				
			}
			return ordertList;
			
		}
		catch( Exception exception ){
			exception.printStackTrace();
			LOG.error(exception);
		}
		return null;
	}

	@Override
	public List<Client> getClients(Date from, Date to) {
		// TODO Auto-generated method stub
		try{
			DBCollection collection = mongoDB.getCollection( collDc );
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			if(null != from && null != to){
				finalQuery.put("dcCreationDate", new BasicDBObject("$gte",from.getTime()).append("$lte", to.getTime()));
			}
			//finalQuery.put("status", Constants.PartsStatus.INVOICEGENERATED.toString());
			DBCursor dbCursor = collection.find( finalQuery);
			
			List<Client> clientList = new ArrayList<>();
			
			while ( dbCursor.hasNext() ) {
				DBObject dbObject = dbCursor.next();
				//dbObject.put("orderDateStr", CommonUtil.longToStringDate((Long)dbObject.get("orderDate"), CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN));
				DBObject clientDBO = ((DBRef) dbObject.get(KEY_CLIENT_XID)).fetch();
				String jsonString = JSON.serialize(clientDBO);
				Client client = (Client) CommonUtil.jsonToObject( jsonString, Client.class.getName() );
				clientList.add(client);
			}
			return clientList;
			
		}
		catch( Exception exception ){
			exception.printStackTrace();
			LOG.error(exception);
		}
		return null;
	}

	@Override
	public HashMap<String, String> getListOfDCsByClientName(String clientId, Date from, Date to) {
		// TODO Auto-generated method stub
		try{
			DBCollection collection = mongoDB.getCollection(collDc );
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			if(null != from && null != to){
				finalQuery.put("dcCreationDate", new BasicDBObject("$gte",from.getTime()).append("$lte", to.getTime()));
			}
			//finalQuery.put("status", Constants.PartsStatus.INVOICEGENERATED.toString());
			finalQuery.put("clientXid.$id",clientId);
			
			DBCursor dbCursor = collection.find( finalQuery);
			
			HashMap<String,String> dcMap = new HashMap<String,String>();
			
			while ( dbCursor.hasNext() ) {
				DBObject dbObject = dbCursor.next();
				//dbObject.put("orderDateStr", CommonUtil.longToStringDate((Long)dbObject.get("orderDate"), CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN));
				//DBObject clientDBO = ((DBRef) dbObject.get(KEY_CLIENT_XID)).fetch();
				//String jsonString = JSON.serialize(clientDBO);
				//Client client = (Client) CommonUtil.jsonToObject( jsonString, Client.class.getName() );
				//clientList.add(client);
				dcMap.put((String)dbObject.get("_id"), (String)dbObject.get("dcNumber"));
			}
			return dcMap;
			
		}
		catch( Exception exception ){
			exception.printStackTrace();
			LOG.error(exception);
		}
		
		return null;
	}

}
