package com.jr.client.lease.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jr.client.lease.service.LeaseCliService;
import com.jr.client.news.controller.NewsCliController;

/**
 * 租赁服务
 */
@Controller
@RequestMapping("/client")
public class LeaseCliController {

	private Log log = LogFactory.getLog(NewsCliController.class);

	@Autowired
	private LeaseCliService leaseCliService;

	@RequestMapping(value = "/lease")
	public String lease(HttpServletRequest request) {
		try {
			request.setAttribute("queryLeaseInfo", leaseCliService
					.queryLeaseInfo());
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		try {
			request.setAttribute("queryScrollProductToLease", leaseCliService
					.queryScrollProductToLease());
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		return "/client/lease";
	}
}
