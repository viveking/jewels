package com.affixus.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.DateUtil;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;

import com.affixus.pojo.Client;
import com.affixus.pojo.Order;
import com.affixus.pojo.Part;
import com.affixus.pojo.Process;
import com.affixus.services.ClientService;
import com.affixus.services.OrderService;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants;
import com.affixus.util.Constants.UIOperations;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

@WebServlet("/order.action")
public class OrderAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(OrderAction.class);
	private OrderService orderService = null;
	private ClientService clientService = null;
	
	@Override
	public void init() throws ServletException {
		super.init();
		Object object = ObjectFactory.getInstance(ObjectEnum.ORDER_SERVICE);
		if (object instanceof OrderService ) {
			orderService = (OrderService ) object;
		}
		object = ObjectFactory.getInstance(ObjectEnum.CLIENT_SERVICE);
		if (object instanceof ClientService ) {
			clientService = (ClientService) object;
		}
	}
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcessWithException(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcessWithException(request,response);
	}

	private void doProcessWithException(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		try{
			doProcess(request,response);
		}catch(Exception e){
			LOG.error(e);
		}
	}

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		String json = "";
		String operation = request.getParameter(Constants.OPERATION);
		
		if(operation == null || orderService  == null){
			out.write(json);
			out.close();
			return;
		}
		
		Constants.UIOperations opEnum  = UIOperations.valueOf(operation.toUpperCase());
		
		switch (opEnum) {
			case ADD:
				String strDate = request.getParameter("date");
				String printer = request.getParameter("printer");
				Date orderDate = CommonUtil.stringToDate(strDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
							
				
				String jsonOrder = request.getParameter("order");
				if( jsonOrder == null || jsonOrder.trim().isEmpty()){
					break;
				}
				
				ObjectMapper mapper = new ObjectMapper();
				JsonNode jn = mapper.readTree(jsonOrder);
				Map<String, Set<Part> > map = new HashMap<>();
				
				for (JsonNode jsonNode : jn) {
					String clientName = jsonNode.get("clientName").asText();
					String ordername = jsonNode.get("clientOrderName").asText();
					String partName = jsonNode.get("fileName").asText();
					
					String key = clientName+ ":" + ordername;
					
					Part part = new Part();
					part.setName( partName );
					
					if(map.containsKey(key)){
						Set<Part> partSet = map.get(key);
						partSet.add(part);
					}else{
						Set<Part> partSet = new HashSet<>();
						partSet.add(part);
						map.put(key, partSet);
					}
				}
				
				for (Entry<String, Set<Part>> entry : map.entrySet()) {
					String [] strArr = entry.getKey().split(":");
					Order order = new Order();
					order.setOrderName( strArr[1] );
					Client client = clientService.getByClientId( strArr[0] );
					order.setClient( client );
					order.setPrinter(printer);
					order.setOrderDate( orderDate );
					order.setPartList( entry.getValue() );
					
					Boolean isSaved = orderService.create( order );
				}
				
				break;
			case EDIT:
				
				jsonOrder = request.getParameter("order");
				if( jsonOrder == null || jsonOrder.trim().isEmpty()){
					break;
				}
				
				mapper = new ObjectMapper();
				jn = mapper.readTree(jsonOrder);
				Map<String,Order> orderMap = new HashMap<>();
				
				for (JsonNode jsonNode : jn) {
					
					String orderNo = jsonNode.get("_id").asText();
					String selectCAM = jsonNode.get("cam.required").asText();
					String selectRM = jsonNode.get("rm.required").asText();
					String selectCAD = jsonNode.get("cad.required").asText();
					String selectCAST = jsonNode.get("cast.required").asText();
					
					Order ord = new Order();
					ord.set_id(orderNo);
					
					Process process = new Process(Boolean.parseBoolean(selectCAM),0);
					ord.setCam(process);
					process = new Process(Boolean.parseBoolean(selectRM),0);
					ord.setRm(process);
					process = new Process(Boolean.parseBoolean(selectCAD),0);
					ord.setCad(process);
					process = new Process(Boolean.parseBoolean(selectCAST),0);
					ord.setCast(process);
					
					orderService.update(ord);
					
				}
				
				break;
			case VIEW:
					String _id = request.getParameter("_id");
					Order order = orderService.get(_id);
				break;
			
			case VIEW_ALL:
				
				String fromDate = request.getParameter("fromDate");
				String toDate = request.getParameter("toDate");
				
				if(fromDate!= null && null != toDate){
					Date from = CommonUtil.stringToDate(fromDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
					Date to = CommonUtil.stringToDate(toDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
					Set<Order> orderList = orderService.getAll(from,to);
					json=CommonUtil.objectToJson(orderList);
				}else{
					Set<Order> orderList = orderService.getAll();
					json=CommonUtil.objectToJson(orderList);
				}
				break;
				
			default:
				break;
		}
		
		out.write(json);
		out.close();
	}
}
