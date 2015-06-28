package com.affixus.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.affixus.pojo.Order;
import com.affixus.services.InvoiceService;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

/**
 * Servlet implementation class GenerateInvoice
 */
@WebServlet("/generateinvoice.action")
public class GenerateInvoiceAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(OrderAction.class);
	private InvoiceService invoiceService;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GenerateInvoiceAction() {
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
				/*
			case "GET_ALL_INFO_BY_CLIENT":
				fromDate = request.getParameter("fromDate");
				toDate = request.getParameter("toDate");
				
				String clientId = request.getParameter("clientId");
					
				if(fromDate!= null && null != toDate){
					Date from = CommonUtil.stringToDate(fromDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
					Date to = CommonUtil.stringToDate(toDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
					List<Order> orderList = invoiceService.getAllInfoByClient(from, to, clientId);
					json=CommonUtil.objectToJson(orderList);
				}
				break;*/
				
			case "GENERATE":
				
				//generateInvoice(List<Order> orderDetails);
				
				break;
			default:
				break;
		}

		out.write(json);
		out.close();

	}
}
