package com.affixus.util;

import java.util.HashMap;

import com.affixus.util.Constants.DBCollectionEnum;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class MongoAttributeList {
	
	public static String getRateListByPrinter(String printerType){
		
		String rateMaster = DBCollectionEnum.MAST_RATE.toString();
		DB mongoDB = MongoUtil.getDB();
		
		BasicDBObject query = new BasicDBObject("printerType", printerType);
		DBCollection collection = mongoDB.getCollection(rateMaster);
		DBCursor dbCursor = collection.find(query);
		HashMap<String,String> rateNameMap = new HashMap<>();
		
		while ( dbCursor.hasNext() ) {
			DBObject dbObject = dbCursor.next();
			String name = (String) dbObject.get("name");
			String id = (String) dbObject.get("_id");
			rateNameMap.put(id, name);
		}
		return CommonUtil.objectToJson(rateNameMap);
		
		//return rateName.substring(0, rateName.length() -1);
	}
	
	public static String getPrinterInfo(){
		return "d";
	};
	public static void main(String[] args) {
		System.out.println(MongoAttributeList.getRateListByPrinter("1"));	
		System.out.println(Constants.PrinterValue.INVERSIONHR);
	}
}
