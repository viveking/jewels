package com.affixus.dao;

import com.affixus.pojo.Order;


public interface OrderDao {
	
	public Boolean update(Order rate);

	public Boolean create(Order rate);

	public Boolean delete(String _id);

}
