package com.jr.platform.product.controller;

import java.util.Map;

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
import com.jr.platform.product.service.ProductCategoryService;
import com.jr.util.Json;
import com.jr.util.Util;

@Controller
@RequestMapping("/productCategory")
public class ProductCategoryController extends BaseController {

	private Log log = LogFactory.getLog(ProductCategoryController.class);

	@Autowired
	private ProductCategoryService productCategoryService;

	@RequestMapping(value = "/productCategoryJump", method = RequestMethod.GET)
	public String productCategoryJump() {
		return "backstage/product/productCategory";
	}

	@RequestMapping(value = "/productCategoryAddJump", method = RequestMethod.GET)
	public String productCategoryAddJump() {
		return "backstage/product/productCategory_add.edit";
	}

	@RequestMapping(value = "/productCategoryEditJump", method = RequestMethod.GET)
	public String productCategoryAddJump(HttpServletRequest request,
			HttpServletResponse response, @RequestParam
			String id) {

		try {
			if (StringUtils.isNotEmpty(id)) {
				Map<String, Object> c = productCategoryService.findById(Integer
						.parseInt(id));
				request.setAttribute("c", c);
			} else {
				request.setAttribute("error", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(),e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/product/productCategory_add.edit";
	}

	@RequestMapping(value = "/queryProductCategoryList", method = RequestMethod.POST)
	public void queryProductCategoryList(HttpServletResponse response) {

		try {
			Results r = productCategoryService.queryProductCategoryList();
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(),e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletResponse response, @RequestParam
	String product_use, @RequestParam
	String product_use_desc, @RequestParam
	String id) {

		try {
			Results r = productCategoryService.save(product_use,
					product_use_desc,id);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(),e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	@RequestMapping(value = "/deleteByIds", method = RequestMethod.POST)
	public void deleteByIds(HttpServletResponse response, @RequestParam
	String ids) {

		try {
			Results r = productCategoryService
					.deleteByIds(Util.idsToArray(ids));
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}
}
