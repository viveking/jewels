package com.affixus.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;

import com.affixus.pojo.Rate;
import com.affixus.pojo.RateRange;
import com.affixus.services.RateService;
import com.affixus.util.CommonUtil;
import com.affixus.util.Constants;
import com.affixus.util.Constants.UIOperations;
import com.affixus.util.ObjectFactory;
import com.affixus.util.ObjectFactory.ObjectEnum;

/**
 * Servlet implementation class RateListMaster
 */
@WebServlet("/rateListMaster.action")
public class RateListMasterAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger.getLogger(RateListMasterAction.class);

	private RateService rateService;
	
	/**
	 * Initialise all services here, Every request should not initialise them.
	 */
	@Override
	public void init() throws ServletException {
		super.init();

		Object object = ObjectFactory.getInstance(ObjectEnum.RATE_SERVICE);
		if (object instanceof RateService) {
			rateService = (RateService) object;
		} else {
			throw new ServletException("RateListService not initialized !");
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcessWithException(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcessWithException(request, response);
	}

	private void doProcessWithException(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

		if (operation != null) {
			//String id = request.getParameter(Constants.COLLECTION_KEY);
			String rate_id = request.getParameter("rateId");
			
			//BeanUtils.populate(rl, request.getParameterMap());
			
			Constants.UIOperations opEnum = UIOperations.valueOf(operation.toUpperCase());
			switch (opEnum) {
			case SAVE:
				Rate rate = rateService.get(rate_id);
				List<RateRange> rateRangeList = new ArrayList<>();//rate.getRateRangeList();
				String rateListArrSting = request.getParameter("rateList");
				
				ObjectMapper mapper = new ObjectMapper();
				JsonNode jn = mapper.readTree(rateListArrSting);
				
				for (JsonNode jsonNode : jn) {
					
					String from = jsonNode.get("from").asText();
					String to = jsonNode.get("to").asText();
					String rateValue = jsonNode.get("rate").asText();
					
					RateRange rl = new RateRange();
					rl.setFrom(from);
					rl.setTo(to);
					rl.setRate(Float.parseFloat(rateValue));
					
					rateRangeList.add(rl);
				}
				rate.setRateList(rateRangeList);
				
				rateService.update(rate);
				break;

			case VIEW:
				rate = rateService.get(rate_id);
				rateRangeList = rate.getRateRangeList();
				json = CommonUtil.objectToJson(rateRangeList);
				json = json.replaceAll("_id", "id");
				break;

			default:
				break;
			}
		}

		out.write(json);
		out.close();
	}
}
