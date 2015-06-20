package com.affixus.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.affixus.dao.PlatformDao;
import com.affixus.pojo.Part;
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

	private static final Logger LOG = Logger
			.getLogger(MongoClientDaoImpl.class);
	private String collPlatform = DBCollectionEnum.MAST_PLATFORM.toString();
	private DB mongoDB = MongoUtil.getDB();

	@Override
	public Boolean create(Platform platform) {
		// TODO Auto-generated method stub

		try {

			Date date = new Date();
			platform.setCtime(date);
			platform.setUtime(date);
			String _id = MongoUtil
					.getNextSequence(DBCollectionEnum.MAST_CLIENT).toString();
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

				dbObject.put("orderFromDateStr", CommonUtil.longToStringDate(
						(Long) dbObject.get("orderFromDate"),
						CommonUtil.DATETIME_FORMAT_ddMMyyyyHHmmss_HYPHEN));
				dbObject.put("orderToDateStr", CommonUtil.longToStringDate(
						(Long) dbObject.get("orderToDate"),
						CommonUtil.DATETIME_FORMAT_ddMMyyyyHHmmss_HYPHEN));

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
			DBCollection collection = mongoDB
					.getCollection(DBCollectionEnum.MAST_CLIENT.toString());
			DBObject clientObj = new BasicDBObject("clientId", clientId);
			DBCursor dbCursor = collection.find(clientObj);

			if (dbCursor.hasNext()) {

				clientObj = dbCursor.next();
				clientId = (String) clientObj.get("_id");

				DBObject orderQuery = new BasicDBObject("clientXid.$id",
						clientId).append("partList.name", partName);

				collection = mongoDB
						.getCollection(DBCollectionEnum.MAST_PLATFORM
								.toString());
				DBObject platformObj = new BasicDBObject("platformNumber",
						part.getPlatFormNumber());
				DBCursor dbCursor1 = collection.find(platformObj);

				if (dbCursor1.hasNext()) {

					platformObj = dbCursor1.next();

					// Long fromDate = (Long) platformObj.get("orderFromDate");
					// Long toDate =(Long) platformObj.get("orderToDate");
					// if(fromDate != null && toDate != null){
					// orderQuery.put("orderDate", new
					// BasicDBObject("$gte",fromDate).append("$lte",toDate));
					// }
					collection = mongoDB.getCollection(DBCollectionEnum.ORDER
							.toString());

					DBCursor dbCursor2 = collection.find(orderQuery);

					if (dbCursor2.hasNext()) {

						DBObject dbObject = dbCursor2.next();
						String orderId = (String) dbObject.get("_id");
						DBObject getQuery = new BasicDBObject();
						getQuery.put("_id", orderId);
						getQuery.put("partList.name", part.getName());

						DBObject updateQuery = new BasicDBObject("$set",
								new BasicDBObject("partList.$.weight",
										part.getWeight()).append(
										"partList.$.refWeight",
										part.getRefWeight()).append(
										"partList.$.platformNumber",
										part.getPlatFormNumber()));
						collection.update(getQuery, updateQuery);

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
			DBObject projObj = new BasicDBObject("name", 1);
			DBCursor dbCursor = collection.find(queryObj, projObj);
			List<String> lstPlatform = new ArrayList<>();
			while (dbCursor.hasNext()) {
				DBObject dbObject = dbCursor.next();
				lstPlatform.add((String) dbObject.get("name"));
			}
			return lstPlatform;
		} catch (Exception exception) {
			LOG.equals(exception);
		}
		return null;
	}

}
