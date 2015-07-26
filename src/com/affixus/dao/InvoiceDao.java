package com.affixus.dao;

import java.util.Date;
import java.util.List;

import com.affixus.pojo.Invoice;
import com.affixus.pojo.Order;

public interface InvoiceDao {
	
	public boolean create(Invoice invoice);
	
	public Invoice get(String _id);
	
	public List<Order> getAllInfo(Date from, Date to);

}
