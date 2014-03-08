package com.jr.platform.learn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jr.core.BaseController;
import com.jr.core.Results;
import com.jr.platform.learn.service.SmallCategoryService;
import com.jr.util.Json;
import com.jr.util.Util;

@Controller
@RequestMapping("/smallCategory")
public class SmallCategoryController extends BaseController {

	private Log log = LogFactory.getLog(SmallCategoryController.class);

	@Autowired
	private SmallCategoryService smallCategoryService;

	@RequestMapping(value = "/smallJump", method = RequestMethod.GET)
	public String smallJump() {
		return "backstage/learn/small";
	}

	@RequestMapping(value = "/addJump", method = RequestMethod.GET)
	public String addJump() {
		return "backstage/learn/small_add.edit";
	}

	@RequestMapping(value = "/editJump", method = RequestMethod.GET)
	public String editJump(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String id) {

		try {
			if (StringUtils.isNotEmpty(id)) {
				request.setAttribute("p", smallCategoryService.findById(Integer
						.parseInt(id)));
			} else {
				request.setAttribute("p", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/learn/small_add.edit";
	}

	@RequestMapping(value = "/treeList", method = RequestMethod.POST)
	public void treeList(HttpServletResponse response) {
		try {
			Results r = smallCategoryService.treeList();
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public void list(HttpServletResponse response) {
		try {
			Results r = smallCategoryService.list();
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletResponse response, @RequestParam
	String small_category, @RequestParam
	String small_category_desc, @RequestParam
	String id) {

		try {
			Results r = smallCategoryService.save(small_category,
					small_category_desc, id);
			outJsonString(response, Json.toJson(r));
		} catch (DuplicateKeyException e) {
			String msg = "文档类别：'" + small_category + "'已建立，请检查确认！";
			log.error(msg);
			outJsonString(response, Json.oJson(msg, false));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public void delete(HttpServletResponse response, @RequestParam
	String ids) {

		try {
			Results r = smallCategoryService.delete(Util.idsToArray(ids));
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.DELETEERROR, false));
		}
	}
}
