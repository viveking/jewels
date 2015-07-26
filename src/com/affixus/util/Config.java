package com.affixus.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.Enumeration;
import java.util.Properties;
import java.util.TreeMap;

import org.apache.log4j.Logger;

public class Config {
	private static final Logger LOG = Logger.getLogger(Config.class);
	private static final String CONFIG_FILE_NAME = "config.properties";
	private static Properties properties = null;
	public static TreeMap<String,String> printerNames = new TreeMap<String, String>();
	
	static {
		properties = new Properties();
		try {
			String currentClasspath = getCurrentClasspath();
			String fullConfigFilePath = currentClasspath + File.separator + CONFIG_FILE_NAME;
			properties.load(new FileInputStream(new File(fullConfigFilePath)));
			
			Enumeration<?> e = properties.propertyNames();
			while (e.hasMoreElements()) {
				String key = (String) e.nextElement();
				if(key.contains("printerList")){
					
					String printerCode = key.replace("printerList.", "");
					String value = properties.getProperty(key);
					//System.out.println(printerCode);
					printerNames.put(printerCode, value);
				}
				
			}
			
		} catch (Exception e) {
			LOG.error(e);
		}
	}

	public static String getProperty(String key) {
		try {
			return properties.getProperty(key);
		} catch (Exception e) {
			LOG.error(e);
		}
		return null;
	}

	public static String getProperty(String key, String defaultValue) {
		try {
			return properties.getProperty(key, defaultValue);
		} catch (Exception e) {
			LOG.error(e);
		}
		return null;
	}

	public static String getCurrentClasspath() throws UnsupportedEncodingException {
		ClassLoader loader = Thread.currentThread().getContextClassLoader();
		URL resource = loader.getResource("");
		LOG.info(resource.getPath());
		return URLDecoder.decode(resource.getPath(), "UTF-8");
	}

	public static void main(String[] args) {
		//System.out.println(Config.getProperty("db.name"));
		System.out.println(Config.printerNames.toString());
	}
}
