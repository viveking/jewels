/*package com.affixus.services;

import java.util.List;
import com.affixus.pojo.RateList;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

public class RateListService {

	private RateListDao rateListDao;

	public RateListService() {
		Object object = ObjectFactory.getInstance(ObjectEnum.RATE_LIST_DAO);
		if (object instanceof RateListDao) {
			rateListDao = (RateListDao) object;
		}
	}

	public Boolean create(RateList rateList) {
		return rateListDao.create(rateList);
	}

	public Boolean update(RateList rateList) {
		return rateListDao.update(rateList);
	}

	public Boolean delete(String _id) {
		return rateListDao.delete(_id);
	}

	*//**
	 * Get OpeningProductStock instance, OpeningProductStock instance does not
	 * load references instance,
	 * 
	 * @param _id
	 *            product id to be loaded
	 * @return instance of OpeningProductStock
	 *//*
	public RateList get(String _id) {
		return rateListDao.get(_id);
	}

	*//**
	 * @param _id
	 *            product id to be loaded
	 * @param withReferences
	 *            - Boolean, if true product object load its references, if
	 *            false product object does not load its references. (default is
	 *            false)
	 * @return ArraList of products
	 *//*
	public RateList get(String _id, Boolean withReferences) {
		return rateListDao.get(_id, withReferences);
	}

	*//**
	 * Get list of OpeningProductStock instance, OpeningProductStock instance
	 * does not load references instance,
	 * 
	 * @return ArraList of products
	 *//*
	public List<RateList> getAll() {

		List<RateList> all = rateListDao.getAll();
		return all;
	}

	*//**
	 * @param withReferences
	 *            - Boolean, if true product object load its references, if
	 *            false product object does not load its references.(default is
	 *            false)
	 * @return ArraList of products
	 *//*
	public List<RateList> getAll(Boolean withReferences) {
		List<RateList> all = rateListDao.getAll(withReferences);
		return all;
	}

	public List<RateList> getRateListByRate(String rate_id, Boolean withReferences) {
		List<RateList> rateListbyRate = (List<RateList>) rateListDao.get(rate_id, withReferences);
		return rateListbyRate ;
	}

	public List<RateList> getOpeningStockByProduct(String rate_id) {
		List<RateList> rateListbyRate = rateListDao.getRateListByRate(rate_id);
		return rateListbyRate;
	}

}
*/