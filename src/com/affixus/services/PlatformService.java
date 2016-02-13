package com.affixus.services;

import java.util.List;

import com.affixus.dao.PlatformDao;
import com.affixus.dao.impl.MongoPlatformDaoImpl;
import com.affixus.pojo.Part;
import com.affixus.pojo.Platform;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

public class PlatformService {
	
	private PlatformDao platformDao;
	
	public PlatformService(){
		Object object = ObjectFactory.getInstance(ObjectEnum.PLATFORM_DAO);
		if (object instanceof PlatformDao) {
			platformDao = (MongoPlatformDaoImpl) object;
		}
		else{
			try {
				throw new Exception("Problem to initialise MongoPlatformDao");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public Boolean create(Platform platform) {
		return platformDao.create(platform);
	}
	public Boolean delete(String _id) {
		return platformDao.delete(_id);
	}
	public List<Platform> getAll() {
		return platformDao.getAll();
	}

	public Boolean update(Platform platform) {
		return platformDao.update(platform);
	}
	public Boolean updateParts(String clientId, String partName, Part part) {
		return platformDao.updateParts(clientId,partName, part);
		//return platformDao.updateCAMAmountByNewWeights(clientId);
	}
	
	public Boolean updateCAMAmountByNewWeights(List<String> orderIdList){
		return platformDao.updateCAMAmountByNewWeights(orderIdList);
	}
	
	public Boolean updateRMAmountByNewWeights(List<String> orderIdList){
		return platformDao.updateRMAmountByNewWeights(orderIdList);
	}
	
	public List<String> getAllPlatformByStatus(String status){
		return platformDao.getAllPlatformByStatus(status);
	}

	public void checkPlatformCompletion(String pfName) {
		 platformDao.checkPlatformCompletion(pfName);
	}
}
