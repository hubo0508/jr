package com.jr.client.news.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jr.client.news.service.NewsCliService;
import com.jr.core.BaseController;
import com.jr.core.Page;

/**
 * 新闻组件
 */
@Controller
@RequestMapping("/client")
public class NewsCliController extends BaseController {

	private Log log = LogFactory.getLog(NewsCliController.class);

	@Autowired
	private NewsCliService newsCliService;

	/**
	 * 新闻页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(value = "/news", method = RequestMethod.GET)
	public String news(HttpServletRequest request) {
		try {
			request.setAttribute("newsList", newsCliService
					.list(new Page(1, 10)));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		return "/client/new";
	}

	@RequestMapping(value = "/newsinfo", method = RequestMethod.GET)
	public String newsinfo(HttpServletRequest request, @RequestParam
	int id) {
		try {
			newsCliService.updateCount(id);
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		try {
			request.setAttribute("info", newsCliService.queryNewsInfo(id));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		return "/client/newInfo";
	}

	@RequestMapping(value = "/newsList", method = RequestMethod.GET)
	public String newsList(HttpServletRequest request, @RequestParam
	int start, @RequestParam
	int pageSize) {
		try {
			request.setAttribute("newsList", newsCliService.list(new Page(
					start, pageSize)));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		return "/client/new";
	}
}
