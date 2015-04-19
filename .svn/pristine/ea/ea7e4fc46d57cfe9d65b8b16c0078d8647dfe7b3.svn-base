package com.affixus.services;

import java.util.List;

import com.affixus.dao.ClientDao;
import com.affixus.dao.RateDao;
import com.affixus.dao.impl.MongoClientDaoImpl;
import com.affixus.dao.impl.MongoRateDaoImpl;
import com.affixus.pojo.Client;
import com.affixus.pojo.Rate;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

public class RateService {

	private RateDao rateDao;

	public RateService() {
		Object object = ObjectFactory.getInstance(ObjectEnum.RATE_DAO);
		if (object instanceof RateDao) {
			rateDao = (MongoRateDaoImpl) object;
		}
		else{
			try {
				throw new Exception("Problem to initialise MongoAreaDao");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}
	
	public Boolean create(Rate rate) {
		return rateDao.create(rate);
	}

	public Boolean update(Rate rate) {
		return rateDao.update(rate);
	}

	public Boolean delete(String _id) {
		return rateDao.delete(_id);
	}

	public Rate get(String _id) {
		return rateDao.get(_id);
	}

	public List<Rate> getAll() {
		return rateDao.getAll();
	}
	
}
