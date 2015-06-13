package com.affixus.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.affixus.pojo.Order;
import com.affixus.services.OrderService;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants;
import com.affixus.util.ObjectFactory;
import com.affixus.util.Constants.UIOperations;
import com.affixus.util.ObjectFactory.ObjectEnum;

/**
 * Servlet implementation class UpdateOrderAction
 */
@WebServlet("/updateOrder.action")
public class UpdateOrderAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderService orderService = null;
	private static final Logger LOG = Logger.getLogger(UpdateOrderAction.class);
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateOrderAction() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    @Override
    public void init() throws ServletException {
    	super.init();

		Object object = ObjectFactory.getInstance(ObjectEnum.ORDER_SERVICE);
		if (object instanceof OrderService ) {
			orderService = (OrderService ) object;
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
		
		if(operation == null || orderService  == null){
			out.write(json);
			out.close();
			return;
		}
		//Constants.UIOperations opEnum  = UIOperations.valueOf(operation.toUpperCase());
		
		switch (operation) {
			case "UPDATE_ORDER":
				
				
				break;
			case "VIEW_ALL":
				
				String fromDate = request.getParameter("fromDate");
				String toDate = request.getParameter("toDate");
				String operationStr = request.getParameter("operation");
				
				//if(fromDate!= null && null != toDate){
					Date from = CommonUtil.stringToDate(fromDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
					Date to = CommonUtil.stringToDate(toDate, CommonUtil.DATE_FORMAT_ddMMyyyy_HYPHEN);
					Set<Order> orderList = orderService.getAllByOperation(from,to, operationStr);
					
					json=CommonUtil.objectToJson(orderList);
				//}else{
				//	Set<Order> orderList = orderService.getAll();
				//	json=CommonUtil.objectToJson(orderList);
				//}
				break;

			default:
				break;
		}
		
		out.write(json);
		out.close();


	}
}
