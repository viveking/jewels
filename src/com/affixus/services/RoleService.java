package com.affixus.services;

import java.util.List;

import com.affixus.dao.RoleDAO;
import com.affixus.dao.impl.MongoRoleDaoImpl;
import com.affixus.pojo.auth.Role;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

public class RoleService {
	private RoleDAO roleDAO;
	
	public RoleService(){
		Object object = ObjectFactory.getInstance(ObjectEnum.ROLE_DAO);
		if (object instanceof RoleDAO) {
			roleDAO = (MongoRoleDaoImpl) object;
		}
		else{
			try {
				throw new Exception("Problem to initialise MongoRoleDao");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public Role get(String _id)
	{
		return roleDAO.get(_id);
	}
	public Boolean update(Role role) {
		return roleDAO.update(role);
	}

	public Boolean delete(String _id) {
		return roleDAO.delete(_id);
	}

	public List<Role> getAll() {
		return roleDAO.getAll();
	}

	public Boolean add(Role role) {
		return roleDAO.add(role);
	}
}
