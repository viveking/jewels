package com.affixus.util.web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class ValidationFilter
 */
@WebFilter(urlPatterns = { "*.action" })
public class AuthFilter implements Filter {
	static String operationration = "";
	
	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		HttpSession session = request.getSession();
		
		Boolean isValidSession  = PortalUtil.isValidSession(session);
		if( !isValidSession ){
			session.setAttribute("SERVER_MESSAGE", "Session has Expired! Please login again!");
			response.sendRedirect("login.jsp");
			return;
		}
		
		Boolean isValidRole  = PortalUtil.validateRole( request.getRequestURI(), session );
		
		if( !isValidRole ){
			session.setAttribute("SERVER_MESSAGE", "You are not alowed to access this action!");
			response.sendRedirect("login.jsp");
			return;
		}
		
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	@Override
	public void init(FilterConfig fConfig) throws ServletException {
	}

	/**
	 * @see Filter#destroy()
	 */
	@Override
	public void destroy() {
	}

}
