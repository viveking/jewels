package com.affixus.util;

import java.util.HashMap;
import java.util.Map;

import com.affixus.dao.impl.MongoClientDaoImpl;
import com.affixus.dao.impl.MongoRateDaoImpl;
import com.affixus.services.ClientService;
import com.affixus.services.RateService;

public class ObjectFactory {

	private static final Map<ObjectEnum, Object> objectFactoryMap = new HashMap<ObjectEnum, Object>();

	public static enum ObjectEnum {
		//@formatter:off
		// DAOs
		CLIENT_DAO(MongoClientDaoImpl.class.getName()),
		RATE_DAO(MongoRateDaoImpl.class.getName()),
		
		// Services
		CLIENT_SERVICE(ClientService.class.getName()),
		RATE_SERVICE(RateService.class.getName());
		//@formatter:on

		private final String className;

		ObjectEnum(String className) {
			this.className = className;
		}

		@Override
		public String toString() {
			return className;
		}
	}

	public static Object getInstance(ObjectEnum objectEnum) {
		Object instance = null;
		try {
			instance = objectFactoryMap.get(objectEnum);
			if (instance == null) {
				Class<?> clazz = Class.forName(objectEnum.toString());
				instance = clazz.newInstance();
				objectFactoryMap.put(objectEnum, instance);
			}

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}

		return instance;
	}

	/*
	 * public static void main(String[] args) { BaseDao baseDao =
	 * DaoFactory.getDaoInstance(DaoEnum.CUSTOMER_DAO); CustomerDao customerDao
	 * = (CustomerDao) baseDao; System.out.println(customerDao);
	 * 
	 * }
	 */

}
