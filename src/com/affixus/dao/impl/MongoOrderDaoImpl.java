package com.affixus.dao.impl;

import org.apache.log4j.Logger;

import com.affixus.dao.OrderDao;
import com.affixus.pojo.Order;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants.DBCollectionEnum;
import com.affixus.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.util.JSON;

public class MongoOrderDaoImpl implements OrderDao {
	private static final Logger LOG = Logger.getLogger( MongoOrderDaoImpl.class );
	private DB mongoDB = MongoUtil.getDB();
	private String rateMaster = DBCollectionEnum.MAST_RATE.toString();
	@Override
	public Boolean update(Order rate) {
		// TODO Auto-generated method stub
		try{
			
			DBCollection collection = mongoDB.getCollection( rateMaster );
			String jsonString = CommonUtil.objectToJson(rate);
			
			DBObject dbObject = (DBObject) JSON.parse( jsonString );
			dbObject.removeField("_id");
			DBObject query = new BasicDBObject("_id", rate.get_id());
			
			DBObject updateObj = new BasicDBObject("$set", dbObject);
			
			collection.update(query, updateObj);
			return true;
			
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return false;
	}

	@Override
	public Boolean create(Order rate) {
		try{
			
			String _id = MongoUtil.getNextSequence(DBCollectionEnum.MAST_RATE).toString();
			rate.set_id( _id );
			
			DBCollection collection = mongoDB.getCollection(rateMaster);
			String jsonString = CommonUtil.objectToJson(rate);
			
			DBObject dbObject = (DBObject) JSON.parse( jsonString );
			
			collection.insert(dbObject );
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
}
