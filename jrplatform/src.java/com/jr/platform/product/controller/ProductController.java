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
import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.platform.product.service.ProductService;
import com.jr.util.Json;
import com.jr.util.Util;

@Controller
@RequestMapping("/product")
public class ProductController extends BaseController {

	private Log log = LogFactory.getLog(ProductController.class);

	@Autowired
	private ProductService productService;

	@RequestMapping(value = "/productJump", method = RequestMethod.GET)
	public String productJump() {
		return "backstage/product/product";
	}

	@RequestMapping(value = "/productAddJump", method = RequestMethod.GET)
	public String productAddJump(HttpServletRequest request) {
		return "backstage/product/product_add.edit";
	}

	@RequestMapping(value = "/productEditJump", method = RequestMethod.GET)
	public String productEditJump(HttpServletRequest request, @RequestParam
	String id) {
		try {
			if (StringUtils.isNotEmpty(id)) {
				Map<String, Object> c = productService.findById(Integer
						.parseInt(id));
				request.setAttribute("c", c);
			} else {
				request.setAttribute("error", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}

		return "backstage/product/product_add.edit";
	}

	/**
	 * 不区分登录用户，查询所有产品信息
	 * 
	 * @User: HUBO
	 */
	@RequestMapping(value = "/queryProductList", method = RequestMethod.POST)
	public void queryProductList(HttpServletResponse response, @RequestParam
	int start, @RequestParam
	int pageSize) {

		try {
			Results r = productService.queryProductList(new Page(start,
					pageSize));
			outJsonString(response, Json.toJson(r));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}

	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public void save(HttpServletResponse response, @RequestParam
	String id, @RequestParam
	String product_name, @RequestParam
	String device_type_id, @RequestParam
	String product_category, @RequestParam
	String place_origin, @RequestParam
	String model, @RequestParam
	String material, @RequestParam
	String exterior_size, @RequestParam
	String effective_volume, @RequestParam
	String product_weight, @RequestParam
	String voltage, @RequestParam
	String electric_current, @RequestParam
	String power, @RequestParam
	String energy, @RequestParam
	String temperature_range, @RequestParam
	String coolant, @RequestParam
	String work_mode, @RequestParam
	String capacity, @RequestParam
	String stock, @RequestParam
	String taobao_links, @RequestParam
	String features, @RequestParam
	String range, @RequestParam
	String brand,@RequestParam String image_url
	) {

		try {
			Results r = productService.save(id, product_name, device_type_id,
					product_category, place_origin, model, material,
					exterior_size, effective_volume, product_weight, voltage,
					electric_current, power, energy, temperature_range,
					coolant, work_mode, capacity, stock, taobao_links,
					features, range, brand,image_url);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	@RequestMapping(value = "/deleteByIds", method = RequestMethod.POST)
	public void deleteByIds(HttpServletResponse response, @RequestParam
	String ids) {
		try {
			String r = productService.deleteByIds(Util.idsToArray(ids));
			outJsonString(response, r);
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.DELETEERROR, false));
		}
	}
}
