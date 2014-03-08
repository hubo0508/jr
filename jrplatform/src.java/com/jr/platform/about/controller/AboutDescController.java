package com.jr.platform.about.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jr.core.BaseController;
import com.jr.core.Results;
import com.jr.platform.about.service.AboutDescService;
import com.jr.util.Json;

@Controller
@RequestMapping("/aboutdesc")
public class AboutDescController extends BaseController {

	private Log log = LogFactory.getLog(AboutDescController.class);

	@Autowired
	private AboutDescService aboutDescService;

	@RequestMapping(value = "/aboutdescJump", method = RequestMethod.GET)
	public String aboutdescJump(HttpServletRequest request) {
		try {
			request.setAttribute("p", aboutDescService.find());
		} catch (Throwable e) {
			log.error(e.getMessage(), e);

			Map<String, String> obj = new HashMap<String, String>();
			obj.put("id", "");
			obj.put("company_description", "");

			request.setAttribute("p", obj);
		}
		return "backstage/about/aboutdesc";
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletRequest request, HttpServletResponse response,
			@RequestParam
			String company_description, @RequestParam
			String id) {

		try {
			Results r = aboutDescService.save(company_description, id);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	/**
	 * 注册用户协议
	 */
	@RequestMapping(value = "/protocoldescJump", method = RequestMethod.GET)
	public String protocoldescJump(HttpServletRequest request) {
		try {
			request.setAttribute("p", aboutDescService.findToProtocold());
		} catch (Throwable e) {
			log.error(e.getMessage(), e);

			Map<String, String> obj = new HashMap<String, String>();
			obj.put("id", "");
			obj.put("protocold", "");

			request.setAttribute("p", obj);
		}
		return "backstage/about/protocoldesc";
	}

	@RequestMapping(value = "/saveToProtocold", method = RequestMethod.POST)
	public void saveToProtocold(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String protocold, @RequestParam
			String id) {

		try {
			Results r = aboutDescService.saveToProtocold(protocold, id);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}
}
