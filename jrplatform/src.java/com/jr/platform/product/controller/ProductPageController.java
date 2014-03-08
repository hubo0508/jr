package com.jr.platform.product.controller;

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
import com.jr.core.Results;
import com.jr.platform.product.service.ProductPageService;
import com.jr.util.Json;

@Controller
@RequestMapping("/productPage")
public class ProductPageController extends BaseController {

	private Log log = LogFactory.getLog(ProductPageController.class);

	@Autowired
	private ProductPageService productPageService;
	
	/**
	 * 产品简介页面跳转_jump
	 */
	@RequestMapping(value = "/productDescJump", method = RequestMethod.GET)
	public String productDescJump(HttpServletRequest request) {
		try {
			request.setAttribute("p", productPageService.find());
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "backstage/product/productDesc";
	}
	
	/*-------------------------------------------------------------------------------------------*/
	/* JUMP END */
	/*-------------------------------------------------------------------------------------------*/
	
	/**
	 * 产品主页阶简介_保存_修改
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletRequest request,HttpServletResponse response, @RequestParam
	String description, @RequestParam
	String id) {

		try {
			Results r = productPageService.save(id, description);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}
}
