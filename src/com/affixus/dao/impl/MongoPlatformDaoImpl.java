package com.affixus.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;

import com.affixus.dao.PlatformDao;
import com.affixus.pojo.Part;
import com.affixus.pojo.Platform;
import com.affixus.pojo.Rate;
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

public class MongoPlatformDaoImpl implements PlatformDao {

	private static final Logger LOG = Logger.getLogger(MongoClientDaoImpl.class);
	private String collPlatform = DBCollectionEnum.MAST_PLATFORM.toString();
	private DB mongoDB = MongoUtil.getDB();
	public static final String KEY_CLIENT_XID = "clientXid";
	public static final String KEY_CLIENT = "client";

	@Override
	public Boolean create(Platform platform) {
		// TODO Auto-generated method stub

		try {

			Date date = new Date();
			platform.setCtime(date);
			platform.setUtime(date);
			String _id = MongoUtil.getNextSequence(DBCollectionEnum.MAST_CLIENT).toString();
			platform.set_id(_id);

			DBCollection collection = mongoDB.getCollection(collPlatform);
			String jsonString = CommonUtil.objectToJson(platform);
			DBObject dbObject = (DBObject) JSON.parse(jsonString);

			collection.insert(dbObject);

			return true;
		} catch (Exception exception) {
			LOG.equals(exception);
		}
		return false;

	}

	@Override
	public Boolean update(Platform platform) {
		// TODO Auto-generated method stub
		try {
			Date date = new Date();
			platform.setUtime(date);

			DBCollection collection = mongoDB.getCollection(collPlatform);
			String jsonString = CommonUtil.objectToJson(platform);

			DBObject dbObject = (DBObject) JSON.parse(jsonString);
			dbObject.removeField("_id");
			DBObject query = new BasicDBObject("_id", platform.get_id());

			DBObject updateObj = new BasicDBObject("$set", dbObject);

			collection.update(query, updateObj);
			return true;

		} catch (Exception exception) {
			LOG.equals(exception);
		}
		return false;
	}

	@Override
	public Boolean delete(String _id) {
		// TODO Auto-generated method stub
		Platform platform = new Platform();
		platform.set_id(_id);
		platform.setDeleted(true);
		return update(platform);

	}

	@Override
	public List<Platform> getAll() {
		// TODO Auto-generated method stub
		try {
			DBCollection collection = mongoDB.getCollection(collPlatform);
			DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
			DBCursor dbCursor = collection.find(finalQuery);

			List<Platform> platformList = new ArrayList<>();

			while (dbCursor.hasNext()) {
				DBObject dbObject = dbCursor.next();

				dbObject.put("orderFromDateStr", CommonUtil.longToStringDate((Long) dbObject.get("orderFromDate"),CommonUtil.DATETIME_FORMAT_ddMMyyyyHHmmss_HYPHEN));
				dbObject.put("orderToDateStr", CommonUtil.longToStringDate((Long) dbObject.get("orderToDate"),CommonUtil.DATETIME_FORMAT_ddMMyyyyHHmmss_HYPHEN));

				String jsonString = JSON.serialize(dbObject);

				Platform platform = (Platform) CommonUtil.jsonToObject(
						jsonString, Platform.class.getName());
				platformList.add(platform);
			}
			return platformList;

		} catch (Exception exception) {
			LOG.equals(exception);
		}
		return null;
	}

