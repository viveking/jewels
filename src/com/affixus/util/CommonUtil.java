package com.affixus.util;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.annotate.JsonSerialize.Inclusion;

import com.affixus.util.Constants.DBCollectionEnum;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.QueryOperators;
import com.mongodb.util.JSON;

public class CommonUtil {
	private static final Logger LOG = Logger.getLogger(CommonUtil.class);

	private static Map<String, String> vatTypemap = new LinkedHashMap<>();
	private static Map<String, String> schemeOnMap = new LinkedHashMap<>();
	private static Map<String, String> schemeTypeMap = new LinkedHashMap<>();
	
	public static final String DATE_FORMAT = "dd/MM/yyyy";
	public static final String DATE_FORMAT_ddMMyyyy_HYPHEN = "dd-MM-yyyy";
	public static final String DATE_FORMAT_YY_MM_DD = "yyMMdd";
	public static final String DATETIME_FORMAT_ddMMyyyyHHmmss_HYPHEN = "dd-MM-yyyy hh:mm:ss a";
	

	public static final ObjectMapper mapper = new ObjectMapper();

	static {

		// Put value in vat type map
		vatTypemap.put("1", Config.getProperty("vatType.1"));
		vatTypemap.put("2", Config.getProperty("vatType.2"));
		vatTypemap.put("3", Config.getProperty("vatType.3"));
		vatTypemap.put("4", Config.getProperty("vatType.4"));

		// Put value in scheme type map
		schemeTypeMap.put("1", Config.getProperty("schemeType.1"));
		schemeTypeMap.put("2", Config.getProperty("schemeType.2"));

		// Put value in scheme on map
		schemeOnMap.put("1", Config.getProperty("schemeOn.1"));
		schemeOnMap.put("2", Config.getProperty("schemeOn.2"));

		// JACKSON
		mapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		mapper.setSerializationInclusion(Inclusion.NON_NULL);
		mapper.setSerializationInclusion(Inclusion.NON_EMPTY);
	}

	public static Object jsonToObject(String json, String fullyQualifiedClassName) {

		try {
			Class<?> jsonClass = Class.forName(fullyQualifiedClassName);
			return mapper.readValue(json, jsonClass);
		} catch (JsonGenerationException e) {
			LOG.error(e);
		} catch (JsonMappingException e) {
			LOG.error(e);
		} catch (IOException e) {
			LOG.error(e);
		} catch (ClassNotFoundException e) {
			LOG.error(e);
		}
		return null;
	}

	public static Object jsonToObject(String json, Class<?> clazz) {

		try {
			return mapper.readValue(json, clazz);
		} catch (JsonGenerationException e) {
			LOG.error(e);
		} catch (JsonMappingException e) {
			LOG.error(e);
		} catch (IOException e) {
			LOG.error(e);
		}
		return null;
	}

	public static String objectToJson(Object object) {
		try {

			return mapper.writeValueAsString(object);
			
		} catch (JsonGenerationException e) {
			e.printStackTrace();
			LOG.error(e);
		} catch (JsonMappingException e) {
			e.printStackTrace();
			LOG.error(e);
		} catch (IOException e) {
			e.printStackTrace();
			LOG.error(e);
		}

		return null;
	}

	public static String generateInvoiceNumber() {
		return "";
	}

	public static String getVatTypeJSON() {

		StringBuffer sb = new StringBuffer();
		String separater = "";

		for (Entry<String, String> entry : vatTypemap.entrySet()) {
			sb.append(separater);
			sb.append(entry.getKey());
			sb.append(":");
			sb.append(entry.getValue());
			separater = ";";
		}

		return sb.toString();
	}

	public static String getSchemeTypeJSON() {

		StringBuffer sb = new StringBuffer();
		String separater = "";

		for (Entry<String, String> entry : schemeTypeMap.entrySet()) {
			sb.append(separater);
			sb.append(entry.getKey());
			sb.append(":");
			sb.append(entry.getValue());
			separater = ";";
		}

		return sb.toString();
	}

	public static String getSchemeONJSON() {

		StringBuffer sb = new StringBuffer();
		String separater = "";

		for (Entry<String, String> entry : schemeOnMap.entrySet()) {
			sb.append(separater);
			sb.append(entry.getKey());
			sb.append(":");
			sb.append(entry.getValue());
			separater = ";";
		}

		return sb.toString();
	}

	public static String getIdNameString(DBCollectionEnum dbCollectionEnum, String valueKey, String lableKey) {
		return getIdNameString(dbCollectionEnum, valueKey, lableKey, null);
	}

