package com.jr.client.service.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jr.client.service.service.ServiceCliService;
import com.jr.core.BaseController;

/**
 * 维修服务组件
 */
@Controller
@RequestMapping("/client")
public class ServiceCliController extends BaseController {

	private Log log = LogFactory.getLog(ServiceCliController.class);

	@Autowired
	private ServiceCliService serviceCliService;

	@RequestMapping(value = "/service", method = RequestMethod.GET)
	public String news(HttpServletRequest request) {
		try {
			request.setAttribute("queryDescription", serviceCliService
					.queryDescription());
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		try {
			request.setAttribute("queryMaintenanceCategory", serviceCliService
					.queryMaintenanceCategory());
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		try {
			request.setAttribute("queryMaintenanceReportCard", serviceCliService
					.queryMaintenanceReportCard());
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		return "/client/repair";
	}
}
