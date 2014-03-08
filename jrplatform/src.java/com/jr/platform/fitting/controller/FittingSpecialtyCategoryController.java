package com.jr.platform.fitting.controller;

import java.util.Map;

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
import com.jr.platform.fitting.service.FittingSpecialtyCategoryService;
import com.jr.platform.product.service.ProductCategoryService;
import com.jr.util.Json;
import com.jr.util.Util;

@Controller
@RequestMapping("/fittingSpecialtyCate")
public class FittingSpecialtyCategoryController extends BaseController {

	private Log log = LogFactory
			.getLog(FittingSpecialtyCategoryController.class);

	@Autowired
	private FittingSpecialtyCategoryService fittingSpecialtyCategoryService;

	@Autowired
	private ProductCategoryService productCategoryService;

	@RequestMapping(value = "/fittingSpecialtyJump", method = RequestMethod.GET)
	public String fittingSpecialtyJump() {
		return "backstage/fitting/specialtyCategory";
	}

	@RequestMapping(value = "/addJump", method = RequestMethod.GET)
	public String addJump() {
		return "backstage/fitting/specialtyCategory_add.edit";
	}

	@RequestMapping(value = "/editJump", method = RequestMethod.GET)
	public String editJump(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String id) {

		try {
			if (StringUtils.isNotEmpty(id)) {
				Map<String, Object> c = fittingSpecialtyCategoryService
						.findById(Integer.parseInt(id));
				request.setAttribute("c", c);
			} else {
				request.setAttribute("error", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/fitting/specialtyCategory_add.edit";
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public void list(HttpServletResponse response) {

		try {
			Results r = fittingSpecialtyCategoryService.queryList();
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletResponse response, @RequestParam
	String fitting_category, @RequestParam
	String fitting_category_desc, @RequestParam
	String id) {

		try {
			Results r = fittingSpecialtyCategoryService.save(fitting_category,
					fitting_category_desc, id);
			outJsonString(response, Json.toJson(r));
		} catch (DuplicateKeyException e) {
			String msg = "配件专业类别：'" + fitting_category + "'已建立，请检查确认！";
			log.error(msg);
			outJsonString(response, Json.oJson(msg, false));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	@RequestMapping(value = "/deleteByIds", method = RequestMethod.POST)
	public void deleteByIds(HttpServletResponse response, @RequestParam
	String ids) {

		try {
			Results r = productCategoryService.delete(Util.idsToArray(ids));
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.DELETEERROR, false));
		}
	}
}
