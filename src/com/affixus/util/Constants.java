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
		MAST_MAIN_ACCOUNT("mast_main_account"),
		MAST_CUSTOMER("mast_customer"),
		MAST_AREA("mast_area"),
		MAST_RATE("mast_rate"),
		MAST_LIST("mast_rateList"),
		MAST_BEAT("mast_beat"),
		MAST_MANUFACTURER("mast_manufacturer"),
		MAST_ACCESS_USER("mast_access_user"),
		MAST_TAX("mast_tax"),
		MAST_PRODUCT_GROUP("mast_product_group"), 
		MAST_PRODUCT("mast_product"), 
		MAST_SUPPLIER("mast_supplier"),
		PRODUCT_INVENTORY("product_inventory"),
		OPENING_PRODUCT_STOCK("opening_product_stock"),
		MAST_PRODUCT_SCHEME("mast_product_scheme"),
		
		SALES_INVOICE("sales_invoice"),
		PURCHASE_INVOICE("purchase_invoice");
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
		REPORT_DATE;
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
