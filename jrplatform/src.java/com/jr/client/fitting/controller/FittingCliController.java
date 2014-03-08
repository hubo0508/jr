package com.jr.client.fitting.controller;

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

import com.jr.client.fitting.service.FittingCliService;
import com.jr.client.product.service.ProductCliService;
import com.jr.core.BaseController;
import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.platform.fitting.service.FittingPageService;
import com.jr.util.Charset;

/** 
 * ClientFittingController.java<br/>
 * 所属类别:获取时间相关方法类 <br/>
 * 用途: 通过此工具类减少获取时间相关代码量提高提高代码重用<br/>
 * author:<a href="mailto:llnyxxzj@163.com">lilong</a> <br/>
 * Date:2013-12-14 上午10:30:56<br/>
 * Version:1.0 <br/>
 */
@Controller
@RequestMapping("/client/fitting")
public class FittingCliController extends BaseController {
	private Log log = LogFactory.getLog(FittingCliController.class);
	@Autowired
	private FittingPageService fittingPageService;
	@Autowired
	private FittingCliService fittingCliService; 

	@Autowired
	private ProductCliService productService;

	@RequestMapping(value = "/fittingPageDescJump", method = RequestMethod.GET)
	public void fittingPageDescJump(HttpServletRequest request,HttpServletResponse response) {
		try {
			//request.setAttribute("p", fittingPageService.find());
			PrintWriter writer=response.getWriter();
			writer.flush();
			writer.write(fittingPageService.find().get("description").toString());
			writer.close();
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			request.setAttribute("error", Results.BUSY);
		}
	}
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String fitting(HttpServletRequest request,HttpServletResponse response) {
		//配件归类分类
		request.setAttribute("fittingCategory", fittingCliService.getFittingCategory());
		//获取配件用途
		request.setAttribute("fittingUse", fittingCliService.getFittingUse());
		//获取配件用途以及相应品牌
		request.setAttribute("fittingUseAndBrand", fittingCliService.getFittingUseAndBrand());
		//获取配件归类以及相应品牌
		request.setAttribute("fittingCategoryAndBrand", fittingCliService.getFittingCategoryAndBrand());


		//配件归类分类
		request.setAttribute("fittingCategory", fittingCliService.getFittingCategory());
		//获取配件用途以及相应品牌
		request.setAttribute("fittingUse", fittingCliService.getFittingUse());
		//获取配件用途以及相应品牌
		request.setAttribute("fittingBrand", fittingCliService.getFittingBrand());
		//获取设备类型
		request.setAttribute("deviceTypeList",productService.getDeviceType());

		return "/client/fitting/fitting";
	}
	@RequestMapping(value = "/fittingSelect", method = RequestMethod.GET)
	public String fittingSelect(HttpServletRequest request,HttpServletResponse response) {
		//配件归类分类
		request.setAttribute("fittingCategory", fittingCliService.getFittingCategory());
		//获取配件用途以及相应品牌
		request.setAttribute("fittingUse", fittingCliService.getFittingUse());
		//获取配件用途以及相应品牌
		request.setAttribute("fittingBrand", fittingCliService.getFittingBrand());
		//获取设备类型
		request.setAttribute("deviceTypeList",productService.getDeviceType());
		return "/client/fitting/fitting_search";
	}
	/**
	 *<p>方法描述</P>
	 * Date	2013-12-26 下午10:10:03
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getFittingByFittingCategory", method = RequestMethod.GET)
	public String getFittingByFittingCategory(HttpServletRequest request,HttpServletResponse response) {
		String deviceTypeUseId=request.getParameter("deviceTypeUseId");
		String deviceTypeSortId=request.getParameter("deviceTypeSortId");
		String brand=Charset.toUTF(request.getParameter("brand"));
		String start=request.getParameter("start");
		String pageSize=request.getParameter("pageSize");
		Results results=fittingCliService.getFittingByFittingCategory(new Page(Integer.valueOf(start), Integer.valueOf(pageSize)), deviceTypeUseId, deviceTypeSortId,brand );
		
		request.setAttribute("results", results);
		request.setAttribute("brand", brand);
		
		//组装URL
		StringBuffer url=new StringBuffer("/client/fitting/getFittingByFittingCategory?");
		if(deviceTypeUseId!=null&&!deviceTypeUseId.equals("")){
			if(url.toString().contains("=")){
				url.append("&deviceTypeUseId="+deviceTypeUseId);
			}else{
				url.append("deviceTypeUseId="+deviceTypeUseId);
			}
		}
		if(deviceTypeSortId!=null&&!deviceTypeSortId.equals("")){
			if(url.toString().contains("=")){
				url.append("&deviceTypeSortId="+deviceTypeSortId);
			}else{
				url.append("deviceTypeSortId="+deviceTypeSortId);
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


		//配件归类分类
		request.setAttribute("fittingCategory", fittingCliService.getFittingCategory());
		//获取配件用途以及相应品牌
		request.setAttribute("fittingUse", fittingCliService.getFittingUse());
		//获取配件用途以及相应品牌
		request.setAttribute("fittingBrand", fittingCliService.getFittingBrand());
		//获取设备类型
		request.setAttribute("deviceTypeList",productService.getDeviceType());

		return "/client/fitting/fittingInfo";
	}
	/**
	 *<p>方法描述</P>
	 * Date	2013-12-26 下午10:10:03
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/findFitting", method = RequestMethod.GET)
	public String findFitting(HttpServletRequest request,HttpServletResponse response) {

		String brand=Charset.toUTF(request.getParameter("brand"));
		String fittingName=Charset.toUTF(request.getParameter("fittingName"));
		String fittingNO=Charset.toUTF(request.getParameter("fittingNO"));
		String fittingDevice=Charset.toUTF(request.getParameter("fittingDevice"));
		String start=request.getParameter("start");
		String pageSize=request.getParameter("pageSize");

		Results results=fittingCliService.findFitting(new Page(Integer.valueOf(start), Integer.valueOf(pageSize)),brand,fittingName,fittingNO,fittingDevice);
		request.setAttribute("results", results);
		request.setAttribute("brand", brand);
		request.setAttribute("fittingName", fittingName);
		request.setAttribute("fittingNO", fittingNO);
		request.setAttribute("fittingDevice", fittingDevice);

		request.setAttribute("brand", brand);

		//组装URL
		StringBuffer url=new StringBuffer("/client/fitting/findFitting?");
		if(fittingName!=null&&!fittingName.equals("")){
			if(url.toString().contains("=")){
				url.append("&fittingName="+fittingName);
			}else{
				url.append("fittingName="+fittingName);
			}
		}
		if(fittingNO!=null&&!fittingNO.equals("")){
			if(url.toString().contains("=")){
				url.append("&fittingNO="+fittingNO);
			}else{
				url.append("fittingNO="+fittingNO);
			}
		}
		if(fittingDevice!=null&&!fittingDevice.equals("")){
			if(url.toString().contains("=")){
				url.append("&fittingDevice="+fittingDevice);
			}else{
				url.append("fittingDevice="+fittingDevice);
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

		//配件归类分类
		request.setAttribute("fittingCategory", fittingCliService.getFittingCategory());
		//获取配件用途以及相应品牌
		request.setAttribute("fittingUse", fittingCliService.getFittingUse());
		//获取配件用途以及相应品牌
		request.setAttribute("fittingBrand", fittingCliService.getFittingBrand());
		//获取设备类型
		request.setAttribute("deviceTypeList",productService.getDeviceType());

		return "/client/fitting/fittingInfo";
	}

	/**
	 *产品查询 设备名称、品牌
	 */
	@RequestMapping(value = "/getFittingByFittingId/{id}", method = RequestMethod.GET)
	public String getFittingByFittingId(@PathVariable String id,HttpServletRequest request) {

		request.setAttribute("fitting", fittingCliService.getFittingByFittingId(Integer.parseInt(id)));

		return "/client/fitting/fittingInfoBase";
	}

}
