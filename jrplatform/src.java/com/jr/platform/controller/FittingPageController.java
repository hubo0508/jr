package com.jr.platform.fitting.controller;

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
import com.jr.platform.fitting.service.FittingPageService;
import com.jr.util.Json;

@Controller
@RequestMapping("/fittingPage")
public class FittingPageController extends BaseController {

	private Log log = LogFactory.getLog(FittingPageController.class);

	@Autowired
	private FittingPageService fittingPageService;

	@RequestMapping(value = "/fittingPageDescJump", method = RequestMethod.GET)
	public String fittingPageDescJump(HttpServletRequest request) {
		try {
			request.setAttribute("p", fittingPageService.find());
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/fitting/fittingDesc";
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletRequest request,HttpServletResponse response, @RequestParam
	String description, @RequestParam
	String id) {
		
		try {
			Results r = fittingPageService.save(id, description);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}
}
