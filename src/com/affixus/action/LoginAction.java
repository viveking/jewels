package com.affixus.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.affixus.pojo.auth.User;
import com.affixus.services.UserService;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;
import com.affixus.util.web.PortalUtil;

/**
 * Servlet implementation class LoginAction
 */
@WebServlet("/login")
public class LoginAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(LoginAction.class);
	private UserService userService = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    
	@Override
	public void init() throws ServletException {
		super.init();
		Object object = ObjectFactory.getInstance(ObjectEnum.USER_SERVICE);
		if (object instanceof UserService ) {
			userService = (UserService ) object;
		}
	}
	public LoginAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
			doProcess(request,response);
		}catch(Exception e){
			LOG.error(e);
		}
	}

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		User user = userService.auth(username, password);
		if ( user == null ) {
			session.setAttribute("SERVER_MESSAGE", "Invalid credentials - authentication failed!");
			response.sendRedirect("login.jsp");
			return;
		}
		
		PortalUtil.setLoggedUserInSession(request, user);
		response.sendRedirect("hometmp.jsp");
		return;
	}
}
