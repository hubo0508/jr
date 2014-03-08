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
import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.platform.about.service.EmployeeService;
import com.jr.util.Json;

/**
 * 内部员工管理
 */
@Controller
@RequestMapping("/employee")
public class EmployeeController extends BaseController {

	private Log log = LogFactory.getLog(EmployeeController.class);

	@Autowired
	private EmployeeService employeeService;

	@RequestMapping(value = "/employeeJump", method = RequestMethod.GET)
	public String memberJump() {
		return "backstage/about/employee";
	}

	@RequestMapping(value = "/addJump", method = RequestMethod.GET)
	public String addJump() {
		return "backstage/about/employee_add.edit";
	}

	@RequestMapping(value = "/editJump", method = RequestMethod.GET)
	public String editJump(HttpServletRequest request, @RequestParam
	String id) {
		try {
			if (StringUtils.isNotEmpty(id)) {
				request.setAttribute("p", employeeService.findById(Integer
						.parseInt(id)));
			} else {
				request.setAttribute("p", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}

		return "backstage/about/employee_add.edit";
	}

	/**
	 * 列表查询
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public void list(HttpServletResponse response, @RequestParam
	int start, @RequestParam
	int pageSize, @RequestParam
	String status, @RequestParam
	String rolenameid, @RequestParam
	String sTime, @RequestParam
	String eTime) {

		try {
			Results r = employeeService.list(new Page(start, pageSize), status,
					rolenameid, sTime, eTime);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletRequest request, HttpServletResponse response,
			@RequestParam
			String role_id, @RequestParam
			String eid, @RequestParam
			String uid, @RequestParam
			String rolenameid, @RequestParam
			String status, @RequestParam
			String username, @RequestParam
			String ename, @RequestParam
			String ephone, @RequestParam
			String ejob, @RequestParam
			String password) {
		try {
			Results r = employeeService.save(role_id, eid, uid, rolenameid,
					status, username, ename, ephone, ejob,password);
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
			Results r = employeeService.delete(ids);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.DELETEERROR, false));
		}
	}
}
