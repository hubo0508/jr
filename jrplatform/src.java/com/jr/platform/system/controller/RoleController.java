package com.jr.platform.system.controller;

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
import com.jr.core.Constants;
import com.jr.core.Results;
import com.jr.platform.system.service.RoleService;
import com.jr.util.Json;
import com.jr.util.Util;

@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {

	private Log log = LogFactory.getLog(RoleController.class);

	@Autowired
	private RoleService roleService;

	@RequestMapping(value = "/roleJump", method = RequestMethod.GET)
	public String roleJump() {
		return "backstage/system/roles";
	}

	@RequestMapping(value = "/addJump", method = RequestMethod.GET)
	public String addJump() {
		return "backstage/system/roles_add.edit";
	}

	@RequestMapping(value = "/editJump", method = RequestMethod.GET)
	public String editJump(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String id) {

		try {
			if (StringUtils.isNotEmpty(id)) {
				request.setAttribute("p", roleService.findById(Integer
						.parseInt(id)));
			} else {
				request.setAttribute("p", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("p", Results.BUSY);
		}
		return "backstage/system/roles_add.edit";
	}

	@RequestMapping(value = "/listBy", method = RequestMethod.POST)
	public void listBy(HttpServletResponse response, @RequestParam
	String type) {

		try {
			outJsonString(response, Json.toJson(roleService.listBy(Integer
					.parseInt(type))));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	/**
	 * 查询已关联菜单的角色
	 */
	@RequestMapping(value = "/authorizeRoleList", method = RequestMethod.POST)
	public void authorizeRoleList(HttpServletResponse response) {
		try {
			outJsonString(response, Json
					.toJson(roleService.authorizeRoleList()));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public void list(HttpServletResponse response) {

		try {
			outJsonString(response, Json.toJson(roleService.list()));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletResponse response, @RequestParam
	String roletype, @RequestParam
	String rolename, @RequestParam
	String roleremark, @RequestParam
	String id) {

		if ((Constants.INTERNAL + "").equals(roletype)
				|| (Constants.THIRD_PARTY + "").equals(roletype)) {
			try {
				Results r = roleService
						.save(rolename, roleremark, roletype, id);
				outJsonString(response, Json.toJson(r));
			} catch (Throwable e) {
				log.error(e.getMessage(), e);
				outJsonString(response, Json.oJson(Results.SAVEERROR, false));
			}
		} else {
			outJsonString(response, Json.oJson("角色类型定义错误！", false));
		}

	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public void delete(HttpServletResponse response, @RequestParam
	String ids) {

		try {
			Results r = roleService.delete(Util.idsToArray(ids));
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.DELETEERROR, false));
		}
	}

}
