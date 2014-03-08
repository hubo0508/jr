package com.jr.platform.about.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jr.core.BaseController;
import com.jr.core.Results;
import com.jr.platform.about.service.CustomerService;
import com.jr.util.Json;
import com.jr.util.Util;

/**
 * 客户目录管理
 */
@Controller
@RequestMapping("/customerController")
public class CustomerController extends BaseController {

	private Log log = LogFactory.getLog(CustomerController.class);

	@Autowired
	private CustomerService customerService;

	@Autowired
	private String fileDir;

	/**
	 * 客户目录页面跳转_jump
	 */
	@RequestMapping(value = "/customerJump", method = RequestMethod.GET)
	public String customerJump() {
		return "backstage/about/customer";
	}

	/**
	 * 客户目录新增页面跳转_jump
	 */
	@RequestMapping(value = "/addJump", method = RequestMethod.GET)
	public String addJump() {
		return "backstage/about/customer_add.edit";
	}

	/**
	 * 客户目录编辑页面跳转_jump
	 */
	@RequestMapping(value = "/editJump", method = RequestMethod.GET)
	public String editJump(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String id) {

		try {
			if (StringUtils.isNotEmpty(id)) {
				request.setAttribute("p", customerService.findById(Integer
						.parseInt(id)));
			} else {
				request.setAttribute("p", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/about/customer_add.edit";
	}

	/**
	 * 客户目录列表查询
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public void list(HttpServletResponse response) {
		try {
			Results r = customerService.list();
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	/**
	 * 客户目录存储
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletResponse response, @RequestParam
	String customer_name, @RequestParam
	String description, @RequestParam
	String image_url, @RequestParam
	String historyimage, @RequestParam
	String id) {
		
		try {
			Results r = customerService.save(customer_name, description,
					image_url, id);
			if (r.isSuccess() && StringUtils.isNotEmpty(historyimage)) {
				Util.deleteFile(fileDir, historyimage);
			}
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	/**
	 * 客户目录删除
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public void delete(HttpServletResponse response, @RequestParam
	String ids) {

		try {
			Results r = customerService.delete(Util.idsToArray(ids));
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.DELETEERROR, false));
		}
	}
}
