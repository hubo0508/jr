package com.jr.platform.product.controller;

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
import com.jr.platform.product.service.ProductCategoryService;
import com.jr.util.Json;
import com.jr.util.Util;

/**
 * 产品自定义类别信息
 */
@Controller
@RequestMapping("/productCategory")
public class ProductCategoryController extends BaseController {

	private Log log = LogFactory.getLog(ProductCategoryController.class);

	@Autowired
	private ProductCategoryService productCategoryService;

	/**
	 * 产品自定义类别列表页面跳转_jump
	 */
	@RequestMapping(value = "/productCategoryJump", method = RequestMethod.GET)
	public String productCategoryJump() {
		return "backstage/product/productCategory";
	}

	/**
	 * 添加产品自定义类别_jump
	 */
	@RequestMapping(value = "/addJump", method = RequestMethod.GET)
	public String addJump() {
		return "backstage/product/productCategory_add.edit";
	}

	/**
	 * 编辑产品自定义类别_jump
	 */
	@RequestMapping(value = "/editJump", method = RequestMethod.GET)
	public String editJump(HttpServletRequest request,
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
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/product/productCategory_add.edit";
	}

	/*-------------------------------------------------------------------------------------------*/
	/* JUMP END */
	/*-------------------------------------------------------------------------------------------*/

	/**
	 * 产品自定义类别列表查询
	 */
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public void list(HttpServletResponse response) {

		try {
			Results r = productCategoryService.list();
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	/**
	 * 产品自定义类别保存_修改
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletResponse response, @RequestParam
	String product_use, @RequestParam
	String product_use_desc, @RequestParam
	String id) {

		try {
			Results r = productCategoryService.save(product_use,
					product_use_desc, id);
			outJsonString(response, Json.toJson(r));
		} catch (DuplicateKeyException e) {
			String msg = "设备自定义类别：'" + product_use + "'已建立，请检查确认！";
			log.error(msg);
			outJsonString(response, Json.oJson(msg, false));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	/**
	 * 产品自定义类别删除
	 */
	@RequestMapping(value = "/deleteByIds", method = RequestMethod.POST)
	public void delete(HttpServletResponse response, @RequestParam
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
