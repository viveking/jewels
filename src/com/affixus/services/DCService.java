package com.affixus.services;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.affixus.dao.DCDao;
import com.affixus.dao.impl.MongoDCDaoImpl;
import com.affixus.pojo.Client;
import com.affixus.pojo.DC;
import com.affixus.pojo.Order;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

public class DCService {
	private DCDao dcDao;
	
	public DCService(){
		Object object = ObjectFactory.getInstance(ObjectEnum.DC_DAO);
		if (object instanceof DCDao) {
			dcDao = (MongoDCDaoImpl) object;
		}
		else{
			try {
				throw new Exception("Problem to initialise MongoDCDaoImpl");
			} catch (Exception e) {	e.printStackTrace(); }
		}
	}
	
	public boolean create(DC dc) {
		return dcDao.create(dc);
	}

	public DC get(String _id) {
		return dcDao.get(_id);
	}


	public List<Order> getAllInfo(Date from, Date to) {
		return dcDao.getAllInfo(from, to);
	}
	
	public List<Client> getClients(Date from, Date to) {
		return dcDao.getClients(from, to);
	}
	
	public HashMap<String,String> getListOfDCsByClientName(String clientId, Date from, Date to) {
		return dcDao.getListOfDCsByClientName(clientId, from, to);
	}
}
