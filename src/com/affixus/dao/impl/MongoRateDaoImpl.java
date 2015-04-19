package com.affixus.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.affixus.dao.RateDao;
import com.affixus.pojo.Rate;
import com.affixus.util.CommonUtil;
import com.affixus.util.MongoUtil;
import com.affixus.util.Constants.DBCollectionEnum;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.util.JSON;

public class MongoRateDaoImpl implements RateDao{
	private static final Logger LOG = Logger.getLogger( MongoRateDaoImpl.class );
	private DB mongoDB = MongoUtil.getDB();
	private String rateMaster = DBCollectionEnum.MAST_RATE.toString();
	@Override
	public Boolean update(Rate rate) {
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
	public Boolean create(Rate rate) {
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
		// TODO Auto-generated method stub
		Rate rate = new Rate();
		rate.set_id(_id);
		return update(rate);
	}

	@Override
	public Rate get(String _id) {
		// TODO Auto-generated method stub
		try{
			DBCollection collection = mongoDB.getCollection( rateMaster );
			DBObject query = new BasicDBObject("_id", _id);
			DBObject dbObject = collection.findOne(query);
			String jsonString = JSON.serialize(dbObject);
			Rate rate = (Rate) CommonUtil.jsonToObject( jsonString, Rate.class.getName() );
			
			return rate;
			
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}

	@Override
	public List<Rate> getAll() {
		// TODO Auto-generated method stub
		try{
			DBCollection collection = mongoDB.getCollection( rateMaster );
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			DBCursor dbCursor = collection.find( finalQuery);
			
			List<Rate> rateList = new ArrayList<>();
			
			while ( dbCursor.hasNext() ) {
				DBObject dbObject = dbCursor.next();
				String jsonString = JSON.serialize(dbObject);
				Rate rate = (Rate) CommonUtil.jsonToObject( jsonString, Rate.class.getName() );
				rateList.add(rate);
			}
			
			return rateList;
			
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}

}
