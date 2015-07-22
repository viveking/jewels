package com.affixus.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;

import com.affixus.pojo.Part;
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
			case SAVE:
				
				String jsonPlatform = request.getParameter("order");
				if( jsonPlatform == null || jsonPlatform.trim().isEmpty()){
					break;
				}
				
				ObjectMapper mapper = new ObjectMapper();
				JsonNode jn = mapper.readTree(jsonPlatform);
				
				for (JsonNode jsonNode : jn) {
					
					String clientId = jsonNode.get("client").asText();
					//String selectCAM = jsonNode.get("cam.required").asText();
					String partName = jsonNode.get("part").asText();
					String platFormNumber = jsonNode.get("platform").asText();
					String weight = jsonNode.get("partWeight").asText();
					//String refWeight = jsonNode.get("supportWeight").asText();
					String status = jsonNode.get("partStatus").asText();
					
					Part part = new Part();
					part.setName(partName);
					part.setPlatFormNumber(platFormNumber);
					part.setWeight(Float.parseFloat(weight));
					//part.setRefWeight(Float.parseFloat(refWeight));
					part.setStatus(status);
					
					platformService.updateParts(clientId, partName, part);
				}
				
				break;
			case SAVE_PARTS_UPDATE:
				
				jsonPlatform = request.getParameter("order");
				if( jsonPlatform == null || jsonPlatform.trim().isEmpty()){
					break;
				}
				
				mapper = new ObjectMapper();
				jn = mapper.readTree(jsonPlatform);
				Set<String> orderIdList = new HashSet<>();
				
				for (JsonNode jsonNode : jn) {
					
					String clientId = jsonNode.get("client").get("clientId").asText();
					String partName = jsonNode.get("partList").get("name").asText();
					String platFormNumber = jsonNode.get("partList").get("platformNumber").asText();
					String weight = jsonNode.get("partList").get("weight").asText();
					//String refWeight = jsonNode.get("partList").get("refWeight").asText();
					String status = jsonNode.get("partList").get("status").asText();
					String orderId = jsonNode.get("_id").asText();
					
					orderIdList.add(orderId);

					Part part = new Part();
					part.setName(partName);
					part.setPlatFormNumber(platFormNumber);
					part.setWeight(Float.parseFloat(weight));
					//part.setRefWeight(Float.parseFloat(refWeight));
					part.setStatus(status);
					
					platformService.updateParts(clientId, partName, part);
				}
				
				platformService.updateCAMAmountByNewWeights(orderIdList);
				
				break;
			case ALL_PLATFORM_ID:
				String status = request.getParameter("status");
				List<String> platformNameList = platformService.getAllPlatformByStatus(status);
				json = CommonUtil.objectToJson(platformNameList);
				break;
			case SAVE_STATUS_UPDATE:

				jsonPlatform = request.getParameter("order");
				String statusString = request.getParameter("status");
				String partStatus="";
				
				if(statusString.equalsIgnoreCase("Completed"))
					partStatus = Constants.PartsStatus.COMPLETED.toString();
				else if(statusString.equalsIgnoreCase("Failed"))
					partStatus = Constants.PartsStatus.FAILED.toString();
				
				if( jsonPlatform == null || jsonPlatform.trim().isEmpty()){
					break;
				}
				
				mapper = new ObjectMapper();
				jn = mapper.readTree(jsonPlatform);
				
				for (JsonNode jsonNode : jn) {
					
					String clientId = jsonNode.get("client.clientId").asText();
					String partName = jsonNode.get("partList.name").asText();
					String platFormNumber = jsonNode.get("partList.platformNumber").asText();
					String weight = jsonNode.get("partList.weight").asText();
					//String refWeight = jsonNode.get("partList.refWeight").asText();
					
					Part part = new Part();
					part.setName(partName);
					part.setPlatFormNumber(platFormNumber);
					part.setWeight(Double.parseDouble(weight));
					//part.setRefWeight(Float.parseFloat(refWeight));
					if(!partStatus.isEmpty())
						part.setStatus(partStatus);
					
					platformService.updateParts(clientId, partName, part);
				}
				
				break;
			default:
				break;
		}
		out.write(json);
		out.close();
	}
}
