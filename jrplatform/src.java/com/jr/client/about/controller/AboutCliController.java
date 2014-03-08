package com.jr.client.about.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jr.client.about.service.AboutCliService;

@Controller
@RequestMapping("/client")
public class AboutCliController {
	
	@Autowired
	private AboutCliService aboutCliService;

	@RequestMapping(value = "/about")
	public String about(HttpServletRequest request) {
		request.setAttribute("queryAboutDesc", aboutCliService.queryAboutDesc());
		request.setAttribute("queryGrowingProcess", aboutCliService.queryGrowingProcess());
		request.setAttribute("queryCompanyTeam", aboutCliService.queryCompanyTeam());
		request.setAttribute("queryCompany", aboutCliService.queryCompany());
		return "/client/about";
	} 
}
