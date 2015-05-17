package com.affixus.services;

import java.util.List;

import com.affixus.dao.ClientDao;
import com.affixus.dao.impl.MongoClientDaoImpl;
import com.affixus.pojo.Client;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

public class ClientService {

	private ClientDao clientDao;

	public ClientService() {
		Object object = ObjectFactory.getInstance(ObjectEnum.CLIENT_DAO);
		if (object instanceof ClientDao) {
			clientDao = (MongoClientDaoImpl) object;
		}
		else{
			try {
				throw new Exception("Problem to initialise MongoAreaDao");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}
	
	public Boolean create(Client client) {
		return clientDao.create(client);
	}

	public Boolean update(Client client) {
		return clientDao.update(client);
	}

	public Boolean delete(String _id) {
		return clientDao.delete(_id);
	}

	public Client get(String _id) {
		return clientDao.get(_id);
	}

	public List<Client> getAll() {
		return clientDao.getAll();
	}
	public List<String> getAllClientId() {
		return clientDao.getAllClientId();
	}	
}
