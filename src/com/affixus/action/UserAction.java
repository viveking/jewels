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
import com.affixus.pojo.auth.User;
import com.affixus.services.RoleService;
import com.affixus.services.UserService;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants;
import com.affixus.util.Constants.UIOperations;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;
import com.affixus.util.web.PortalUtil;

/**
 * Servlet implementation class AccessUserAction
 */
@WebServlet("/usermaster.action")
public class UserAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(UserAction.class);
	private UserService userService = null;
	private RoleService roleService = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserAction() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    public void init() throws ServletException {
    	super.init();
    	Object object = ObjectFactory.getInstance(ObjectEnum.ROLE_SERVICE);
		if (object instanceof RoleService ) {
			roleService = (RoleService) object;
		}
		
		object = ObjectFactory.getInstance(ObjectEnum.USER_SERVICE);
		if (object instanceof UserService ) {
			userService = (UserService ) object;
		}
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
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
		
		Constants.UIOperations opEnum  = UIOperations.valueOf(operation.toUpperCase());
		String id = request.getParameter(Constants.COLLECTION_KEY);
		User user = new User();
		BeanUtils.populate(user, request.getParameterMap() );
		switch (opEnum) {
		case ADD:
			String roleId = request.getParameter("roleId");
			User oldUser = userService.get( user.getUsername() );
			
			if( oldUser != null) // already exist
			{
				PortalUtil.writeAjaxResponse(response, "");
				return;
			}
			
			Role role = roleService.get(roleId);
			user.setRole( role );
			user.setApproved(true);
			user.setLocked(false);
			user.setCredentialExpired(true);
			user.setForceChangePassword(true);
			Boolean b = userService.add(user);
			
			if ( b == false ) {
				PortalUtil.writeAjaxResponse(response, "");
				return;
			}
			break;
		case EDIT :
			if(id != null && !id.equalsIgnoreCase(Constants.JQGRID_EMPTY)) {
				user.set_id(id);
				userService.update(user);
			}	 
			break;	
			
		case DELETE :
			if(id != null && !id.equalsIgnoreCase(Constants.JQGRID_EMPTY)) {
				userService.delete(id);
			}
			break;

		case VIEW :
			
			break;	
			
		case VIEW_ALL :
			
			List<User> userList = userService.getAll();
			String json = CommonUtil.objectToJson(userList);
			json = json.replaceAll("_id", "id");
			PortalUtil.writeAjaxResponse(response, json);
			break;
		default:
			break;
		}
		
	}

}
