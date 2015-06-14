package com.affixus.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.affixus.dao.PlatformDao;
import com.affixus.pojo.Platform;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants.DBCollectionEnum;
import com.affixus.util.MongoUtil;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.util.JSON;

public class MongoPlatformDaoImpl implements PlatformDao {
	
	private static final Logger LOG = Logger.getLogger( MongoClientDaoImpl.class );
	private String collPlatform = DBCollectionEnum.MAST_PLATFORM.toString();
	private DB mongoDB = MongoUtil.getDB();

	
	@Override
	public Boolean create(Platform platform) {
		// TODO Auto-generated method stub
		
		try{
			
			Date date = new Date();
			platform.setCtime( date );
			platform.setUtime( date );
			String _id = MongoUtil.getNextSequence(DBCollectionEnum.MAST_CLIENT).toString();
			platform.set_id( _id );
			
			DBCollection collection = mongoDB.getCollection( collPlatform );
			String jsonString = CommonUtil.objectToJson(platform);			
			DBObject dbObject = (DBObject) JSON.parse( jsonString );

			collection.insert(dbObject );
			
			return true;
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return false;

	}

	@Override
	public Boolean update(Platform platform) {
		// TODO Auto-generated method stub
		try{
			Date date = new Date();
			platform.setUtime( date );
			
			DBCollection collection = mongoDB.getCollection( collPlatform );
			String jsonString = CommonUtil.objectToJson(platform);
			
			DBObject dbObject = (DBObject) JSON.parse( jsonString );
			dbObject.removeField("_id");
			DBObject query = new BasicDBObject("_id", platform.get_id());
			
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
		// TODO Auto-generated method stub
		Platform platform = new Platform();
		platform .set_id(_id);
		platform .setDeleted(true);
		return update(platform);

	}

	@Override
	public List<Platform> getAll() {
		// TODO Auto-generated method stub
		try{
			DBCollection collection = mongoDB.getCollection( collPlatform);
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			DBCursor dbCursor = collection.find( finalQuery);
			
			List<Platform> platformList = new ArrayList<>();
			
			while ( dbCursor.hasNext() ) {
				DBObject dbObject = dbCursor.next();
				
				dbObject.put("orderFromDateStr", CommonUtil.longToStringDate((Long)dbObject.get("orderFromDate"),CommonUtil.DATETIME_FORMAT_ddMMyyyyHHmmss_HYPHEN));
				dbObject.put("orderToDateStr", CommonUtil.longToStringDate((Long)dbObject.get("orderToDate"),CommonUtil.DATETIME_FORMAT_ddMMyyyyHHmmss_HYPHEN));
				
				String jsonString = JSON.serialize(dbObject);
				
				Platform platform = (Platform) CommonUtil.jsonToObject( jsonString, Platform.class.getName());
				platformList.add(platform);
			}
			return platformList;
			
		}catch( Exception exception ){
			LOG.equals(exception);
		}
		return null;
	}

}
