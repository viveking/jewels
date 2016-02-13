package com.affixus.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;

import com.affixus.pojo.Client;
import com.affixus.pojo.DC;
import com.affixus.pojo.Order;
import com.affixus.pojo.PrintDC;
import com.affixus.services.ClientService;
import com.affixus.services.DCService;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants;
import com.affixus.util.NumberToWord;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

/**
 * Servlet implementation class DeliveryChalan
 */
@WebServlet("/dc.action")
public class DCAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(DCAction.class);
	private DCService dcService = null;
	private ClientService clientService = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DCAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public void init() throws ServletException {
		super.init();
		Object object = ObjectFactory.getInstance(ObjectEnum.DC_SERVICE);
		if (object instanceof DCService) {
			dcService = (DCService) object;
		}
		object = ObjectFactory.getInstance(ObjectEnum.CLIENT_SERVICE);
		if (object instanceof ClientService ) {
			clientService = (ClientService) object;
		}

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcessWithException(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcessWithException(request, response);
	}

	private void doProcessWithException(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			doProcess(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e);
		}
	}

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		String json = "";
		String operation = request.getParameter(Constants.OPERATION);
		if (operation == null || dcService == null) {
			out.write(json);
			out.close();
			return;
		}
		// Constants.UIOperations opEnum =
		// UIOperations.valueOf(operation.toUpperCase());
		switch (operation) {
		case "GET":
			String dcId = request.getParameter("_id");
			DC dc = dcService.get(dcId);
			PrintDC printDC = new PrintDC();
			printDC.setDc(dc);
			
			List<Order> orderListl = dc.getOrderList();
			float grandTotal=0,grossTotal=0;
			
			List<String> totalProcessesAvail = new ArrayList<>();
			
			boolean rm = false,cad= false,cam= false,cast= false;
			for(Order ord:orderListl){
				ord.setT_charges(
						ord.getCad().getAmount()+
						ord.getRm().getAmount()+
						ord.getCam().getAmount()+
						ord.getCast().getAmount()
						);
				
				grossTotal+=ord.getT_charges();
				
				if(cam == false && ord.getCam().isRequired() == true){cam = true; totalProcessesAvail.add("cam");}
				if(rm == false && ord.getRm().isRequired() == true){rm = true; totalProcessesAvail.add("rm");}
				if(cad == false && ord.getCad().isRequired() == true){cad = true; totalProcessesAvail.add("cad");}
				if(cast == false && ord.getCast().isRequired() == true){cast = true; totalProcessesAvail.add("cast");}
				
			}
			grandTotal = grossTotal;
			printDC.setGrandTotal(grandTotal);
			printDC.setAmountInWords(new NumberToWord().convertNumberToWords((int)grandTotal));
			
			printDC.setTotalProcessesAvail(totalProcessesAvail);
			printDC.setGross(grossTotal);
			
			json = CommonUtil.objectToJson(printDC);

			break;
		case "GET_ALL_INFO":

			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			Date from=null,to=null;
			if(fromDate!= null && null != toDate){
				from = CommonUtil.stringToDate(fromDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
				to = CommonUtil.stringToDate(toDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
			}
			
			List<Order> orderList = dcService.getAllInfo(from, to);
			json=CommonUtil.objectToJson(orderList);
			
			break;

		case "GET_CLIENTS":
			
			fromDate = request.getParameter("fromDate");
			toDate = request.getParameter("toDate");
			from=null;to=null;
			if(fromDate!= null && null != toDate){
				from = CommonUtil.stringToDate(fromDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
				to = CommonUtil.stringToDate(toDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
			}
			
			List<Client> clientList = dcService.getClients(from, to);
			json=CommonUtil.objectToJson(clientList);
			
			break;
		case "LIST_OF_DCS_BY_CLIENT_NAME":
			String clientId = request.getParameter("clientId");
			fromDate = request.getParameter("fromDate");
			toDate = request.getParameter("toDate");
			from=null;to=null;
			if(fromDate!= null && null != toDate){
				from = CommonUtil.stringToDate(fromDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
				to = CommonUtil.stringToDate(toDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
			}
			
			HashMap<String,String> dcMap = dcService.getListOfDCsByClientName(clientId, from, to);
			json=CommonUtil.objectToJson(dcMap);
			
			break;
		
		case "GENERATE":

			String jsonOrder = request.getParameter("order");
			if (jsonOrder == null || jsonOrder.trim().isEmpty()) {
				break;
			}

			ObjectMapper mapper = new ObjectMapper();
			JsonNode jn = mapper.readTree(jsonOrder);
			mapper = new ObjectMapper();
			jn = mapper.readTree(jsonOrder);
			List<String> orderIdList = new ArrayList<>();

			dc = new DC();
			String clientNo = request.getParameter("clientName");
			double rmCount = Double.parseDouble(request.getParameter("rmCount"));
			
			Client client = clientService.getByClientId(clientNo);
			Date date = new Date();
			String dcCreationDateStr = CommonUtil.longToStringDate(date.getTime(), CommonUtil.DATE_FORMAT);

			dc.setClient(client);
			dc.setDcCreationDate(date);
			dc.setDcCreationDateStr(dcCreationDateStr);
			dc.setRmCount(rmCount);
			
			for (JsonNode jsonNode : jn) {
				String orderNo = jsonNode.get("_id").asText();
				orderIdList.add(orderNo);
			}
			dc.setOrderIdList(orderIdList);

			dcService.create(dc);

			break;
		}
		out.write(json);
		out.close();

	}
}
