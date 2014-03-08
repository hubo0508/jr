package com.jr.platform.about.controller;

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
import com.jr.core.Results;
import com.jr.platform.about.service.TeamService;
import com.jr.util.Json;
import com.jr.util.Util;

@Controller
@RequestMapping("/team")
public class TeamController extends BaseController {

	private Log log = LogFactory.getLog(TeamController.class);

	@Autowired
	private TeamService teamService;

	@Autowired
	private String fileDir;

	@RequestMapping(value = "/teamJump", method = RequestMethod.GET)
	public String teamJump() {
		return "backstage/about/team";
	}

	@RequestMapping(value = "/addJump", method = RequestMethod.GET)
	public String addJump() {
		return "backstage/about/team_add.edit";
	}

	@RequestMapping(value = "/editJump", method = RequestMethod.GET)
	public String editJump(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String id) {

		try {
			if (StringUtils.isNotEmpty(id)) {
				request.setAttribute("p", teamService.findById(Integer
						.parseInt(id)));
			} else {
				request.setAttribute("p", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/about/team_add.edit";
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public void list(HttpServletResponse response) {
		try {
			Results r = teamService.list();
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletResponse response, @RequestParam
	String custom_sort, @RequestParam
	String name, @RequestParam
	String job_desc, @RequestParam
	String job_info, @RequestParam
	String url, @RequestParam
	String historyurl, @RequestParam
	String id) {

		try {
			Results r = teamService.save(name, job_desc, job_info, custom_sort,
					url, id);
			if (r.isSuccess() && StringUtils.isNotEmpty(historyurl)) {
				Util.deleteFile(fileDir, historyurl);
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
			Results r = teamService.delete(Util.idsToArray(ids));
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.DELETEERROR, false));
		}
	}
}
