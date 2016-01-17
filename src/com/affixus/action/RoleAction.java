package com.affixus.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;

import com.affixus.pojo.auth.Role;
import com.affixus.services.RoleService;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants;
import com.affixus.util.Constants.UIOperations;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;
import com.affixus.util.web.PortalUtil;

/**
 * Servlet implementation class ResisterUser
 */
@WebServlet("/rolemaster.action")
public class RoleAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(RoleAction.class);
	private RoleService roleService = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    
	@Override
	public void init() throws ServletException {
		super.init();
		Object object = ObjectFactory.getInstance(ObjectEnum.ROLE_SERVICE);
		if (object instanceof RoleService ) {
			roleService = (RoleService) object;
		}
	}
	public RoleAction() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			doProcess(request,response);
		}catch(Exception e){
			LOG.error(e);
		}
	}

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String operation = request.getParameter(Constants.OPERATION);
		
		if(operation == null )
		{
			PortalUtil.writeAjaxResponse(response, "");
			return;
		}

		Role role = new Role();
		BeanUtils.populate(role, request.getParameterMap() );
		
		Constants.UIOperations opEnum  = UIOperations.valueOf(operation.toUpperCase());
		String id = request.getParameter(Constants.COLLECTION_KEY);
		
		switch (opEnum) {
		case ADD:
	
			roleService.add(role);
			break;
		case EDIT :
			if(id != null && !id.equalsIgnoreCase(Constants.JQGRID_EMPTY)) {
				role.set_id(id);
				roleService.update(role);
			}	 
			break;	
			
		case DELETE :
			if(id != null && !id.equalsIgnoreCase(Constants.JQGRID_EMPTY)) {
				roleService.delete(id);
			}
			break;

		case VIEW :
			
			break;	
			
		case VIEW_ALL :
			
			List<Role> roleList = roleService.getAll();
			String json = CommonUtil.objectToJson(roleList);
			json = json.replaceAll("_id", "id");
			PortalUtil.writeAjaxResponse(response, json);
			break;
		default:
			break;
		}
	}

}
