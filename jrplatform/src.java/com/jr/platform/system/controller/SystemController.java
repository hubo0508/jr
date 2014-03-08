package com.jr.platform.system.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jr.core.BaseController;

/**
 * 系统管理
 */
@Controller
@RequestMapping("/")
public class SystemController extends BaseController {

	@RequestMapping(value = "/system/index", method = RequestMethod.GET)
	public String loginJump(HttpServletRequest request) {
		return "backstage/index";
	}
	
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String views(HttpServletRequest request, @RequestParam
	String file) {
		request.setAttribute("file", request.getSession().getAttribute("cloudview")+file);
		return "view/view";
	}

	@RequestMapping(value = "/system/view", method = RequestMethod.GET)
	public String view(HttpServletRequest request, @RequestParam
	String file) {
		request.setAttribute("file", request.getSession().getAttribute("cloudview")+file);
		return "view/view";
	}
	
	@RequestMapping(value = "/system/video", method = RequestMethod.GET)
	public String video(HttpServletRequest request, @RequestParam
	String file) {
		request.setAttribute("file", request.getSession().getAttribute("cloudview")+file);
		return "view/video";
	}
}
