package com.affixus.services;

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
	public Set<Order> getAll() {
		return orderDao.getAll();
	}

	public Boolean update(Order ord) {
		return orderDao.update(ord);
	}
}
