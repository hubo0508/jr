package com.jr.client.learn.controller;

import java.util.List;
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

import com.jr.client.learn.service.LearnCliService;
import com.jr.core.BaseController;
import com.jr.core.Page;
import com.jr.core.Results;
import com.jr.util.Charset;
import com.jr.util.Json;

/**
 * 学习中心组件
 */
@Controller
@RequestMapping("/client")
public class LearnCliController extends BaseController {

	private Log log = LogFactory.getLog(LearnCliController.class);

	@Autowired
	private LearnCliService learnCliService;

	/**
	 * 根据客户端主页查询所有显示数据
	 */
	@RequestMapping(value = "/learn")
	public String learn(HttpServletRequest request) {
		try {
			request.setAttribute("listAllToIndex", learnCliService
					.listAllToIndex());
		} catch (RuntimeException e) {
			log.error(e.getMessage(), e);
		}
		return "/client/learn";
	}

	/**
	 */
	@RequestMapping(value = "/learn/keyword", method = RequestMethod.GET)
	public String keyword(HttpServletResponse response,
			HttpServletRequest request, @RequestParam
			int start, @RequestParam
			int pageSize, @RequestParam
			String keyword) {
		
		if(StringUtils.isEmpty(keyword)){
			return "redirect:/client/learn";
		}
		
		keyword = Charset.toUTF(keyword);
		 
		try {
			List<Map<String, Object>> lmc = learnCliService.listMajorCategory();

			Results doc = learnCliService.listKeyword(
					new Page(start, pageSize), keyword);

			request.setAttribute("thisPage", doc.getThisPage());
			request.setAttribute("pageSize", doc.getPageSize());
			request.setAttribute("totalSize", doc.getTotalSize());

			request.setAttribute("listKeyword", doc);
			request.setAttribute("listAllToIndex", lmc);
			
			request.setAttribute("keyword", keyword);

		} catch (Throwable e) {
			log.error(e.getMessage(), e);
		}

		return "/client/learn";
	}

	/**
	 * 文档查询
	 * 
	 * @param dtmid
	 *            文档类型ID
	 */
	@RequestMapping(value = "/learn/more", method = RequestMethod.GET)
	public String more(HttpServletResponse response,
			HttpServletRequest request, @RequestParam
			int start, @RequestParam
			int pageSize, @RequestParam
			int dtmid) {

		try {
			List<Map<String, Object>> lmc = learnCliService.listMajorCategory();
			for (int i = 0; i < lmc.size(); i++) {
				Map<String, Object> mc = lmc.get(i);
				int id = (Integer) mc.get("id");

				if (dtmid == id) {
					mc.put("listSmallCategoryBy", learnCliService
							.listSmallCategoryBy(id));

					Results doc = learnCliService.listDocumentByMC(new Page(
							start, pageSize), id);

					request.setAttribute("thisPage", doc.getThisPage());
					request.setAttribute("pageSize", doc.getPageSize());
					request.setAttribute("totalSize", doc.getTotalSize());

					mc.put("listDocumentByMC", doc);

					mc.put("mark", true);
				} else {
					mc.put("mark", false);
				}
			}

			request.setAttribute("listAllToIndex", lmc);
			request.setAttribute("dtmid", dtmid);

		} catch (Throwable e) {
			log.error(e.getMessage(), e);
		}

		return "/client/learn";
	}

	/**
	 * 文档查询
	 * 
	 * @param majorCategoryId
	 *            文档类型ID
	 */
	@RequestMapping(value = "/learn/listDocumentByMC", method = RequestMethod.POST)
	public void listDocumentByMC(HttpServletResponse response, @RequestParam
	int start, @RequestParam
	int pageSize, @RequestParam
	int id) {

		try {
			Results r = learnCliService.listDocumentByMC(new Page(start,
					pageSize), id);
			outJsonString(response, Json.toJson(r));
		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}

	/**
	 * 文档查询
	 * 
	 * @param dtsid
	 *            文档属性类型ID
	 * @param dtmid
	 *            文档类型ID
	 */
	@RequestMapping(value = "/learn/listDocumentBySC", method = RequestMethod.POST)
	public void listDocumentBySC(HttpServletResponse response, @RequestParam
	int start, @RequestParam
	int pageSize, @RequestParam
	int dtsid, @RequestParam
	int dtmid) {

		try {
			Results r = learnCliService.listDocumentBy(
					new Page(start, pageSize), dtsid, dtmid);
			outJsonString(response, Json.toJson(r));

		} catch (Throwable e) {
			log.error(e.getMessage(), e);
			outJsonString(response, Json.oJson(Results.BUSY, false));
		}
	}
}
