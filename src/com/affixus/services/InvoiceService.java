package com.affixus.services;

import java.util.Date;
import java.util.List;

import com.affixus.dao.InvoiceDao;
import com.affixus.dao.impl.MongoInvoiceDaoImpl;
import com.affixus.pojo.Client;
import com.affixus.pojo.Invoice;
import com.affixus.pojo.Order;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

public class InvoiceService {
	private InvoiceDao invoiceDao;
	
	public InvoiceService(){
		Object object = ObjectFactory.getInstance(ObjectEnum.INVOICE_DAO);
		if (object instanceof InvoiceDao) {
			invoiceDao = (MongoInvoiceDaoImpl) object;
		}
		else{
			try {
				throw new Exception("Problem to initialise MongoInvoiceDaoImpl");
			} catch (Exception e) {	e.printStackTrace(); }
		}
	}
	
	public boolean generateInvoice(List<Order> orderDetails) {
		return invoiceDao.generateInvoice(orderDetails);
	}

	public Invoice get(String _id) {
		return invoiceDao.get(_id);
	}

	public List<Order> getAllInfoByClient(Date from, Date to, String clientId) {
		return invoiceDao.getAllInfoByClient(from, to, clientId);
	}

	public List<Order> getAllInfo(Date from, Date to) {
		return invoiceDao.getAllInfo(from, to);
	}

}
