package com.jr.platform.learn.controller;

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
import com.jr.platform.learn.service.LearnService;
import com.jr.util.Json;
import com.jr.util.Util;

@Controller
@RequestMapping("/learn")
public class LearnController extends BaseController {

	private Log log = LogFactory.getLog(LearnController.class);

	@Autowired
	private LearnService learnService;

	@Autowired
	private String fileDir;

	@RequestMapping(value = "/learnJump", method = RequestMethod.GET)
	public String learnJump(HttpServletRequest request) {
		return "backstage/learn/learn";
	}

	@RequestMapping(value = "/addJump", method = RequestMethod.GET)
	public String addJump(HttpServletRequest request) {
		return "backstage/learn/learn_add.edit";
	}

	@RequestMapping(value = "/editJump", method = RequestMethod.GET)
	public String editJump(HttpServletRequest request, @RequestParam
	String id) {

		try {
			if (StringUtils.isNotEmpty(id)) {
				request.setAttribute("p", learnService.findById(Integer
						.parseInt(id)));
			} else {
				request.setAttribute("p", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/learn/learn_add.edit";
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletRequest request, HttpServletResponse response,
			@RequestParam
			String id, @RequestParam
			String major_category_id, @RequestParam
			String small_category_id, @RequestParam
			String file_name, @RequestParam
			String video_name, @RequestParam
			String file_url, @RequestParam
			String historyfile, @RequestParam
			String video_url, @RequestParam
			String historyvideo, @RequestParam
			String video_desc) {

		try {
			Results r = learnService.save(id, major_category_id,
					small_category_id, Util.toFile(file_name), Util
							.toFile(video_name), file_url, video_url,
					video_desc);

			if (r.isSuccess()) {
				if (StringUtils.isNotEmpty(historyfile)) {
					Util.deleteFile(fileDir, historyfile);
				}
				if (StringUtils.isNotEmpty(historyvideo)) {
					Util.deleteFile(fileDir, historyvideo);
				}
			}
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public void list(HttpServletResponse response, @RequestParam
	int start, @RequestParam
	int pageSize, @RequestParam
	String file_name, @RequestParam
	String video_name, @RequestParam
	String major_category_id, @RequestParam
	String small_category_id) {

		try {
			Results r = learnService.list(new Page(start, pageSize), file_name,
					video_name, major_category_id, small_category_id);
			outJsonString(response, Json.toJson(r));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public void delete(HttpServletResponse response, @RequestParam
	String ids) {
			
		try {
			Results r = learnService.delete(Util.idsToArray(ids));
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.DELETEERROR, false));
		}
	}
}
