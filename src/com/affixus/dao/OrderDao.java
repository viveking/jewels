package com.affixus.dao;

import java.util.Date;
import java.util.List;
import java.util.Set;

import com.affixus.pojo.Order;


public interface OrderDao {
	
	public Boolean update(Order rate);

	public Boolean create(Order rate);

	public Boolean delete(String _id);

	public Order get(String _id);
	
	public Set<Order> getAllByOperation(Date fromDate, Date toDate, String operation);
	
	public Set<String> getOrderInfoByPlatform(String platformNumber);
	
	public List<Order> getCompletedOrderInfoByClient(String clientId);
	
	public List<Order> getCompletedOrderInfoByPlatform(String platformNumber);

	Set<Order> getAll(String[] status);

	Set<Order> getAll(String[] status, Date fromDate, Date toDate);

	Set<String> getOrderInfoByClient(String clientId, Date from, Date to);
	
	public Set<String> getAllOrderInfoByPlatform(String platformNumber);
	
}
