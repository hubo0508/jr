package com.jr.client.index.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/client/index")
public class IndexCliController {

	@RequestMapping(value = "/indexBanner")
	public String indexBanner(HttpServletRequest request) {
		return "/client/common/indexBanner";
	}

	 @ResponseBody
	@RequestMapping(value = "/books", method = RequestMethod.POST)
	public String rest(@RequestBody
	String username) {
		System.out.println("________________________" + username);
		return "Java";
	}
}
