package com.affixus.services;

import java.util.Date;
import java.util.List;
import java.util.Set;

import com.affixus.dao.OrderDao;
import com.affixus.dao.impl.MongoOrderDaoImpl;
import com.affixus.pojo.Order;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

public class OrderService {
	private OrderDao orderDao;

	public OrderService() {
		Object object = ObjectFactory.getInstance(ObjectEnum.ORDER_DAO);
		if (object instanceof OrderDao) {
			orderDao = (MongoOrderDaoImpl) object;
		}
		else{
			try {
				throw new Exception("Problem to initialise MongoAreaDao");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public Boolean create(Order order) 
	{
		return orderDao.create(order);
	}
	
	public Order get(String _Id) 
	{
		return orderDao.get(_Id);
	}
	public Set<Order> getAll(String status[]) {
		return orderDao.getAll(status);
	}
	
	public Set<Order> getAll(String status[],Date from, Date to) {
		return orderDao.getAll(status,from,to);
	}
	
	public Set<Order> getAllByOperation(Date from, Date to, String operation) {
		return orderDao.getAllByOperation(from,to,operation);
	}
	
	public Boolean update(Order ord) {
		return orderDao.update(ord);
	}

	public Set<String> getOrderInfoByClient(String clientId, Date from, Date to) {
		return orderDao.getOrderInfoByClient(clientId,from,to);	
	}
	
	public Set<String> getOrderInfoByPlatform(String platformNumber) {
		return orderDao.getOrderInfoByPlatform(platformNumber);	
	}
	
	public List<Order> getCompletedOrderInfoByClient(String clientId){
		return orderDao.getCompletedOrderInfoByClient(clientId);
	}
	
	public List<Order> getCompletedOrderInfoByPlatform(String platformNumber) {
		return orderDao.getCompletedOrderInfoByPlatform(platformNumber);	
	}
	
	public Set<String> getAllOrderInfoByPlatform(String platformNumber) {
		return orderDao.getAllOrderInfoByPlatform(platformNumber);	
	}
	
}
