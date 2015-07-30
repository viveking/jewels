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
import com.affixus.pojo.Invoice;
import com.affixus.pojo.Order;
import com.affixus.services.ClientService;
import com.affixus.services.InvoiceService;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

/**
 * Servlet implementation class GenerateInvoice
 */
@WebServlet("/invoice.action")
public class InvoiceAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(OrderAction.class);
	private InvoiceService invoiceService = null;
	private ClientService clientService = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InvoiceAction() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    @Override
    public void init() throws ServletException {
		super.init();
		Object object = ObjectFactory.getInstance(ObjectEnum.INVOICE_SERVICE);
		if (object instanceof InvoiceService ) {
			invoiceService = (InvoiceService ) object;
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
		// TODO Auto-generated method stub
		doProcessWithException(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcessWithException(request,response);
	}

	private void doProcessWithException(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		try{
			doProcess(request,response);
		}catch(Exception e){
			e.printStackTrace();
			LOG.error(e);
		}
	}
	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		String json = "";
		String operation = request.getParameter(Constants.OPERATION);
		if(operation == null || invoiceService  == null){
			out.write(json);
			out.close();
			return;
		}
		//Constants.UIOperations opEnum  = UIOperations.valueOf(operation.toUpperCase());
		switch (operation) {
			case "GET":
				
				break;
			case "GET_ALL_INFO":

				String fromDate = request.getParameter("fromDate");
				String toDate = request.getParameter("toDate");
				Date from=null,to=null;
				if(fromDate!= null && null != toDate){
					from = CommonUtil.stringToDate(fromDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
					to = CommonUtil.stringToDate(toDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
				}
				List<Order> orderList = invoiceService.getAllInfo(from, to);
				json=CommonUtil.objectToJson(orderList);
				
				break;
				
			case "GENERATE":
				
				String jsonOrder = request.getParameter("order");
				if( jsonOrder == null || jsonOrder.trim().isEmpty()){
					break;
				}
				
				ObjectMapper mapper = new ObjectMapper();
				JsonNode jn = mapper.readTree(jsonOrder);
				mapper = new ObjectMapper();
				jn = mapper.readTree(jsonOrder);
				List<String> orderIdList = new ArrayList<>();
				
				Invoice invoice = new Invoice();
				String clientNo = request.getParameter("clientName");
				double discount = Double.parseDouble(request.getParameter("discount"));
				double courierCharges = Double.parseDouble(request.getParameter("courierCharges"));
				double otherCharges = Double.parseDouble(request.getParameter("otherCharges"));
				double gatePassCharges = Double.parseDouble(request.getParameter("gatePassCharges"));
				String invoiceTaxOption = request.getParameter("invoiceTaxOption");
				
				Client client = clientService.getByClientId(clientNo);
				Date date = new Date();
				String invoiceCreationDateStr = CommonUtil.longToStringDate(date.getTime(), CommonUtil.DATE_FORMAT);		
				
				invoice.setClient(client);
				invoice.setDiscount(discount);
				invoice.setCourierCharges(courierCharges);
				invoice.setOtherCharges(otherCharges);
				invoice.setGatePass(gatePassCharges);
				invoice.setInvoiceCreationDate(date);
				invoice.setInvoiceTaxOption(invoiceTaxOption);
				invoice.setInvoiceCreationDateStr(invoiceCreationDateStr);
				
				for (JsonNode jsonNode : jn) {
					String orderNo = jsonNode.get("_id").asText();
					orderIdList.add(orderNo);
				}
				invoice.setOrderIdList(orderIdList);
				
				invoiceService.create(invoice);
				
				break;
			case "GET_CLIENTS":
				
				fromDate = request.getParameter("fromDate");
				toDate = request.getParameter("toDate");
				from=null;to=null;
				if(fromDate!= null && null != toDate){
					from = CommonUtil.stringToDate(fromDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
					to = CommonUtil.stringToDate(toDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
				}
				
				List<Client> clientList = invoiceService.getClients(from, to);
				json=CommonUtil.objectToJson(clientList);
				
				break;
			case "LIST_OF_INVOICES_BY_CLIENT_NAME":
				String clientId = request.getParameter("clientId");
				fromDate = request.getParameter("fromDate");
				toDate = request.getParameter("toDate");
				from=null;to=null;
				if(fromDate!= null && null != toDate){
					from = CommonUtil.stringToDate(fromDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
					to = CommonUtil.stringToDate(toDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
				}
				
				HashMap<String,String> invoiceMap = invoiceService.getListOfInvoicesByClientName(clientId, from, to);
				json=CommonUtil.objectToJson(invoiceMap);
				
				break;
			default:
				break;
		}

		out.write(json);
		out.close();

	}
}
