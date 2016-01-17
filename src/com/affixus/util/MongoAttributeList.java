package com.affixus.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.affixus.pojo.auth.Role;
import com.affixus.services.RoleService;
import com.affixus.util.Constants.DBCollectionEnum;
import com.affixus.util.ObjectFactory.ObjectEnum;
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
	
	public static String getPlatformDBNextSequence(){
		
		String seq = getNextDBSequenceNumber("mast_platform");
		String numberFormat = String.format("%04d", Integer.parseInt(seq));
		return "PF_"+numberFormat;
	}
	
	static String getNextDBSequenceNumber(String collectionName){
	
		String counters = DBCollectionEnum.COUNTERS.toString();
		DB mongoDB = MongoUtil.getDB();
		
		BasicDBObject query = new BasicDBObject("_id", collectionName);
		DBCollection collection = mongoDB.getCollection(counters);
		DBCursor dbCursor = collection.find(query);
		if(dbCursor.hasNext()){
			return dbCursor.next().get("seq").toString();
		}
		return "0";
		
	}
	
	public static String getPrinterInfo(){
		return "d";
	};
	
	public static String getListOfClientsWithDC(){
		
		String clientsCollection = DBCollectionEnum.MAST_CLIENT.toString();
		DB mongoDB = MongoUtil.getDB();
		
		DBObject finalQuery = MongoUtil.getQueryToCheckDeleted();
		finalQuery.put("voucherType", "DC");
		DBCollection collection = mongoDB.getCollection(clientsCollection);
		DBCursor dbCursor = collection.find(finalQuery);
		
		List<HashMap<String,String>> clientList = new ArrayList<>();
		
		while(dbCursor.hasNext()){
			DBObject dbObject = dbCursor.next();
			HashMap<String,String> clientNameMap = new HashMap<>();
			String name = (String) dbObject.get("name");
			String id = (String) dbObject.get("_id");
			clientNameMap.put("name", name);
			clientNameMap.put("id", id);
			clientList.add(clientNameMap);
		}
		return CommonUtil.objectToJson(clientList);
		
	}
	
	public static String getRoleList(){
		
		RoleService roleService = (RoleService) ObjectFactory.getInstance(ObjectEnum.ROLE_SERVICE);
		
		List<Role> roleMList = roleService.getAll();
		HashMap<String,String> roleNameMap = new HashMap<>();
		
		for(Role role : roleMList){
			
			String name = role.getName();
			String id = role.get_id();
			roleNameMap.put(id, name);
			//roleNameMap.put("id", id);
			//roleList.add(roleNameMap);
		}
		
		return CommonUtil.objectToJson(roleNameMap);
	}
	
	public static void main(String[] args) {
		System.out.println(getListOfClientsWithDC());
		System.out.println(Constants.PrinterValue.INVERSIONHR);
	}
}
