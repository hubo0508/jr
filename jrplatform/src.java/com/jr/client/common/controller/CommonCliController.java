package com.jr.client.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jr.client.about.service.CompanyCliService;
import com.jr.client.common.service.CommonCliService;
import com.jr.client.fitting.service.FittingCliService;
import com.jr.client.learn.service.LearnCliService;
import com.jr.client.news.service.NewsCliService;
import com.jr.client.product.service.ProductCliService;
import com.jr.core.BaseController;
import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.util.Json;

/**
 * 通用组件
 */
@Controller
@RequestMapping("/")
public class CommonCliController extends BaseController {

	private Log log = LogFactory.getLog(CommonCliController.class);

	@Autowired
	private CommonCliService commonCliService;

	@Autowired
	private NewsCliService newsCliService;

	@Autowired
	private LearnCliService learnCliService;

	@Autowired
	private ProductCliService productService;

	@Autowired
	private FittingCliService fittingCliService;

	@Autowired
	private CompanyCliService companyCliService;

	@Autowired
	private String cloudview;

	/**
	 * 在线阅读PDF
	 * 
	 * @param file
	 *            文件名称
	 */
	@RequestMapping(value = "client/view/pdf", method = RequestMethod.GET)
	public String view(HttpServletRequest request, @RequestParam
	String file, @RequestParam
	String dtsid) {
		request.setAttribute("dtsid", dtsid);
		request.setAttribute("file", request.getSession().getAttribute(
				"cloudview")
				+ file);
		return "view/view";
	}

	/**
	 * 在线播放视频
	 * 
	 * @param file
	 *            视屏名称
	 */
	@RequestMapping(value = "client/view/video", method = RequestMethod.GET)
	public String video(HttpServletRequest request, @RequestParam
	String file) {
		request.setAttribute("file", request.getSession().getAttribute(
				"cloudview")
				+ file);
		return "view/video";
	}

	/**
	 * 用户协议查询
	 */
	@RequestMapping(value = "/client/protocol", method = RequestMethod.GET)
	public String protocol(HttpServletRequest request) {
		try {
			request.setAttribute("queryProtocol", commonCliService
					.queryProtocol());
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}

		return "/client/protocol";
	}

	/**
	 * 地址栏键入：<code>http://localhost:8980/jrplatform/client</code>直接跳转至首页
	 */
	@RequestMapping(value = "/client")
	public String client(HttpServletRequest request) {
		return "redirect:/client/index";
	}

	/**
	 * 地址栏键入：<code>http://localhost:8980/jrplatform/</code>直接跳转至首页
	 */
	@RequestMapping(value = "/")
	public String index2(HttpServletRequest request) {
		return "redirect:/client/index";
	}

