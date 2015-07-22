package com.affixus.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.affixus.dao.InvoiceDao;
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
	public static final String KEY_CLIENT_XID = "clientXid";
	public static final String KEY_CLIENT = "client";

	@Override
	public boolean generateInvoice(List<Order> orderDetails) {
		// TODO Auto-generated method stub
		
		return false;
	}

	@Override
	public Invoice get(String _id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Order> getAllInfoByClient(Date from, Date to, String clientId) {
		// TODO Auto-generated method stub
		
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

}
