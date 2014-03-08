package com.jr.platform.news.controller;

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
import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.platform.news.service.NewsService;
import com.jr.util.Json;
import com.jr.util.Util;

@Controller
@RequestMapping("/news")
public class NewsController extends BaseController {

	private Log log = LogFactory.getLog(NewsController.class);

	@Autowired
	private NewsService newsService;

	@Autowired
	private String fileDir;

	@RequestMapping(value = "/newsJump", method = RequestMethod.GET)
	public String newsJump() {
		return "backstage/news/news";
	}

	@RequestMapping(value = "/addJump", method = RequestMethod.GET)
	public String addJump(HttpServletRequest request) {
		return "backstage/news/news_add.edit";
	}

	@RequestMapping(value = "/editJump", method = RequestMethod.GET)
	public String editJump(HttpServletRequest request, @RequestParam
	String id) {
		try {
			if (StringUtils.isNotEmpty(id)) {
				request.setAttribute("p", newsService.findById(Integer
						.parseInt(id)));
			} else {
				request.setAttribute("p", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}

		return "backstage/news/news_add.edit";
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public void list(HttpServletResponse response, @RequestParam
	int start, @RequestParam
	int pageSize, @RequestParam
	String title, @RequestParam
	String sTime,@RequestParam String eTime) {

		try {
			Results r = newsService.list(new Page(start, pageSize), title,
					sTime,eTime);
			outJsonString(response, Json.toJson(r));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}

	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletResponse response, @RequestParam
	String id, @RequestParam
	String title, @RequestParam
	String content, @RequestParam
	String image_url, @RequestParam
	String historyimage) {

		try {
			Results r = newsService.save(id, title, content, image_url);

			if (r.isSuccess() && StringUtils.isNotEmpty(historyimage)) {
				Util.deleteFile(fileDir, historyimage);
			}

			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public void delete(HttpServletResponse response, @RequestParam
	String ids) {
		try {
			String r = newsService.delete(Util.idsToArray(ids));
			outJsonString(response, r);
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.DELETEERROR, false));
		}
	}
}