	/**
	 * 地址栏键入：<code>http://localhost:8980/jrplatform/client/index</code>直接跳转至首页
	 */
	@RequestMapping(value = "/client/index")
	public String index(HttpServletRequest request) {
		request.getSession().setAttribute("cloudview", cloudview);
		try {
			request.setAttribute("listDocumentByMC", learnCliService
					.listDocumentByMC(new Page(1, 10), 0));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		try {
			request.setAttribute("customerList", commonCliService
					.customerList(null));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		try {
			request.setAttribute("newsList", newsCliService
					.list(new Page(1, 8)));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		try {
			request.setAttribute("listToIndex", learnCliService
					.listToHome(new Page(1, 8)));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		return "/client/index";
	}

	/**
	 * 底部导航链接
	 */
	@RequestMapping(value = "/client/bottomNavigation")
	public String bottomNavigation(HttpServletRequest request) {

		try {
			Map<String, Object> jr = companyCliService.queryCompany(0).get(0);
			request.setAttribute("jr", jr);
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}

		return "/client/common/bottom";
	}

	/**
	 * 在线客服查询
	 */
	@RequestMapping(value = "/client/onlineService")
	public void onlineService(HttpServletResponse response) {
		try {
			List<Map<String, Object>> lr = commonCliService.onlineService();

			outJsonString(response, Json.toJson(lr));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	/**
	 * 在线客户查询
	 */
	@RequestMapping(value = "/client/onlineCustomers")
	public void onlineCustomers(HttpServletResponse response) {
		try {
			Map<String, Object> r = commonCliService.onlineCustomers();

			List<Map<String, Object>> lr = new ArrayList<Map<String, Object>>();
			if (r != null) {
				Map<String, Object> sales = new HashMap<String, Object>();
				sales.put("text", "销售服务");
				sales.put("number", r.get("sales_qq"));

				Map<String, Object> customer = new HashMap<String, Object>();
				customer.put("text", "客户服务");
				customer.put("number", r.get("customer_qq"));

				Map<String, Object> leasing = new HashMap<String, Object>();
				leasing.put("text", "租赁服务");
				leasing.put("number", r.get("leasing_qq"));

				Map<String, Object> complaints = new HashMap<String, Object>();
				complaints.put("text", "投诉服务");
				complaints.put("number", r.get("complaints_qq"));

				Map<String, Object> phone = new HashMap<String, Object>();
				phone.put("phone", r.get("cphone"));

				lr.add(sales);
				lr.add(customer);
				lr.add(leasing);
				lr.add(complaints);
				lr.add(phone);
			}

			outJsonString(response, Json.toJson(lr));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	/**
	 * 客户名录查询
	 * 
	 * @param desc
	 *            参数不为空时，查询结果中包含字段description值
	 */
	@RequestMapping(value = "/client/customerList")
	public void customerList(HttpServletResponse response,
			HttpServletRequest request) {
		try {
			outJsonString(response, Json.toJson(commonCliService
					.customerList(request.getParameter("desc"))));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/client/selectProductOrFitting", method = RequestMethod.GET)
	public String selectProductOrFitting(HttpServletRequest request) {

		String selectedCondition = request.getParameter("selectedCondition");
		String condition = request.getParameter("condition");
		String start = request.getParameter("start");
		String pageSize = request.getParameter("pageSize");

		request.getSession().setAttribute("condition", condition);
		request.getSession().setAttribute("selectedCondition",
				selectedCondition);
		if (selectedCondition == null || selectedCondition.equals("")) {
			selectedCondition = "设备名称";
		}

		Results results = commonCliService.selectProductOrFitting(new Page(
				Integer.valueOf(start), Integer.valueOf(pageSize)),
				selectedCondition, condition);
		// 组装URL
		StringBuffer url = new StringBuffer("/client/selectProductOrFitting?");
		if (selectedCondition != null && !selectedCondition.equals("")) {
			if (url.toString().contains("=")) {
				url.append("&selectedCondition=" + selectedCondition);
			} else {
				url.append("selectedCondition=" + selectedCondition);
			}
		}
		if (condition != null && !condition.equals("")) {
			if (url.toString().contains("=")) {
				url.append("&condition=" + condition);
			} else {
				url.append("condition=" + condition);
			}
		}
		request.setAttribute("url", url.toString());
		request.setAttribute("results", results);

		if (selectedCondition.contains("设备")) {
			// 获取设备类型
			request.setAttribute("deviceTypeList", productService
					.getDeviceType());
			// 获取设备类型以及相应品牌
			request.setAttribute("productBrand", productService
					.getProductBrand());
			return "/client/product/productInfo";
		} else {
			// 配件归类分类
			request.setAttribute("fittingCategory", fittingCliService
					.getFittingCategory());
			// 获取配件用途以及相应品牌
			request.setAttribute("fittingUse", fittingCliService
					.getFittingUse());
			// 获取配件用途以及相应品牌
			request.setAttribute("fittingBrand", fittingCliService
					.getFittingBrand());
			// 获取设备类型
			request.setAttribute("deviceTypeList", productService
					.getDeviceType());
			return "/client/fitting/fittingInfo";
		}
	}

	@RequestMapping(value = "/client/protocolInfo")
	public String protocolInfo(HttpServletRequest request) {
		try {
			request.setAttribute("queryProtocol", commonCliService
					.queryProtocol());
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		return "/client/protocolInfo";
	}

	/** ************当前选中 ****************************************** */
	@RequestMapping(value = "/client/menu/{current}")
	public String menu(@PathVariable
	String current, HttpServletRequest request) {
		request.setAttribute("current", current);
		return "/client/common/menu";
	}
}
