package com.affixus.util;

public class Constants {

	public static final String DB_NAME = Config.getProperty("db.name");
	public static final String DB_HOST = Config.getProperty("db.host");
	public static final String DB_PORT_STRRING = Config.getProperty("db.port");
	public static final Integer DB_PORT;

	static {
		// DB port
		DB_PORT = Integer.parseInt(DB_PORT_STRRING);
	}

	public static final String OPERATION = "op";
	public static final String COLLECTION_KEY = "id";
	public static final String JQGRID_EMPTY = "_empty";
	public static final String JQGRID_LEVEL = "level";
	public static final String DEFAULT_BATCHNUMBER = "DEFAULT";

	public enum DBCollectionEnum {
		// @formatter:off
		MAST_CLIENT("mast_client"),
		MAST_RATE("mast_rate"),
		MAST_TAX("mast_tax"),
		ORDER("order"),
		ACCESS_USER("access_user"),
		ACCESS_ROLE("access_role"),
		MAST_PLATFORM("mast_platform")
		;
		// @formatter:on

		private final String collectionName;

		DBCollectionEnum(String collectionName) {
			this.collectionName = collectionName;
		}

		@Override
		public String toString() {
			return collectionName;
		}
	}

	public enum UIOperations {
		// @formatter:off
		VIEW,
		VIEW_ALL,
		ADD,
		EDIT,
		DELETE, 
		REPORT_DATE,
		SAVE,
		ALL_CLIENT_ID;
		// @formatter:on
	}

	public enum PaymentModeEnum {
		// @formatter:off
		CASH,
		DEBIT_CARD,
		CREDIT_CARD,
		DEBIT,
		CREDIT;
		// @formatter:on
	}

}
