package com.affixus.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import com.affixus.dao.InvoiceDao;
import com.affixus.dao.OrderDao;
import com.affixus.pojo.Client;
import com.affixus.pojo.Invoice;
import com.affixus.pojo.Order;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants;
import com.affixus.util.Constants.DBCollectionEnum;
import com.affixus.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.DBRef;
import com.mongodb.util.JSON;

public class MongoInvoiceDaoImpl implements InvoiceDao {

	private static final Logger LOG = Logger.getLogger( MongoInvoiceDaoImpl.class );
	
	private DB mongoDB = MongoUtil.getDB();
	private String collOrder = DBCollectionEnum.ORDER.toString();
	private String collClient = DBCollectionEnum.MAST_CLIENT.toString();
	private String collInvoice = DBCollectionEnum.INVOICE.toString();
	public static final String KEY_CLIENT_XID = "clientXid";
	public static final String KEY_CLIENT = "client";
	
	public static final String KEY_ORDER_XID = "orderXid";
	public static final String KEY_ORDER = "order";
	
	@Override
	public boolean create(Invoice invoice) {
		// TODO Auto-generated method stub
		
		try{
			
			String _id = MongoUtil.getNextSequence(DBCollectionEnum.INVOICE).toString();
			invoice.set_id( _id );
			
			invoice.setInvoiceNumber(invoice.generateInvoiceNumber());
			
			DBCollection collection = mongoDB.getCollection( collOrder );
			String jsonString = CommonUtil.objectToJson(invoice);
			DBObject dbObject = (DBObject) JSON.parse( jsonString );
			
			List<String> orderIdList = invoice.getOrderIdList();
			for(String orderId : orderIdList){
				BasicDBObject queryObj = new BasicDBObject("_id",orderId);
				BasicDBObject setQuery = new BasicDBObject("status", Constants.PartsStatus.INVOICEGENERATED.toString());
				DBObject updateQuery = new BasicDBObject("$set",setQuery);
				
				collection.update(queryObj, updateQuery);
			}
			
			DBRef clientRef = new DBRef( mongoDB, collClient, invoice.getClient().get_id() );
			dbObject.put( KEY_CLIENT_XID, clientRef );
			dbObject.removeField( KEY_CLIENT );
			
			collection = mongoDB.getCollection( collInvoice );
			collection.insert(dbObject );
			
			return true;
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return false;
	}

	@Override
	public Invoice get(String _id) {
		// TODO Auto-generated method stub
		try{
			OrderDao Order = (OrderDao) new MongoInvoiceDaoImpl();
			
			DBCollection collection = mongoDB.getCollection(collInvoice);
			DBObject query = new BasicDBObject("_id", _id);
			DBObject dbObject = collection.findOne(query);
			
			//dbObject.put("invoiceCreationDateStr", CommonUtil.longToStringDate((Long)dbObject.get("invoiceCreationDate"), CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN));		
			DBObject clientDBO = ((DBRef) dbObject.get(KEY_CLIENT_XID)).fetch();
			dbObject.put(KEY_CLIENT, clientDBO);
			dbObject.removeField(KEY_CLIENT_XID);
			
			String jsonString = JSON.serialize(dbObject);
			Invoice invoice = (Invoice) CommonUtil.jsonToObject( jsonString, Invoice.class.getName() );
			
			List<Order> orderList = new ArrayList<Order>();
			for(String orderId : invoice.getOrderIdList()){
				Order order = Order.get(orderId);
				orderList.add(order);
			}
			invoice.setOrderList(orderList);
			
			return invoice;
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
				
				String jsonString = JSON.serialize(dbObject);
				Order order = (Order) CommonUtil.jsonToObject( jsonString, Order.class.getName() );
				ordertList.add(order);
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
			DBCollection collection = mongoDB.getCollection( collInvoice );
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			if(null != from && null != to){
				finalQuery.put("invoiceCreationDate", new BasicDBObject("$gte",from.getTime()).append("$lte", to.getTime()));
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
	public HashMap<String,String> getListOfInvoicesByClientName(String clientId, Date from, Date to) {
		// TODO Auto-generated method stub
		//queryList.add(new BasicDBObject("clientXid.$id",clientId));
		try{
			DBCollection collection = mongoDB.getCollection(collInvoice );
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			if(null != from && null != to){
				finalQuery.put("orderDate", new BasicDBObject("$gte",from.getTime()).append("$lte", to.getTime()));
			}
			finalQuery.put("status", Constants.PartsStatus.INVOICEGENERATED.toString());
			finalQuery.put("clientXid.$id",clientId);
			
			DBCursor dbCursor = collection.find( finalQuery);
			
			HashMap<String,String> invoiceMap = new HashMap<String,String>();
			
			while ( dbCursor.hasNext() ) {
				DBObject dbObject = dbCursor.next();
				//dbObject.put("orderDateStr", CommonUtil.longToStringDate((Long)dbObject.get("orderDate"), CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN));
				//DBObject clientDBO = ((DBRef) dbObject.get(KEY_CLIENT_XID)).fetch();
				//String jsonString = JSON.serialize(clientDBO);
				//Client client = (Client) CommonUtil.jsonToObject( jsonString, Client.class.getName() );
				//clientList.add(client);
				invoiceMap.put((String)dbObject.get("_id"), (String)dbObject.get("invoiceNumber"));
			}
			return invoiceMap;
			
		}
		catch( Exception exception ){
			exception.printStackTrace();
			LOG.error(exception);
		}
		
		return null;
	}

}
