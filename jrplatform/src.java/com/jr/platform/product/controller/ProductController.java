package com.jr.platform.product.controller;

import java.io.IOException;
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
import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.platform.product.service.ProductCategoryService;
import com.jr.platform.product.service.ProductService;
import com.jr.util.Json;
import com.jr.util.Util;

/**
 * 产品中心
 */
@Controller
@RequestMapping("/product")
public class ProductController extends BaseController {

	private Log log = LogFactory.getLog(ProductController.class);

	@Autowired
	private ProductService productService;
	@Autowired
	ProductCategoryService categoryService;
	@Autowired
	private String fileDir;
	/**
	 * 产品批量导入页面_jump
	 */
	@RequestMapping(value = "/productImport", method = RequestMethod.GET)
	public String productImport() {
		return "backstage/product/productImport";
	}
	/**
	 * 产品批量导入数据_jump
	 */
	@RequestMapping(value = "/productImportSave", method = RequestMethod.POST)
	public void productImportSave(HttpServletRequest request,HttpServletResponse response) {
		try {

			String excelFileUrl = request.getParameter("excel_file_url");
			String zipFileUrl = request.getParameter("zip_file_url");
			String zipvalue = request.getParameter("zipvalue");

			if(excelFileUrl!=null&&!excelFileUrl.equals("")&&zipFileUrl!=null&&!zipFileUrl.equals("")){
				String buffer=	productService.batchToSave(excelFileUrl, zipFileUrl, zipvalue);
				outJsonString(response,Json.oJson(buffer, false));
			}
		} catch (IOException e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}

	}



	/**
	 * 产品列表页面_jump
	 */
	@RequestMapping(value = "/productJump", method = RequestMethod.GET)
	public String productJump() {
		return "backstage/product/product";
	}

	/**
	 * 新增产品_jump
	 */
	@RequestMapping(value = "/productAddJump", method = RequestMethod.GET)
	public String productAddJump(HttpServletRequest request) {
		return "backstage/product/product_add.edit";
	}

	/**
	 * 设置产品滚动列表页面_jump
	 */
	@RequestMapping(value = "/productScrollListJump", method = RequestMethod.GET)
	public String productScrollListJump(HttpServletRequest request) {
		return "backstage/product/productScroll";
	}

	/**
	 * 选择产品弹出窗口页面_jump
	 */
	@RequestMapping(value = "/selectProductJump", method = RequestMethod.GET)
	public String selectProductJump(HttpServletRequest request) {
		return "backstage/product/selectProduct";
	}

	/**
	 * 编辑产品信息_jump
	 */
	@RequestMapping(value = "/productEditJump", method = RequestMethod.GET)
	public String productEditJump(HttpServletRequest request, @RequestParam
			String id) {
		try {
			if (StringUtils.isNotEmpty(id)) {
				Map<String, Object> c = productService.findById(Integer
						.parseInt(id));
				request.setAttribute("p", c);
			} else {
				request.setAttribute("p", "参数错误，请重新打开编辑页面！");
			}
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}

		return "backstage/product/product_add.edit";
	}

	/*-------------------------------------------------------------------------------------------*/
	/* JUMP END */
	/*-------------------------------------------------------------------------------------------*/

	/**
	 * 产品信息列表查询
	 */
	@RequestMapping(value = "/queryProductList", method = RequestMethod.POST)
	public void queryProductList(HttpServletResponse response, @RequestParam
			int start, @RequestParam
			int pageSize, @RequestParam
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
			String brand) {

		try {
			Results r = productService.queryProductList(new Page(start,
					pageSize), product_name, device_type_id, product_category,
					place_origin, model, material, exterior_size,
					effective_volume, product_weight, voltage,
					electric_current, power, energy, temperature_range,
					coolant, work_mode, capacity, stock, brand);
			outJsonString(response, Json.toJson(r));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}

	}

	/**
	 * 保存_修改产品信息
	 * 
	 * @param historyimage
	 *            当修改产品信息时，将原始产品图片进行删除。
	 */
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
			String brand, @RequestParam
			String image_url, @RequestParam
			String historyimage) {

		try {
			Results r = productService.save(id, product_name, device_type_id,
					product_category, place_origin, model, material,
					exterior_size, effective_volume, product_weight, voltage,
					electric_current, power, energy, temperature_range,
					coolant, work_mode, capacity, stock, taobao_links,
					features, range, brand, image_url);

			// 保存成功删除历史文件
			if (r.isSuccess() && StringUtils.isNotEmpty(historyimage)) {
				Util.deleteFile(fileDir, historyimage);
			}

			outJsonString(response, Json.toJson(r));
		}catch (DuplicateKeyException e){
			String msg = "设备：'"+product_name+"'已存库，请检查确认！";
			log.error(msg);
			outJsonString(response, Json.oJson(msg, false));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.SAVEERROR, false));
		}
	}

	/**
	 * 删除产品数据
	 * 
	 * @param ids
	 *            多id字符串，例：1,2,3
	 */
	@RequestMapping(value = "/deleteByIds", method = RequestMethod.POST)
	public void delete(HttpServletResponse response, @RequestParam
			String ids) {
		try {
			String r = productService.delete(Util.idsToArray(ids));
			outJsonString(response, r);
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.DELETEERROR, false));
		}
	}

	/**
	 * 取消产品滚动
	 * 
	 * @param ids
	 *            多id字符串，例：1,2,3
	 */
	@RequestMapping(value = "/cancelScroll", method = RequestMethod.POST)
	public void cancelScroll(HttpServletResponse response, @RequestParam
			String ids) {
		try {
			String r = productService.scroll(Util.idsToArray(ids), 0);
			outJsonString(response, r);
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson("设置失败，请稍后再试！", false));
		}
	}

	/**
	 * 设置产品滚动
	 * 
	 * @param ids
	 *            多id字符串，例：1,2,3
	 */
	@RequestMapping(value = "/confirmScroll", method = RequestMethod.POST)
	public void confirmScroll(HttpServletResponse response, @RequestParam
			String ids) {
		try {
			String r = productService.scroll(Util.idsToArray(ids), 1);
			outJsonString(response, r);
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson("设置失败，请稍后再试！", false));
		}
	}

	/**
	 * 产品主页滚动查询
	 */
	@RequestMapping(value = "/productScrollList", method = RequestMethod.POST)
	public void productScrollList(HttpServletResponse response) {
		try {
			Results r = productService.scrollList(1);
			outJsonString(response, Json.toJson(r));
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}
}