	/**
	 * @param dbCollectionEnum
	 *            collection name
	 * @param valueKey
	 * @param lableKey
	 * @param (Optional) jsonQuery : Condition string in json format of Mongo DB
	 * @return
	 */
	public static String getIdNameString(DBCollectionEnum dbCollectionEnum, String valueKey, String lableKey, String jsonQuery) {
		try {
			DB mongoDB = MongoUtil.getDB();

			DBCollection collection = mongoDB.getCollection(dbCollectionEnum.toString());
			DBObject dbKey = new BasicDBObject(valueKey, 1).append(lableKey, 1);

			DBObject deletedQuery = MongoUtil.getQueryToCheckDeleted();
			DBObject finalQuery = deletedQuery;

			if (jsonQuery != null && jsonQuery.length() > 0) {
				DBObject optionalQuery = (DBObject) JSON.parse(jsonQuery);
				BasicDBList queryList = new BasicDBList();
				queryList.add(deletedQuery);
				queryList.add(optionalQuery);
				finalQuery = new BasicDBObject(QueryOperators.AND, queryList);
			}

			DBCursor dbCursor = collection.find(finalQuery, dbKey);

			StringBuffer sb = new StringBuffer();
			String separater = "";
			while (dbCursor.hasNext()) {

				BasicDBObject dbObject = (BasicDBObject) dbCursor.next();
				String value = dbObject.getString(valueKey);
				String name = dbObject.getString(lableKey);
				sb.append(separater);
				sb.append(value);
				sb.append(":");
				sb.append(name);
				separater = ";";
			}

			return sb.toString();

		} catch (Exception exception) {
			exception.printStackTrace();
		}

		return "";
	}

	public static String getJSONColumns(DBCollectionEnum dbCollectionEnum, String... projectionColumns) {
		try {
			DB mongoDB = MongoUtil.getDB();

			DBCollection collection = mongoDB.getCollection(dbCollectionEnum.toString());
			DBObject dbKey = new BasicDBObject();
			BasicDBList queryList = new BasicDBList();
			for (String sColumn : projectionColumns) {
				dbKey.put(sColumn, 1);
				queryList.add(new BasicDBObject(sColumn, new BasicDBObject("$exists", true)));
			}

			DBObject deletedQuery = MongoUtil.getQueryToCheckDeleted();
			queryList.add(deletedQuery);

			DBObject finalQuery = new BasicDBObject(QueryOperators.AND, queryList);

			DBCursor dbCursor = collection.find(finalQuery, dbKey);

			String sb = "[]";
			if (dbCursor.hasNext()) {
				sb = JSON.serialize(dbCursor).toString();
			}

			return sb;

		} catch (Exception exception) {
			exception.printStackTrace();
		}

		return "";
	}

	public static String getIdLabelJSON(DBCollectionEnum dbCollectionEnum, String idKey, String lableKey, String jsonQuery) {
		try {
			DB mongoDB = MongoUtil.getDB();

			DBCollection collection = mongoDB.getCollection(dbCollectionEnum.toString());
			DBObject dbKey = new BasicDBObject(idKey, 1).append(lableKey, 1);

			DBObject deletedQuery = MongoUtil.getQueryToCheckDeleted();
			DBObject finalQuery = deletedQuery;

			BasicDBList queryList = new BasicDBList();
			queryList.add(new BasicDBObject(idKey, new BasicDBObject("$exists", true)));
			queryList.add(new BasicDBObject(lableKey, new BasicDBObject("$exists", true)));
			if (jsonQuery != null && jsonQuery.length() > 0) {
				DBObject optionalQuery = (DBObject) JSON.parse(jsonQuery);
				queryList.add(deletedQuery);
				queryList.add(optionalQuery);
			}
			finalQuery = new BasicDBObject(QueryOperators.AND, queryList);

			DBCursor dbCursor = collection.find(finalQuery, dbKey);

			String sb = "[]";
			if (dbCursor.hasNext()) {
				sb = JSON.serialize(dbCursor).toString();
			}

			return sb;

		} catch (Exception exception) {
			exception.printStackTrace();
		}

		return "";
	}

	public static String longToStringDate(Long longValue) {
		return longToStringDate(longValue, DATE_FORMAT);
	}

	public static String longToStringDate(Long longValue, String format) {
		String strDate = "";
		try {
			Date d = null;
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(longValue);
			d = cal.getTime();
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			strDate = sdf.format(d);
		} catch (Exception e) {

		}
		return strDate;
	}

	public static Date stringToDate(String string) {
		return stringToDate(string, DATE_FORMAT);
	}

	public static Date stringToDate(String string, String format) {

		try {
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			return sdf.parse(string);
		} catch (Exception e) {
			return null;
		}
	}

	public static String getFormatedDate(String pattern) {
		String sReturn = "";
		try {
			Calendar insatnce = Calendar.getInstance();

			SimpleDateFormat sdf = new SimpleDateFormat(pattern);
			sReturn = sdf.format(insatnce.getTime());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return sReturn;
	}
}
