package com.affixus.dao;

import java.util.List;

import com.affixus.pojo.Client;

public interface ClientDao {

	public Boolean create(Client client);

	public Boolean update(Client client);

	public Boolean delete(String _id);

	/**
	 * Get Area instance, Area instance does not load references instance,
	 * 
	 * @param _id
	 *            AreaDao id to be loaded
	 * @return instance of Area
	 */
	public Client get(String _id);

	/**
	 * Get list of Area instance, Area instance does not load references
	 * instance,
	 * 
	 * @return ArraList of Area
	 */
	public List<Client> getAll();

	/**
	 * Get all client id
	 * @return List<String>
	 */
	public List<String> getAllClientId();

	public Client getByClientId(String clientId);


}
