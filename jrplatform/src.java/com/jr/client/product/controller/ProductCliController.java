package com.jr.client.product.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jr.client.common.service.CommonCliService;
import com.jr.client.product.service.ProductCliService;
import com.jr.client.product.service.ProductPageCliService;
import com.jr.core.BaseController;
import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.util.Charset;

/** 
 * ProductController.java<br/>
 * 所属类别:获取时间相关方法类 <br/>
 * 用途: 通过此工具类减少获取时间相关代码量提高提高代码重用<br/>
 * author:<a href="mailto:llnyxxzj@163.com">lilong</a> <br/>
 * Date:2013-12-14 上午10:09:44<br/>
 * Version:1.0 <br/>
 */
@Controller
@RequestMapping("/client/product")
public class ProductCliController extends BaseController {

	private Log log = LogFactory.getLog(ProductCliController.class);

	@Autowired
	private ProductCliService productService;
	@Autowired
	private ProductPageCliService productPageService;
	@Autowired
	private CommonCliService commonCliService;
	/**
	 *<p>产品页</P>
	 * Date	2013-12-14 下午7:32:58
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String product(HttpServletRequest request,HttpServletResponse response) {
		try {
			//客户目录列表查询
			request.setAttribute("customerList",commonCliService.customerList("desc"));
			// 产品主页滚动查询
			request.setAttribute("scrollList",productService.scrollList(1));
			//产品选择
			request.setAttribute("results",productService.scrollList(1));
			//获取设备类型以及相应品牌
			request.setAttribute("productUseAndBrand", productService.getProductUseAndBrand());
			//获取设备类型
			request.setAttribute("deviceTypeList",productService.getDeviceType());
			//获取设备类型以及相应品牌
			request.setAttribute("productBrand",productService.getProductBrand());
			
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "/client/product/product";
	}
	/**
	 *<p>产品介绍</P>
	 * Date	2013-12-14 下午7:32:58
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/productDescJump", method = RequestMethod.GET)
	public void productDescJump(HttpServletRequest request,HttpServletResponse response) {
		try {
			//request.setAttribute("p", productPageService.find());
			PrintWriter writer=response.getWriter();
			writer.flush();
			writer.write(productPageService.find().get("description").toString());
			writer.close();
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
	}
	/**
	 * 客户目录列表查询
	 */
	@RequestMapping(value = "/customerList", method = RequestMethod.GET)
	public String list(HttpServletRequest request) {
		try {
			request.setAttribute("results",commonCliService.customerList("desc"));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}

		return "/client/product/product_customers_roll";
	}

	/**
	 * 产品主页滚动查询
	 */
	@RequestMapping(value = "/productScrollList", method = RequestMethod.GET)
	public String productScrollList(HttpServletRequest request) {
		try {
			request.setAttribute("results",productService.scrollList(1));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "/client/product/product_roll";
	}
	/**
	 * 产品选择
	 */
	@RequestMapping(value = "/productSelect", method = RequestMethod.GET)
	public String productSelect(HttpServletRequest request) {
		try {
			request.setAttribute("deviceTypeList",productService.getDeviceType());
			request.setAttribute("productBrand",productService.getProductBrand());
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
		return "/client/product/product_search";
	}
	/**
	 *产品查询 设备类型、品牌
	 */
	@RequestMapping(value = "/findProduct", method = RequestMethod.GET)
	public String findProduct(HttpServletRequest request) {
		String deviceTypeId=Charset.toUTF(request.getParameter("deviceTypeId"));
		String brand=Charset.toUTF(request.getParameter("brand"));
		String start=request.getParameter("start");
		String pageSize=request.getParameter("pageSize");
		Results results=productService.findProduct(new Page(Integer.valueOf(start), Integer.valueOf(pageSize)),deviceTypeId,brand);
		
		request.setAttribute("results", results);
		request.setAttribute("brand", brand);
		
		StringBuffer url=new StringBuffer("/client/product/findProduct?");
		if(deviceTypeId!=null&&!deviceTypeId.equals("")){
			if(url.toString().contains("=")){
				url.append("&deviceTypeId="+deviceTypeId);
			}else{
				url.append("deviceTypeId="+deviceTypeId);
			}
		}
		if(brand!=null&&!brand.equals("")){
			if(url.toString().contains("=")){
				url.append("&brand="+brand);
			}else{
				url.append("brand="+brand);
			}
		}
		request.setAttribute("url", url.toString());

		//获取设备类型
		request.setAttribute("deviceTypeList",productService.getDeviceType());
		//获取设备类型以及相应品牌
		request.setAttribute("productBrand",productService.getProductBrand());

		return "/client/product/productInfo";
	}
	/**
	 *产品查询 设备名称、品牌
	 */
	@RequestMapping(value = "/findProductByBrandAndProductName", method = RequestMethod.GET)
	public String findProductByBrandAndProductName(HttpServletRequest request) {
		String brand=Charset.toUTF(request.getParameter("brand"));
		String productName=Charset.toUTF(request.getParameter("productName"));
		String start=request.getParameter("start");
		String pageSize=request.getParameter("pageSize");
		Results results=productService.findProductByBrandAndProductName(new Page(Integer.valueOf(start), Integer.valueOf(pageSize)),productName,brand);
		
		request.setAttribute("results", results);
		request.setAttribute("brand", brand);
		request.setAttribute("productName", productName);



		StringBuffer url=new StringBuffer("/client/product/findProductByBrandAndProductName?");
		if(productName!=null&&!productName.equals("")){
			if(url.toString().contains("=")){
				url.append("&productName="+productName);
			}else{
				url.append("productName="+productName);
			}
		}
		if(brand!=null&&!brand.equals("")){
			if(url.toString().contains("=")){
				url.append("&brand="+brand);
			}else{
				url.append("brand="+brand);
			}
		}
		request.setAttribute("url", url.toString());

		//获取设备类型
		request.setAttribute("deviceTypeList",productService.getDeviceType());
		//获取设备类型以及相应品牌
		request.setAttribute("productBrand",productService.getProductBrand());
		
		return "/client/product/productInfo";
	}

	/**
	 *产品查询 设备名称、品牌
	 */
	@RequestMapping(value = "/getProductByProductId/{id}", method = RequestMethod.GET)
	public String getProductByProductId(@PathVariable String id,HttpServletRequest request) {

		request.setAttribute("product", productService.getProductByProductId(Integer.parseInt(id)));

		return "/client/product/productInfoBase";
	}
}
