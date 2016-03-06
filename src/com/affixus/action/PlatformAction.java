package com.affixus.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;

import com.affixus.pojo.Order;
import com.affixus.pojo.Part;
import com.affixus.pojo.Platform;
import com.affixus.pojo.Process;
import com.affixus.services.OrderService;
import com.affixus.services.PlatformService;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants;
import com.affixus.util.Constants.UIOperations;
import com.affixus.util.MongoUtil;
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
	private OrderService orderService = null;

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
		object = ObjectFactory.getInstance(ObjectEnum.ORDER_SERVICE);
		if (object instanceof OrderService) {
			orderService = (OrderService) object;
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
				createPlatform(request, platform);
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
				List<Platform> platformList = platformService.getAll();
				json = CommonUtil.objectToJson(platformList);
				break;
			case SAVE:
				
				String jsonPlatform = request.getParameter("order");
				if( jsonPlatform == null || jsonPlatform.trim().isEmpty()){
					break;
				}
				String platformId = createPlatform(request, platform);
				if(platformId != ""){
					MongoUtil.getNextSequenceByType("PLATFORM");
				}
				ObjectMapper mapper = new ObjectMapper();
				JsonNode jn = mapper.readTree(jsonPlatform);
				//String platformNumber = null;
				for (JsonNode jsonNode : jn) {
					
					String clientId = jsonNode.get("client").asText();
					//String selectCAM = jsonNode.get("cam.required").asText();
					String partName = jsonNode.get("part").asText();
					//platformNumber = jsonNode.get("platform").asText();
					String weight = jsonNode.get("partWeight").asText();
					//String refWeight = jsonNode.get("supportWeight").asText();
					String status = jsonNode.get("partStatus").asText();
					
					Part part = new Part();
					part.setName(partName);
					part.setPlatformNumber(platformId);
					part.setWeight(Double.parseDouble(weight));
					//part.setRefWeight(Float.parseFloat(refWeight));
					part.setStatus(status);
					
					platformService.updateParts(clientId, partName, part);
				}
				if(platformId != "")
					platformService.checkPlatformCompletion(platformId);
				//platformService.updateCAMAmountByNewWeights(orderIdList);
				break;
			case SAVE_ORDER_UPDATE:

				jsonPlatform = request.getParameter("order");
				if( jsonPlatform == null || jsonPlatform.trim().isEmpty()){
					break;
				}
				
				mapper = new ObjectMapper();
				jn = mapper.readTree(jsonPlatform);
				List<String> orderIdList = new ArrayList<>();
				
				for (JsonNode jsonNode : jn) {
					
					String orderId = jsonNode.get("_id").asText();
					
					Order order = new Order();
					orderIdList.add(orderId);
					//Order order =orderService.get(orderId);
					order.set_id(orderId);
					
					Process cadprocess = new Process();
					cadprocess.setAmount(Double.parseDouble(jsonNode.get("cad").get("amount").asText()));
					cadprocess.setRequired(Boolean.parseBoolean(jsonNode.get("cad").get("required").asText()));
					cadprocess.setWeight(Double.parseDouble(jsonNode.get("cad").get("weight").asText()));
					
					Process camprocess = new Process();
					camprocess.setAmount(Double.parseDouble(jsonNode.get("cam").get("amount").asText()));
					camprocess.setRequired(Boolean.parseBoolean(jsonNode.get("cam").get("required").asText()));
					camprocess.setWeight(Double.parseDouble(jsonNode.get("cam").get("weight").asText()));
					
					Process castprocess = new Process();
					castprocess.setAmount(Double.parseDouble(jsonNode.get("cast").get("amount").asText()));
					castprocess.setRequired(Boolean.parseBoolean(jsonNode.get("cast").get("required").asText()));
					castprocess.setWeight(Double.parseDouble(jsonNode.get("cast").get("weight").asText()));
					
					Process rmprocess = new Process();
					rmprocess.setAmount(Double.parseDouble(jsonNode.get("rm").get("amount").asText()));
					rmprocess.setRequired(Boolean.parseBoolean(jsonNode.get("rm").get("required").asText()));
					rmprocess.setWeight(Double.parseDouble(jsonNode.get("rm").get("weight").asText()));
					
					order.setStatus(Constants.PartsStatus.COMPLETED.toString());
					order.setCad(cadprocess);
					order.setCam(camprocess);
					order.setRm(rmprocess);
					order.setCast(castprocess);
					
					orderService.update(order);
				}
				
				platformService.updateCAMAmountByNewWeights(orderIdList);
				platformService.updateRMAmountByNewWeights(orderIdList);
				break;
			case ALL_PLATFORM_ID:
				String status = request.getParameter("status");
				Map<String,String> platformNameMap = platformService.getAllPlatformByStatus(status);
				json = CommonUtil.objectToJson(platformNameMap);
				break;
			
			default:
				break;
		}
		out.write(json);
		out.close();
	}

	private String createPlatform(HttpServletRequest request, Platform platform) {
		String fromDate = request.getParameter("orderFromDateStr");
		String toDate = request.getParameter("orderToDateStr");

		platform.setPlatformNumber(request.getParameter("platformNumber"));
		platform.setPrinter(request.getParameter("printer"));
	
		if(fromDate != null && !"".equals(fromDate))
			platform.setOrderFromDate(CommonUtil.stringToDate(fromDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN));
		if(toDate != null && !"".equals(toDate))
			platform.setOrderToDate(CommonUtil.stringToDate(toDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN));
		String platformId = platformService.create(platform);
		return platformId;
	}
}
