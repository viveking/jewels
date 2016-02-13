package com.affixus.dao;

import java.util.List;
import java.util.Set;

import com.affixus.pojo.Part;
import com.affixus.pojo.Platform;

public interface PlatformDao {

	public Boolean create(Platform platform);

	public Boolean update(Platform platform);

	public Boolean delete(String _id);
	
	public List<Platform> getAll();
	
	public Boolean updateParts(String clientId, String partName, Part part);
	
	public List<String> getAllPlatformByStatus(String status);
	
	public Boolean updateCAMAmountByNewWeights(List<String> orderIdList);
	
	public Boolean updateRMAmountByNewWeights(List<String> orderIdList);
	
	public void checkPlatformCompletion(String pfName);
}
