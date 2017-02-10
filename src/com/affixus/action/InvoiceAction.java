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
import com.affixus.pojo.PrintInvoice;
import com.affixus.services.ClientService;
import com.affixus.services.InvoiceService;
import com.affixus.services.PlatformService;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants;
import com.affixus.util.NumberToWord;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

/**
 * Servlet implementation class GenerateInvoice
 */
@WebServlet("/invoice.action")
public class InvoiceAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(InvoiceAction.class);
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
				String invoiceId = request.getParameter("_id");
				Invoice inv = invoiceService.get(invoiceId);
				List<String> orderIdList = inv.getOrderIdList();
				
				PlatformService platformService = (PlatformService) ObjectFactory.getInstance(ObjectEnum.PLATFORM_SERVICE);
				platformService.updateCAMAmountByNewWeights(orderIdList);
				platformService.updateRMAmountByNewWeights(orderIdList);
				
				inv = invoiceService.get(invoiceId);
				
				PrintInvoice printInvoice = new PrintInvoice();
				printInvoice.setInvoice(inv);
				
				List<Order> orderListl = inv.getOrderList();
				float grandTotal=0,grossTotal=0,taxAmount = 0;
				
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
				printInvoice.setTotalProcessesAvail(totalProcessesAvail);
				printInvoice.setGross(grossTotal);
				
				if(inv.getInvoiceTaxOption().equalsIgnoreCase("TI0%")){
					taxAmount = 0;
				}else if(inv.getInvoiceTaxOption().equalsIgnoreCase("TI1%")){
					taxAmount = (float) ((grossTotal- inv.getDiscount()) * 0.01);
				}else if(inv.getInvoiceTaxOption().equalsIgnoreCase("TI12.5%")){
					taxAmount = (float) ((grossTotal- inv.getDiscount()) * 0.125);
				}else if(inv.getInvoiceTaxOption().equalsIgnoreCase("TI13.5%")){
					taxAmount = (float) ((grossTotal- inv.getDiscount()) * 0.135);
				}else if(inv.getInvoiceTaxOption().equalsIgnoreCase("TI14%")){
					taxAmount = (float) ((grossTotal- inv.getDiscount()) * 0.14);
				}else if(inv.getInvoiceTaxOption().equalsIgnoreCase("ES0%")){
					taxAmount = 0;
				}else if(inv.getInvoiceTaxOption().equalsIgnoreCase("CST0%")){
					taxAmount = 0;
				}else if(inv.getInvoiceTaxOption().equalsIgnoreCase("CST1%")){
					taxAmount = (float) ((grossTotal- inv.getDiscount()) * 0.01);
				}else if(inv.getInvoiceTaxOption().equalsIgnoreCase("CST2%")){
					taxAmount = (float) ((grossTotal- inv.getDiscount()) * 0.02);
				}else if(inv.getInvoiceTaxOption().equalsIgnoreCase("CST4%")){
					taxAmount = (float) ((grossTotal- inv.getDiscount()) * 0.04);
				}else if(inv.getInvoiceTaxOption().equalsIgnoreCase("CST5%")){
					taxAmount = (float) ((grossTotal- inv.getDiscount()) * 0.05);
				}else if(inv.getInvoiceTaxOption().equalsIgnoreCase("CST5.5%")){
					taxAmount = (float) ((grossTotal- inv.getDiscount()) * 0.055);
				}else if(inv.getInvoiceTaxOption().equalsIgnoreCase("CST6%")){
					taxAmount = (float) ((grossTotal- inv.getDiscount()) * 0.06);
				}
				
				printInvoice.setTaxAmount(taxAmount);
				
				grandTotal = (float) (grossTotal - inv.getDiscount() + taxAmount + inv.getOtherCharges() + inv.getCourierCharges() + inv.getGatePass());
				
				printInvoice.setGrandTotal(grandTotal);
				printInvoice.setAmountInWords(new NumberToWord().convertNumberToWords((int)grandTotal));
				
				json=CommonUtil.objectToJson(printInvoice);
				
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
				
				orderIdList = new ArrayList<String>();
				for(Order order: orderList){
					orderIdList.add(order.get_id());
				}
				
				platformService = (PlatformService) ObjectFactory.getInstance(ObjectEnum.PLATFORM_SERVICE);
				platformService.updateCAMAmountByNewWeights(orderIdList);
				platformService.updateRMAmountByNewWeights(orderIdList);
				
				orderList = invoiceService.getAllInfo(from, to);
				
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
				orderIdList = new ArrayList<>();
				
				Invoice invoice = new Invoice();
				String clientNo = request.getParameter("clientName");
				double discount = Double.parseDouble(request.getParameter("discount"));
				double courierCharges = Double.parseDouble(request.getParameter("courierCharges"));
				double otherCharges = Double.parseDouble(request.getParameter("otherCharges"));
				double gatePassCharges = Double.parseDouble(request.getParameter("gatePassCharges"));
				double rmCount = Double.parseDouble(request.getParameter("rmCount"));
				
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
				invoice.setRmCount(rmCount);
				
				for (JsonNode jsonNode : jn) {
					String orderNo = jsonNode.get("_id").asText();
					orderIdList.add(orderNo);
				}
				invoice.setOrderIdList(orderIdList);
				
				platformService = (PlatformService) ObjectFactory.getInstance(ObjectEnum.PLATFORM_SERVICE);
				platformService.updateCAMAmountByNewWeights(orderIdList);
				platformService.updateRMAmountByNewWeights(orderIdList);
				
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
