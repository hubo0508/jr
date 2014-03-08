package com.jr.platform.system.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.jr.platform.system.service.RoleMenuService;
import com.jr.util.Json;
import com.jr.util.Util;

@Controller
@RequestMapping("/rolemenu")
public class RoleMenuController extends BaseController {

	private Log log = LogFactory.getLog(RoleMenuController.class);

	@Autowired
	private RoleMenuService roleMenuService;

	@RequestMapping(value = "/rolerwJump", method = RequestMethod.GET)
	public String rolerwJump() {
		return "backstage/system/roles_rw";
	}

	@RequestMapping(value = "/rolemenuJump", method = RequestMethod.GET)
	public String roleMenuJump() {
		return "backstage/system/roles_menu";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/rolemenuIdList", method = RequestMethod.POST)
	public void rolemenuIdList(HttpServletResponse response, @RequestParam
	String id) {
		try {
			outJsonString(response, Json.toJson(roleMenuService
					.rolemenuIdList(id)));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/menuList", method = RequestMethod.POST)
	public void menuList(HttpServletResponse response) {

		try {
			outJsonString(response, Json.toJson(roleMenuService.menuList()));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletRequest request, HttpServletResponse response,
			@RequestParam
			String role_id, @RequestParam
			String menu_ids) {
		try {
			Results r = roleMenuService.save(role_id, menu_ids == "" ? null
					: Util.idsToArray(menu_ids));
			if (r.isSuccess() == true) {
				r.setMessage("授权成功！");
			} else {
				r.setMessage("授权失败，请稍后再试！");
			}
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson("授权失败，请稍后再试！", false));
		}
	}

	@RequestMapping(value = "/rolerwList", method = RequestMethod.POST)
	public void rolerwList(HttpServletResponse response, @RequestParam
	int start, @RequestParam
	int pageSize, @RequestParam
	String role_id, @RequestParam
	String rw) {
		try {
			outJsonString(response, Json.toJson(roleMenuService.rolerwList(
					new Page(start, pageSize), role_id,rw)));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/saverw", method = RequestMethod.POST)
	public void saverw(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String rw, @RequestParam
			String ids) {
		try {
			Results r = roleMenuService.saverw(Util.idsToArray(ids), rw);
			if (r.isSuccess() == true) {
				r.setMessage("授权成功！");
			} else {
				r.setMessage("授权失败，请稍后再试！");
			}
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson("授权失败，请稍后再试！", false));
		}
	}
}
