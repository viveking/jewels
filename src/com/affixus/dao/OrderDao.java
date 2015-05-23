package com.affixus.dao;

import java.util.Set;

import com.affixus.pojo.Order;


public interface OrderDao {
	
	public Boolean update(Order rate);

	public Boolean create(Order rate);

	public Boolean delete(String _id);

	public Order get(String _id);

	public Set<Order> getAll();	

}
