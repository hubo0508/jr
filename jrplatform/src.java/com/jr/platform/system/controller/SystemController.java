package com.jr.platform.system.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jr.core.BaseController;

@Controller
@RequestMapping("system")
public class SystemController extends BaseController {

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String loginJump() {
		return "backstage/index";
	}
}
