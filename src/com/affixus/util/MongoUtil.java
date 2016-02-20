package com.affixus.util;

import java.net.UnknownHostException;

import com.affixus.util.Constants.DBCollectionEnum;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoException;
import com.mongodb.util.JSON;

public class MongoUtil {

	private static DB db = null;

	public static DB getDB() {

		if (db == null) {

			MongoClient mongoClient = null;

			try {
				mongoClient = new MongoClient(Constants.DB_HOST, Constants.DB_PORT);
			} catch (UnknownHostException e) {
				e.printStackTrace();
			}

			db = mongoClient.getDB(Constants.DB_NAME);
		}

		return db;
	}

	public static Integer getNextSequence(DBCollectionEnum dbCollectionEnum) {

		String collectionName = dbCollectionEnum.toString();

		DB db = getDB();
		DBCollection collection = db.getCollection("counters");
		DBObject query = new BasicDBObject("_id", collectionName);
		DBObject update = (DBObject) JSON.parse("{ $inc: { seq: 1 } }");

		synchronized (query) {

			DBObject dbObject = collection.findAndModify(query, update);

			if (dbObject == null) {
				dbObject = new BasicDBObject("_id", collectionName).append("seq", 1);
				collection.insert(dbObject);
			}

			dbObject = collection.findOne(query);
			if (dbObject == null) {
				throw new MongoException("Problem to find next sequence");
			}
			return (Integer) dbObject.get("seq");
		}

	}

	public static DBObject getQueryToCheckDeleted() {
		DBObject q1 = new BasicDBObject("deleted", new BasicDBObject("$exists", false));
		DBObject q2 = new BasicDBObject("deleted", null);
		DBObject q3 = new BasicDBObject("deleted", "");
		DBObject q4 = new BasicDBObject("deleted", false);

		BasicDBList orQuery = new BasicDBList();
		orQuery.add(q1);
		orQuery.add(q2);
		orQuery.add(q3);
		orQuery.add(q4);

		DBObject finalQuery = new BasicDBObject("$or", orQuery);
		return finalQuery;
	}

	public static String getNextSequenceByType(String voucherType) {
		// TODO Auto-generated method stub
		String collectionName = voucherType;

		DB db = getDB();
		DBCollection collection = db.getCollection("dynamicCounters");
		DBObject query = new BasicDBObject("_id", collectionName);
		DBObject update = (DBObject) JSON.parse("{ $inc: { seq: 1 } }");

		synchronized (query) {

			DBObject dbObject = collection.findAndModify(query, update);

			if (dbObject == null) {
				dbObject = new BasicDBObject("_id", collectionName).append("seq", 1);
				collection.insert(dbObject);
			}

			dbObject = collection.findOne(query);
			if (dbObject == null) {
				throw new MongoException("Problem to find next sequence");
			}
			return (String) dbObject.get("seq");
		}
	}
}
