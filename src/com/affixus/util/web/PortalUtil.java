package com.affixus.util.web;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.Charset;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.affixus.pojo.auth.User;

public class PortalUtil {

	private static String KEY_USER = "user";
	
	public static User getLoggedUser(HttpSession session) {
		return (User) session.getAttribute(KEY_USER);
	}

	public static void setLoggedUserInSession(HttpServletRequest request, User user) {
		HttpSession session = request.getSession(true);
		session.invalidate();
		session = request.getSession(true);
		session.setAttribute(KEY_USER, user);
		session.setAttribute("SESSION_SET", true);
	}

	public static Boolean isValidSession(HttpSession session) {
		Boolean isTrue = (Boolean) session.getAttribute("SESSION_SET");
		if (isTrue != null && isTrue) {
			return true;
		}
		return false;
	}

	public static Boolean validateRole(String requestURI, HttpSession session) {
		User accessUser = getLoggedUser(session);
		if( accessUser.getUsername().equalsIgnoreCase("admin")  )
		{
			return true;
		}
		
		Set<String> accessList = accessUser.getRole().getAccessList();
		//if( accessList. )
		return null;
	}
	
	public static void writeAjaxResponse(HttpServletResponse response, String string) throws IOException {
		OutputStream outputStream = response.getOutputStream();
		outputStream.write(string.getBytes(Charset.forName("UTF-8")));
		outputStream.flush();
		try {
			outputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}


}
