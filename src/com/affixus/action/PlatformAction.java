package com.affixus.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;

import com.affixus.pojo.Client;
import com.affixus.pojo.Platform;
import com.affixus.services.PlatformService;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants;
import com.affixus.util.Constants.UIOperations;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

/**
 * Servlet implementation class PlatformAction
 */
@WebServlet("/platform.action")
public class PlatformAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(PlatformAction.class);
	private PlatformService platformService = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */

	@Override
	public void init() throws ServletException {
		super.init();
		Object object = ObjectFactory.getInstance(ObjectEnum.PLATFORM_SERVICE);
		if (object instanceof PlatformService) {
			platformService = (PlatformService) object;
		}
	}

	public PlatformAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcessWithException(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcessWithException(request, response);

	}

	private void doProcessWithException(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			doProcess(request, response);
		} catch (Exception e) {
			LOG.error(e);
		}
	}

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		String json = "";
		String operation = request.getParameter(Constants.OPERATION);

		
		Platform platform = new Platform();
		
		//BeanUtils.populate(platform, request.getParameterMap());
		//String id = request.getParameter(Constants.COLLECTION_KEY);

		if (operation == null || platformService == null) {
			out.write(json);
			out.close();
			return;
		}
		Constants.UIOperations opEnum = UIOperations.valueOf(operation.toUpperCase());

		switch (opEnum) {
			case ADD:
				String fromDate = request.getParameter("orderFromDateStr");
				String toDate = request.getParameter("orderToDateStr");

				platform.setPlatformNumber(request.getParameter("platformNumber"));
				platform.setPrinter(request.getParameter("printer"));
				platform.setPlatformPreparedBy(request.getParameter("platformPreparedBy"));
				platform.setPlatformPrintedBy(request.getParameter("platformPrintedBy"));
				
				
				if(fromDate != null)
					platform.setOrderFromDate(CommonUtil.stringToDate(fromDate, CommonUtil.DATETIME_FORMAT_ddMMyyyyHHmmss_HYPHEN));
				if(toDate != null)
					platform.setOrderToDate(CommonUtil.stringToDate(toDate, CommonUtil.DATETIME_FORMAT_ddMMyyyyHHmmss_HYPHEN));
				platformService.create(platform);
				break;
			case EDIT:
				/*if (id != null && !id.equalsIgnoreCase(Constants.JQGRID_EMPTY)) {
					platform.set_id(id);
					platformService.update(platform);
				}*/
				break;
	
			case DELETE:
				/*if (id != null && !id.equalsIgnoreCase(Constants.JQGRID_EMPTY)) {
					platformService.delete(id);
				}*/
				break;
			case VIEW_ALL:
				List<Platform> orderList = platformService.getAll();
				json = CommonUtil.objectToJson(orderList);
				break;
	
			default:
				break;
		}
		out.write(json);
		out.close();
	}
}