	@Override
	public Boolean updateParts(String clientId, String partName, Part part) {
		// TODO Auto-generated method stub
		try {
			DBCollection collection = mongoDB.getCollection(DBCollectionEnum.MAST_CLIENT.toString());
			DBObject clientObj = new BasicDBObject("clientId", clientId);
			DBCursor dbCursor = collection.find(clientObj);

			if (dbCursor.hasNext()) {

				clientObj = dbCursor.next();
				clientId = (String) clientObj.get("_id");

				collection = mongoDB.getCollection(DBCollectionEnum.MAST_PLATFORM.toString());
				DBObject platformObj = new BasicDBObject("platformNumber",part.getPlatFormNumber());
				DBCursor dbCursor1 = collection.find(platformObj);

				if (dbCursor1.hasNext()) {

					DBObject orderQuery = new BasicDBObject("clientXid.$id",clientId);
					orderQuery.put("partList.name", partName);
					orderQuery.put("status",Constants.PartsStatus.INPROGRESS.toString());
					
					platformObj = dbCursor1.next();
					collection = mongoDB.getCollection(DBCollectionEnum.ORDER.toString());

					DBCursor dbCursor2 = collection.find(orderQuery);

					if (dbCursor2.hasNext()) {

						DBObject dbObject = dbCursor2.next();
						String orderId = (String) dbObject.get("_id");
						DBObject getQuery = new BasicDBObject();
						getQuery.put("_id", orderId);
						getQuery.put("partList.name", part.getName());
						
						DBObject setQuery = new BasicDBObject();
						setQuery.put("partList.$.weight", part.getWeight());
						//setQuery.put("partList.$.refWeight", part.getRefWeight());
						setQuery.put("partList.$.platformNumber", part.getPlatFormNumber());
						setQuery.put("partList.$.status", part.getStatus());
						
						DBObject updateQuery = new BasicDBObject("$set",setQuery);
						
						//DBObject orderWithUpdatedPartInfo = collection.findAndModify(getQuery, null,null,false,updateQuery,true,false);
						collection.update(getQuery,updateQuery);

						
						//Check for Order Complete.
						getQuery = new BasicDBObject();
						getQuery.put("_id", orderId);
						getQuery.put("partList.status",Constants.PartsStatus.INPROGRESS.toString());
						
						DBCursor findResult = collection.find(getQuery);
						if(!findResult.hasNext()){
							setQuery = new BasicDBObject();
							setQuery.put("status", Constants.PartsStatus.COMPLETED.toString());
							updateQuery = new BasicDBObject("$set",setQuery);
							
							collection.update(new BasicDBObject("_id", orderId), updateQuery);
						}
						
						//Check for Platform Parts Complete.
						getQuery = new BasicDBObject();
						getQuery.put("partList.platformNumber", part.getPlatFormNumber());
						getQuery.put("partList.status",Constants.PartsStatus.INPROGRESS.toString());
						
						findResult = collection.find(getQuery);
						
						if(!findResult.hasNext()){
							setQuery = new BasicDBObject();
							setQuery.put("status", Constants.PartsStatus.COMPLETED.toString());
							updateQuery = new BasicDBObject("$set",setQuery);
							
							collection = mongoDB.getCollection(DBCollectionEnum.MAST_PLATFORM.toString());
							collection.update(new BasicDBObject("_id", platformObj.get("_id")), updateQuery);
						}
						
						Set<String> orderIdList = new HashSet<String>();
						orderIdList.add(orderId);
						updateCAMAmountByNewWeights(orderIdList);
					}
					
				}
			}
		} catch (Exception exception) {
			LOG.equals(exception);
		}
		return null;
	}
	
	
	@Override
	public List<String> getAllPlatformByStatus(String status) {
		// TODO Auto-generated method stub
		try {
			DBCollection collection = mongoDB.getCollection(DBCollectionEnum.MAST_PLATFORM.toString());
			DBObject queryObj = new BasicDBObject("status", status);
			DBObject projObj = new BasicDBObject("platformNumber", 1);
			DBCursor dbCursor = collection.find(queryObj, projObj);
			List<String> lstPlatform = new ArrayList<>();
			while (dbCursor.hasNext()) {
				DBObject dbObject = dbCursor.next();
				lstPlatform.add((String) dbObject.get("platformNumber"));
			}
			return lstPlatform;
		} catch (Exception exception) {
			LOG.equals(exception);
		}
		return null;
	}

	@Override
	public Boolean updateCAMAmountByNewWeights(Set<String> orderIdList) {
		
		DBCollection collection = mongoDB.getCollection(DBCollectionEnum.ORDER.toString());
		
		DBObject unwindQuery = new BasicDBObject("$unwind", "$partList");
		List<String> addArray = new ArrayList<>();
		addArray.add("$partList.weight");
		//addArray.add("$partList.refWeight");
		
		DBObject sumQuery = new BasicDBObject("$sum", new BasicDBObject("$add", addArray));
		DBObject groupQuery = new BasicDBObject("_id", null);
		groupQuery.put("weight",sumQuery);
		
		DBObject group = new BasicDBObject("$group",groupQuery);
		
		for(String orderId : orderIdList){
			DBObject orderObject = collection.findOne(new BasicDBObject("_id",orderId));
			DBObject clientDBO = ((DBRef) orderObject.get(KEY_CLIENT_XID)).fetch();
			String printer = (String)orderObject.get("printer");
			String rateListName = "";
			
			rateListName =(String) clientDBO.get(printer);
			
			DBObject matchQuery = new BasicDBObject("$match", new BasicDBObject("_id",orderId));

			AggregationOutput aggregationOutput = collection.aggregate(matchQuery, unwindQuery, group);
			for (DBObject orderObj : aggregationOutput.results()) {
				
				double weight = (double)orderObj.get("weight");
				double amount = computeAmountByNewWeight(weight,rateListName);
				
				DBObject setQuery = new BasicDBObject();
				setQuery.put("cam.weight", weight);
				setQuery.put("cam.amount", amount);
				DBObject updateQuery = new BasicDBObject("$set",setQuery);
				collection.update(new BasicDBObject("_id",orderId), updateQuery);
				
			}
			
		}
		return null;
	}
	private double computeAmountByNewWeight(double weight,String rateListName){
		
		double amount = 0;
		//calculate amount based on the client
		DBCollection collection = mongoDB.getCollection(DBCollectionEnum.MAST_RATE.toString());
		DBObject rateObj = collection.findOne(new BasicDBObject("_id",rateListName));
		String jsonString = JSON.serialize(rateObj);
		Rate rate = (Rate) CommonUtil.jsonToObject(jsonString, Rate.class);
		
		//List<RateRange> rateRange = rate.getRateRangeList();
		amount = rate.getPrice(weight);
		return amount;
	}
}
